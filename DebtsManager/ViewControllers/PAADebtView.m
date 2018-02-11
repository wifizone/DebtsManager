//
//  PAADebtView.m
//  DebtsManager
//
//  Created by Антон Полуянов on 11/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import "PAADebtView.h"
#import "Masonry.h"

static NSString * const PAAPlaceHolderImageName = @"ok.png";
static NSString * const PAAbuttonAddText = @"Добавить";
static NSString * const PAAbuttonEditText = @"Изменить";
static NSString * const PAANavigationBarRightButtonText = @"Друзья";
static NSString * const PAALabelDebtAppearedText = @"Занял:";
static NSString * const PAALabelDebtDueDateText = @"Вернуть деньги:";
static CGFloat const PAATextFieldHeight = 40.0;
static CGFloat const PAAImageOffset = 10.0;
static CGFloat const PAAImageWidth = 100.0;
static CGFloat const PAADatePickerHeight = 162.0;
static CGFloat const PAAAddEditButtonHeight = 40.0;
static CGFloat const PAALabelHeight = 20.0;

@interface PAADebtView()

@property (nonatomic, strong) UILabel *debtAppearedDateLabel;
@property (nonatomic, strong) UILabel *debtDueDateLabel;

@end

@implementation PAADebtView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self prepareUI];
    }
    return self;
}


#pragma mark - UI

- (void)prepareUI
{
    self.backgroundColor = [UIColor whiteColor];
    [self addImage];
    [self addNameTextField];
    [self addSurnameTextField];
    [self addSumTextField];
    [self addDueDatePicker];
    [self addDebtAppearedDatePicker];
    [self addLabels];
    [self addAddUIButton];
    [self updateConstraints];
}

- (void)addImage
{
    UIImage *personImage = [UIImage imageNamed:PAAPlaceHolderImageName];
    _personPhotoView = [[UIImageView alloc] initWithImage:personImage];
    _personPhotoView.image = personImage;
    [self addSubview:_personPhotoView];
}

- (void)addNameTextField
{
    _textFieldName = [UITextField new];
    [_textFieldName setBorderStyle:UITextBorderStyleRoundedRect];
    [self addSubview:_textFieldName];
}

- (void)addSurnameTextField
{
    _textFieldSurname = [UITextField new];
    [_textFieldSurname setBorderStyle:UITextBorderStyleRoundedRect];
    [self addSubview:_textFieldSurname];
}

- (void)addSumTextField
{
    _textFieldSum = [UITextField new];
    [_textFieldSum setBorderStyle:UITextBorderStyleRoundedRect];
    [_textFieldSum setKeyboardType:UIKeyboardTypeNumberPad];
    [self addSubview:_textFieldSum];
}

- (void)addDueDatePicker
{
    _dueDatePicker = [UIDatePicker new];
    [self addSubview:_dueDatePicker];
}

- (void)addDebtAppearedDatePicker
{
    _debtAppearedDatePicker = [UIDatePicker new];
    [self addSubview:_debtAppearedDatePicker];
}

- (void)addLabels
{
    self.debtAppearedDateLabel = [UILabel new];
    [self.debtAppearedDateLabel setText:PAALabelDebtAppearedText];
    self.debtDueDateLabel = [UILabel new];
    [self.debtDueDateLabel setText:PAALabelDebtDueDateText];
    [self addSubview:self.debtAppearedDateLabel];
    [self addSubview:self.debtDueDateLabel];
}

- (void)addAddUIButton
{
    _addUIButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addUIButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (_addFeatureIsNeeded)
    {
        [_addUIButton setTitle:PAAbuttonAddText forState:UIControlStateNormal];
    }
    else
    {
        [_addUIButton setTitle:PAAbuttonEditText forState:UIControlStateNormal];
    }
    [self addSubview:_addUIButton];
}


#pragma mark - ViewConstraints

- (void)updateConstraints
{
    [self setupImageViewConstraints];
    [self setupTextFieldNameConstraints];
    [self setupTextFieldSurnameConstraints];
    [self setupTextFieldSumConstraints];
    [self setupDebtDueDateLabel];
    [self setupDueDatePickerConstraints];
    [self setupDebtAppearedDateLabel];
    [self setupDateAppearedPickerConstraints];
    [self setupAddButtonConstraints];
    [super updateConstraints];
}

- (void)setupImageViewConstraints
{
    [self.personPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(PAAImageOffset);
        make.height.mas_equalTo(PAAImageWidth);
        make.width.mas_equalTo(PAAImageWidth);
        make.centerX.equalTo(self);
    }];
}

- (void)setupTextFieldNameConstraints
{
    [self.textFieldName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.personPhotoView.mas_bottom).with.offset(PAAImageOffset);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.height.mas_equalTo(PAATextFieldHeight);
    }];
}

- (void)setupTextFieldSurnameConstraints
{
    [self.textFieldSurname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldName.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.height.mas_equalTo(PAATextFieldHeight);
    }];
}

- (void)setupTextFieldSumConstraints
{
    [self.textFieldSum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldSurname.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.height.mas_equalTo(PAATextFieldHeight);
    }];
}

- (void)setupDebtDueDateLabel
{
    [self.debtDueDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldSum.mas_bottom);
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(PAALabelHeight);
    }];
}

- (void)setupDueDatePickerConstraints
{
    [self.dueDatePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.debtDueDateLabel.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.height.mas_equalTo(PAADatePickerHeight);
    }];
}

- (void)setupDebtAppearedDateLabel
{
    [self.debtAppearedDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dueDatePicker.mas_bottom);
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(PAALabelHeight);
    }];
}

- (void)setupDateAppearedPickerConstraints
{
    [self.debtAppearedDatePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.debtAppearedDateLabel.mas_bottom);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.height.mas_equalTo(PAADatePickerHeight);
    }];
}

- (void)setupAddButtonConstraints
{
    [self.addUIButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(PAAAddEditButtonHeight);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
    }];
}

@end
