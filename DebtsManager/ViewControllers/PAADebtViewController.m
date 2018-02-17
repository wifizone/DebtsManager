//
//  PAADebtViewController.m
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import "PAADebtViewController.h"
#import "PAACoreDataManager.h"
#import "PAANetworkService.h"
#import "PAAFriend.h"
#import "Masonry.h"
#import "PAADebtView.h"


typedef NS_ENUM(NSInteger, PAARightNavButtonTags)
{
    PAARightNavButtonTagAdd = 1,
    PAARightNavButtonTagEdit = 2
};


static CGFloat const PAAStatusAndNavigationBarHeight = 64.0;
static CGFloat const PAAScrollableDebtViewContent = 750.0;
static CGFloat const PAADebtViewOffset = 0;
static NSString * const PAARightNavButtonAddText = @"Добавить";
static NSString * const PAARightNavButtonEditText = @"Изменить";


@interface PAADebtViewController () <PAANetworkServiceOutputProtocol, UITextFieldDelegate>

@property (nonatomic, strong) PAAFriendListViewController *friendListViewController;
@property (nonatomic, strong) PAADebtView *debtView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end


@implementation PAADebtViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
}


#pragma mark - PAAFriendListViewControllerDelegate

- (void)friendListViewController:(PAAFriendListViewController *)controller didChooseFriend:(FriendPAA *)friendModel
{
    self.currentDebt.friend = friendModel;
    [self.debtView.textFieldName setText:friendModel.name];
    [self.debtView.textFieldSurname setText:friendModel.surname];
    [self loadPersonPhoto:friendModel.photoUrl];
    NSLog(@"%@, %@, %@", friendModel.name, friendModel.surname, friendModel.photoUrl);
    [[self navigationController] popViewControllerAnimated:YES];
}


#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self openFriendListViewController];
    return NO;
}

#pragma mark - LoadingImage

- (void)loadingIsDoneWithImageReceived:(NSData *)personPhoto
{
    self.debtView.personPhotoView.image = [UIImage imageWithData:personPhoto];
}

- (void)loadPersonPhoto: (NSString *)urlString
{
    PAANetworkService *networkService = [PAANetworkService new];
    networkService.output = self;
    [networkService loadImageOfPerson:urlString];
}


#pragma mark - Navigation

- (void)openFriendListViewController
{
    self.friendListViewController = [PAAFriendListViewController new];
    self.friendListViewController.delegate = self;
    [self.navigationController pushViewController:self.friendListViewController animated:YES];
}

- (BOOL)isUserInputOk
{
    if (self.debtView.dueDatePicker.date < self.debtView.debtAppearedDatePicker.date)
    {
        [self popupAlertMessageWithText:@"Дата возврата долга должна быть больше даты его появления"];
        return NO;
    }
    if ((self.debtView.textFieldName.text.length == 0) || (self.debtView.textFieldSurname.text.length == 0))
    {
        [self popupAlertMessageWithText:@"Сначала выберите друга"];
        return NO;
    }
    if ((self.debtView.textFieldSum.text.length > 10))
    {
        [self popupAlertMessageWithText:@"Максимальная сумма долга десятизначная"];
        return NO;
    }
    return YES;
}

- (void)addDebt:(UIBarButtonItem *)rightBarButton
{
    PAACoreDataManager *coreDataManager = [PAACoreDataManager sharedCoreDataManager];
    if ([self isUserInputOk])
    {
        if (rightBarButton.tag == PAARightNavButtonTagAdd)
        {
            [coreDataManager insertDebtObjectWithName:self.debtView.textFieldName.text
                                              surname:self.debtView.textFieldSurname.text
                                       photoUrlString:self.currentDebt.friend.photoUrl
                                              debtSum:[self.debtView.textFieldSum.text doubleValue]
                                          debtDueDate:self.debtView.dueDatePicker.date
                                     debtAppearedDate:self.debtView.debtAppearedDatePicker.date];
        }
        else
        {
            [coreDataManager editObject:self.currentDebt
                                   name:self.currentDebt.friend.name
                                surname:self.currentDebt.friend.surname
                         photoUrlString:self.currentDebt.friend.photoUrl
                                debtSum:[self.debtView.textFieldSum.text doubleValue]
                            debtDueDate:self.debtView.dueDatePicker.date
                       debtAppearedDate:self.debtView.debtAppearedDatePicker.date];
        }
        [[self navigationController] popViewControllerAnimated:YES];
    }
}


#pragma mark - UI

- (void)popupAlertMessageWithText:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ошибка"
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDefault
                                                        handler:nil];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)addGestureRecognizer
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard
{
    [self.debtView.textFieldName resignFirstResponder];
    [self.debtView.textFieldSurname resignFirstResponder];
    [self.debtView.textFieldSum resignFirstResponder];
}

- (void)prepareUI
{
    [self addDebtView];
    [self addNavigationRightItem];
    [self addGestureRecognizer];
    if (self.currentDebt != nil)
    {
        [self populateDebtFields];
    }
    [self updateViewConstraints];
}

- (void)addDebtView
{
    self.scrollView = [UIScrollView new];
    [self.view addSubview:self.scrollView];
    self.debtView = [[PAADebtView alloc] init];
    [self.scrollView addSubview:self.debtView];
    self.debtView.textFieldName.delegate = self;
    self.debtView.textFieldSurname.delegate = self;
}

- (void)addNavigationRightItem
{
    NSString *barButtonTitle;
    NSInteger barButtonTag;
    if (self.addFeatureIsNeeded)
    {
        barButtonTitle = PAARightNavButtonAddText;
        barButtonTag = PAARightNavButtonTagAdd;
    }
    else
    {
        barButtonTitle = PAARightNavButtonEditText;
        barButtonTag = PAARightNavButtonTagEdit;
    }
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:barButtonTitle
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(addDebt:)];
    [rightItem setTag:barButtonTag];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)populateDebtFields
{
    [self loadPersonPhoto:self.currentDebt.friend.photoUrl];
    [self.debtView.textFieldName setText:self.currentDebt.friend.name];
    [self.debtView.textFieldSurname setText:self.currentDebt.friend.surname];
    NSString *debtSum = [NSString stringWithFormat:@"%2.f", self.currentDebt.sum];
    [self.debtView.textFieldSum setText:debtSum];
    [self.debtView.debtAppearedDatePicker setDate:self.currentDebt.appearedDate];
    [self.debtView.dueDatePicker setDate:self.currentDebt.dueDate];
}

-(void)updateViewConstraints
{
    UIEdgeInsets padding = UIEdgeInsetsMake(PAAStatusAndNavigationBarHeight,
                                            PAADebtViewOffset, PAADebtViewOffset, PAADebtViewOffset);
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(padding);
    }];
    
    [self.debtView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.height.mas_equalTo(PAAScrollableDebtViewContent);
        make.right.and.left.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

@end
