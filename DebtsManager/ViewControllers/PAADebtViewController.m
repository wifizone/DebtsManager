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

static CGFloat const PAAStatusAndNavigationBarHeight = 64.0;
static CGFloat const PAAScrollableDebtViewContent = 750.0;
static CGFloat const PAADebtViewOffset = 0;
static NSString * const PAARightNavButtonAddText = @"Добавить";
static NSString * const PAARightNavButtonEditText = @"Изменить";


@interface PAADebtViewController () <PAANetworkServiceOutputProtocol, UITextFieldDelegate>

@property (nonatomic, strong) PAAFriend *friendModel;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - PAAFriendListViewControllerDelegate

- (void)friendListViewController:(PAAFriendListViewController *)controller didChooseFriend:(PAAFriend *)friendModel
{
    self.friendModel = friendModel;
    [self.debtView.textFieldName setText:friendModel.name];
    [self.debtView.textFieldSurname setText:friendModel.surname];
    [self loadPersonPhoto:friendModel.personPhotoUrlString];
    [[self navigationController] popViewControllerAnimated:YES];
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

- (void)addDebt:(UIBarButtonItem *)rightBarButton
{
    if (rightBarButton.title == PAARightNavButtonAddText)
    {
        [[PAACoreDataManager sharedCoreDataManager] insertDebtObjectWithName:self.debtView.textFieldName.text
                                                                     surname:self.debtView.textFieldSurname.text
                                                              photoUrlString:self.friendModel.personPhotoUrlString
                                                                     debtSum:[self.debtView.textFieldSum.text doubleValue]
                                                                 debtDueDate:self.debtView.dueDatePicker.date
                                                            debtAppearedDate:self.debtView.debtAppearedDatePicker.date];
    }
    else
    {
        [[PAACoreDataManager sharedCoreDataManager] editObject:self.currentDebt
                                                          name:self.debtView.textFieldName.text
                                                       surname:self.debtView.textFieldSurname.text
                                                photoUrlString:self.currentDebt.personPhotoUrl
                                                       debtSum:[self.debtView.textFieldSum.text doubleValue]
                                                   debtDueDate:self.debtView.dueDatePicker.date
                                              debtAppearedDate:self.debtView.debtAppearedDatePicker.date];
    }
    [[self navigationController] popViewControllerAnimated:YES];
}


#pragma mark - Keyboard

-(void)addGestureRecognizer
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard
{
    [self.debtView.textFieldName resignFirstResponder];
    [self.debtView.textFieldSurname resignFirstResponder];
    [self.debtView.textFieldSum resignFirstResponder];
}

#pragma mark - UI

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
    [self.debtView.chooseFriendButton addTarget:self action:@selector(openFriendListViewController) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addNavigationRightItem
{
    NSString *barButtonTitle = self.addFeatureIsNeeded ? PAARightNavButtonAddText : PAARightNavButtonEditText;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:barButtonTitle style:UIBarButtonItemStylePlain target:self action:@selector(addDebt:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)populateDebtFields
{
    [self loadPersonPhoto:self.currentDebt.personPhotoUrl];
    [self.debtView.textFieldName setText:self.currentDebt.personName];
    [self.debtView.textFieldSurname setText:self.currentDebt.personSurname];
    NSString *debtSum = [NSString stringWithFormat:@"%2.f", self.currentDebt.debtSum];
    [self.debtView.textFieldSum setText:debtSum];
    [self.debtView.debtAppearedDatePicker setDate:self.currentDebt.debtAppearedDate];
    [self.debtView.dueDatePicker setDate:self.currentDebt.debtDueDate];
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
