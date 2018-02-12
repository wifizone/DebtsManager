//
//  PAADebtTableViewCell.h
//  DebtsManager
//
//  Created by Антон Полуянов on 30/01/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface PAADebtTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *personPhotoImage;
@property (nonatomic, strong) UILabel *personNameLabel;
@property (nonatomic, strong) UILabel *sumToRepayLabel;
@property (nonatomic, strong) UILabel *dueDateLabel;

@end
