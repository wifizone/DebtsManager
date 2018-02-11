//
//  PAADebtTableViewCell.m
//  DebtsManager
//
//  Created by Антон Полуянов on 30/01/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import "PAADebtTableViewCell.h"
#import "Masonry.h"

static CGFloat const PAAImageWidth = 100.0;
static CGFloat const PAALabelHeight = 30.0;

@implementation PAADebtTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _personPhotoImage = [UIImageView new];
        _personNameLabel = [UILabel new];
        _sumToRepayLabel = [UILabel new];
        _dueDateLabel = [UILabel new];
        
        _personPhotoImage.translatesAutoresizingMaskIntoConstraints = NO;
        _personNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _sumToRepayLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _dueDateLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.contentView addSubview:_personPhotoImage];
        [self.contentView addSubview:_personNameLabel];
        [self.contentView addSubview:_sumToRepayLabel];
        [self.contentView addSubview:_dueDateLabel];
    }
    
    [self updateConstraints];
    
    return self;
}

- (void)updateConstraints
{
    UIView *superview = self;
    UIEdgeInsets imagePadding = UIEdgeInsetsMake(10, 10, -10, 0);
    UIEdgeInsets labelNamePadding = UIEdgeInsetsMake(10, 10, -5, -10);
    UIEdgeInsets labelSumPadding = UIEdgeInsetsMake(5, 10, -5, -10);
    UIEdgeInsets labelDatePadding = UIEdgeInsetsMake(5, 10, -10, -10);
    
    [self.personPhotoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superview.mas_left).with.offset(imagePadding.left);
        make.top.equalTo(superview.mas_top).with.offset(imagePadding.top);
        make.bottom.equalTo(superview.mas_bottom).with.offset(imagePadding.bottom);
        make.width.mas_equalTo(PAAImageWidth);
    }];
    
    [self.personNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.personPhotoImage.mas_right).with.offset(labelNamePadding.left);
        make.right.equalTo(superview.mas_right).with.offset(labelNamePadding.right);
        make.top.equalTo(superview.mas_top).with.offset(labelNamePadding.top);
        make.bottom.equalTo(self.sumToRepayLabel.mas_top).with.offset(labelNamePadding.bottom);
        make.height.mas_equalTo(PAALabelHeight);
    }];
    
    [self.sumToRepayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.personPhotoImage.mas_right).with.offset(labelSumPadding.left);
        make.right.equalTo(superview.mas_right).with.offset(labelSumPadding.right);
        make.top.equalTo(self.personNameLabel.mas_bottom).with.offset(labelSumPadding.top);
        make.bottom.equalTo(self.dueDateLabel.mas_top).with.offset(labelSumPadding.bottom);
        make.height.mas_equalTo(PAALabelHeight);
    }];
    
    [self.dueDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.personPhotoImage.mas_right).with.offset(labelDatePadding.left);
        make.right.equalTo(superview.mas_right).with.offset(labelDatePadding.right);
        make.top.equalTo(self.sumToRepayLabel.mas_bottom).with.offset(labelDatePadding.top);
        make.bottom.equalTo(superview.mas_bottom).with.offset(labelDatePadding.bottom);
        make.height.mas_equalTo(PAALabelHeight);
    }];
    
    [super updateConstraints];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
