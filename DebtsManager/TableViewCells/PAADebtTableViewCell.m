//
//  PAADebtTableViewCell.m
//  DebtsManager
//
//  Created by Антон Полуянов on 30/01/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import "PAADebtTableViewCell.h"

static CGFloat const PAAOffset = 15.0;
static CGFloat const PAAImageWidth = 50.0;

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
    
    [self setupConstraints];
    
    return self;
}

- (void)setupConstraints
{
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.personPhotoImage
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1.0
                                                                  constant:PAAOffset]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.personPhotoImage
                                                                 attribute:NSLayoutAttributeWidth
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1.0
                                                                  constant:PAAImageWidth]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.personPhotoImage
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:PAAOffset]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.personPhotoImage
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:-PAAOffset]];
    
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.personNameLabel
                                                                 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier: 1.0
                                                                  constant:PAAOffset]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.personNameLabel
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.personPhotoImage
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier: 1.0
                                                                  constant:PAAOffset]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.personNameLabel
                                                                 attribute:NSLayoutAttributeRight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier: 1.0
                                                                  constant:-PAAOffset]];
    
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.sumToRepayLabel
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.personPhotoImage
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier: 1.0
                                                                  constant:PAAOffset]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.sumToRepayLabel
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.personNameLabel
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier: 1.0
                                                                  constant:10.0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.sumToRepayLabel
                                                                 attribute:NSLayoutAttributeRight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier: 1.0
                                                                  constant:-PAAOffset]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.dueDateLabel
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.personPhotoImage
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier: 1.0
                                                                  constant:PAAOffset]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.dueDateLabel
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.sumToRepayLabel
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier: 1.0
                                                                  constant:10.0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.dueDateLabel
                                                                 attribute:NSLayoutAttributeRight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier: 1.0
                                                                  constant:-PAAOffset]];
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
