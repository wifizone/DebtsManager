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

static CGFloat const PAATextFieldHeight = 50.0;
static CGFloat const PAAImageOffset = 10.0;
static CGFloat const PAAImageWidth = 100.0;
static CGFloat const PAAStatusAndNavigationBarHeight = 64.0;
static CGFloat const PAADatePickerHeight = 150;
static CGFloat const PAAAddButtonHeight = 50;
static NSString * const PAAbuttonAddText = @"Добавить";
static NSString * const PAAbuttonEditText = @"Изменить";
static NSString * const PAANavigationBarRightButtonText = @"Друзья";


@interface PAADebtViewController () <PAANetworkServiceOutputProtocol, UITextFieldDelegate>

@property (nonatomic, strong) UIButton *addUIButton;
@property (nonatomic, strong) PAAFriend *friendModel;
@property (nonatomic, strong) PAAFriendListViewController *friendListViewController;

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

- (void)updateViewConstraints
{
    [self setupImageViewConstraints];
    [self setupTextFieldNameConstraints];
    [self setupTextFieldSurnameConstraints];
    [self setupTextFieldSumConstraints];
    [self setupDueDatePickerConstraints];
    [self setupDateAppearedPickerConstraints];
    [self setupAddButtonConstraints];
    [super updateViewConstraints];
}


#pragma mark - PAAFriendListViewControllerDelegate

- (void)friendListViewController:(PAAFriendListViewController *)controller didChooseFriend:(PAAFriend *)friendModel
{
    self.friendModel = friendModel;
    [self.textFieldName setText:friendModel.name];
    [self.textFieldSurname setText:friendModel.surname];
    [self loadPersonPhoto:friendModel.personPhotoUrlString];
    [[self navigationController] popViewControllerAnimated:YES];
}


#pragma mark - LoadingImage

- (void)loadingIsDoneWithImageReceived:(NSData *)personPhoto
{
    self.personPhotoView.image = [UIImage imageWithData:personPhoto];
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

- (void)addDebt:(UIButton *)button  //добавить сумму
{
    if (button.titleLabel.text == PAAbuttonAddText)
    {
        [[PAACoreDataManager sharedCoreDataManager] insertDebtObjectWithName:self.textFieldName.text
                                                                     surname:self.textFieldSurname.text
                                                              photoUrlString:self.friendModel.personPhotoUrlString
                                                                     debtSum:[self.textFieldSum.text doubleValue]
                                                                 debtDueDate:self.dueDatePicker.date
                                                            debtAppearedDate:self.debtAppearedDatePicker.date];
    }
    else
    {
        [[PAACoreDataManager sharedCoreDataManager] editObject:self.currentDebt
                                                          name:self.textFieldName.text
                                                       surname:self.textFieldSurname.text
                                                photoUrlString:self.currentDebt.personPhotoUrl
                                                       debtSum:[self.textFieldSum.text doubleValue]
                                                   debtDueDate:self.dueDatePicker.date
                                              debtAppearedDate:self.debtAppearedDatePicker.date];
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
    [self.textFieldName resignFirstResponder];
    [self.textFieldSurname resignFirstResponder];
    [self.textFieldSum resignFirstResponder];
}

#pragma mark - UI

- (void)prepareUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNavigationRightItem];
    [self addImage];
    [self addNameTextField];
    [self addSurnameTextField];
    [self addGestureRecognizer];
    [self addSumTextField];
    [self addDueDatePicker];
    [self addDebtAppearedDatePicker];
    [self addAddUIButton];
    if (self.currentDebt != nil)
    {
        [self populateDebtFields];
    }
    [self updateViewConstraints];
}

- (void)addImage
{
    UIImage *personImage = [UIImage imageNamed:@"ok.png"];
    self.personPhotoView = [[UIImageView alloc] initWithImage:personImage];
    self.personPhotoView.image = personImage;
    [self.view addSubview:self.personPhotoView];
}

- (void)addNavigationRightItem
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Выбрать из друзей" style:UIBarButtonItemStylePlain target:self action:@selector(openFriendListViewController)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)addNameTextField
{
    self.textFieldName = [UITextField new];
    [self.textFieldName setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:self.textFieldName];
}

- (void)addSurnameTextField
{
    self.textFieldSurname = [UITextField new];
    [self.textFieldSurname setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:self.textFieldSurname];
}

- (void)addSumTextField
{
    self.textFieldSum = [UITextField new];
    [self.textFieldSum setBorderStyle:UITextBorderStyleRoundedRect];
    [self.textFieldSum setKeyboardType:UIKeyboardTypeNumberPad];
    [self.view addSubview:self.textFieldSum];
}

- (void)addDueDatePicker
{
    self.dueDatePicker = [UIDatePicker new];
    [self.view addSubview:self.dueDatePicker];
}

- (void)addDebtAppearedDatePicker
{
    self.debtAppearedDatePicker = [UIDatePicker new];
    [self.view addSubview:self.debtAppearedDatePicker];
}

- (void)addAddUIButton
{
    self.addUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addUIButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (self.addFeatureIsNeeded)
    {
        [self.addUIButton setTitle:PAAbuttonAddText forState:UIControlStateNormal];
    }
    else
    {
        [self.addUIButton setTitle:PAAbuttonEditText forState:UIControlStateNormal];
    }
    [self.addUIButton addTarget:self action:@selector(addDebt:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addUIButton];
}

- (void)populateDebtFields
{
    [self loadPersonPhoto:self.currentDebt.personPhotoUrl];
    [self.textFieldName setText:self.currentDebt.personName];
    [self.textFieldSurname setText:self.currentDebt.personSurname];
    NSString *debtSum = [NSString stringWithFormat:@"%2.f", self.currentDebt.debtSum];
    [self.textFieldSum setText:debtSum];
    [self.debtAppearedDatePicker setDate:self.currentDebt.debtAppearedDate];
    [self.dueDatePicker setDate:self.currentDebt.debtDueDate];
}

#pragma mark - ViewConstraints

- (void)setupImageViewConstraints
{
    [self.personPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(PAAImageOffset + PAAStatusAndNavigationBarHeight);
        make.height.mas_equalTo(PAAImageWidth);
        make.width.mas_equalTo(PAAImageWidth);
        make.centerX.equalTo(self.view);
    }];
}

- (void)setupTextFieldNameConstraints
{
    [self.textFieldName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.personPhotoView.mas_bottom).with.offset(PAAImageOffset);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(PAATextFieldHeight);
    }];
}

- (void)setupTextFieldSurnameConstraints
{
    [self.textFieldSurname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldName.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.height.mas_equalTo(PAATextFieldHeight);
    }];
}

- (void)setupTextFieldSumConstraints
{
    [self.textFieldSum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldSurname.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.height.mas_equalTo(PAATextFieldHeight);
    }];
}

- (void)setupDueDatePickerConstraints
{
    [self.dueDatePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldSum.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.height.mas_equalTo(PAADatePickerHeight);
    }];
}

- (void)setupDateAppearedPickerConstraints
{
    [self.debtAppearedDatePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dueDatePicker.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.height.mas_equalTo(PAADatePickerHeight);
    }];
}

- (void)setupAddButtonConstraints
{
    [self.addUIButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(PAAAddButtonHeight);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
    }];
}

@end
