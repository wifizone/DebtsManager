//
//  PAADebtViewController.m
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import "Debt+CoreDataClass.h"
#import "PAADebtViewController.h"
#import "PAAFriendListViewController.h"
#import "Masonry.h"

static CGFloat const PAAButtonHeight = 50.0;
static CGFloat const PAATextFieldHeight = 50.0;
static CGFloat const PAAImageOffset = 10.0;
static CGFloat const PAAImageWidth = 100.0;
static CGFloat const PAAStatusAndNavigationBarHeight = 64.0;
static CGFloat const PAADatePickerHeight = 150;

@interface PAADebtViewController ()

@property (nonatomic, strong) UITextField *textFieldName;
@property (nonatomic, strong) UITextField *textFieldSurname;
@property (nonatomic, strong) UIDatePicker *dueDatePicker;
@property (nonatomic, strong) UIDatePicker *debtAppearedDatePicker;
@property (nonatomic, strong) UIImageView *personPhotoView;
@property (nonatomic, strong) UIButton *chooseFromFriendListButton;


@end

@implementation PAADebtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareUI
{
    [self addButton];
    [self addImage];
    [self addNameTextField];
    [self addSurnameTextField];
    [self addDueDatePicker];
    [self addDebtAppearedDatePicker];
    [self updateViewConstraints];
}

- (void)addImage
{
    UIImage *personImage = [UIImage imageNamed:@"ok.png"];
    self.personPhotoView = [[UIImageView alloc] initWithImage:personImage];
    self.personPhotoView.image = personImage;
    [self.view addSubview:self.personPhotoView];
}

- (void)addButton
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

- (void)openFriendListViewController
{
    PAAFriendListViewController *friendListViewController = [PAAFriendListViewController new];
    [self.navigationController pushViewController:friendListViewController animated:YES];
}


#pragma mark - ViewConstraints

- (void)updateViewConstraints
{
    [self setupImageViewConstraints];
    [self setupTextFieldNameConstraints];
    [self setupTextFieldSurnameConstraints];
    [self setupDueDatePickerConstraints];
    [self setupDateAppearedPickerConstraints];
    [super updateViewConstraints];
}

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

@end
