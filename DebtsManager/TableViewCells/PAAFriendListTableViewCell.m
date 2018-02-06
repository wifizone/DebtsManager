//
//  PAAFriendListTableViewCell.m
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import "PAAFriendListTableViewCell.h"
#import "Masonry.h"

static CGFloat const PAAOffset = 15.0;
static CGFloat const PAAImageWidth = 50.0;

@implementation PAAFriendListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _personPhotoImage = [UIImageView new];
        _personNameLabel = [UILabel new];
        _personPhotoImage.translatesAutoresizingMaskIntoConstraints = NO;
        _personNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.contentView addSubview:_personPhotoImage];
        [self.contentView addSubview:_personNameLabel];
    }
    
    [self setupConstraints];
    
    return self;
}

- (void)setupConstraints
{
    
}


@end
