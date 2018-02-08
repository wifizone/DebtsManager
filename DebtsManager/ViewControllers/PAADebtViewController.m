//
//  PAADebtViewController.m
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import "PAADebtViewController.h"
#import "PAACoreDataManager.h"
#import "PAAFriend.h"
#import "Masonry.h"

static CGFloat const PAATextFieldHeight = 50.0;
static CGFloat const PAAImageOffset = 10.0;
static CGFloat const PAAImageWidth = 100.0;
static CGFloat const PAAStatusAndNavigationBarHeight = 64.0;
static CGFloat const PAADatePickerHeight = 150;
static CGFloat const PAAAddButtonHeight = 50;

@interface PAADebtViewController ()

@property (nonatomic, assign) BOOL addFeatureIsNeeded;
@property (nonatomic, strong) UIButton *addUIButton;
@property (nonatomic, strong) PAAFriend *friendModel;
@property (nonatomic, strong) PAAFriendListViewController *friendListViewController;

@end

@implementation PAADebtViewController


#pragma mark - Constructor

- (instancetype)initWithAddFeature
{
    self = [super init];
    if (self)
    {
        _addFeatureIsNeeded = YES;
    }
    return self;
}

- (instancetype)initWithEditFeature
{
    self = [super init];
    if (self)
    {
        _addFeatureIsNeeded = NO;
    }
    return self;
}

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
    [[self navigationController] popViewControllerAnimated:YES];
}


#pragma mark - Navigation

- (void)openFriendListViewController
{
    self.friendListViewController = [PAAFriendListViewController new];
    self.friendListViewController.delegate = self;
    [self.navigationController pushViewController:self.friendListViewController animated:YES];
}

- (void)addDebt  //добавить сумму
{
    [[PAACoreDataManager sharedCoreDataManager] insertDebtObjectWithName:self.textFieldName.text
                                                                 surname:self.textFieldSurname.text
                                                          photoUrlString:self.friendModel.personPhoto50UrlString
                                                                 debtSum:5000
                                                             debtDueDate:self.dueDatePicker.date
                                                        debtAppearedDate:self.debtAppearedDatePicker.date];
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - UI

- (void)prepareUI
{
    [self addNavigationRightItem];
    [self addImage];
    [self addNameTextField];
    [self addSurnameTextField];
    [self addDueDatePicker];
    [self addDebtAppearedDatePicker];
    if (self.addFeatureIsNeeded)
    {
        [self addAddUIButton];
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
    [self.addUIButton setTitle:@"Добавить" forState:UIControlStateNormal];
    [self.addUIButton addTarget:self action:@selector(addDebt) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addUIButton];
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

- (void)setupDueDatePickerConstraints
{
    [self.dueDatePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldSurname.mas_bottom);
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
