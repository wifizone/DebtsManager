//
//  PAADebtViewController.h
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Debt+CoreDataClass.h"
#import "PAAFriendListViewController.h"

@interface PAADebtViewController : UIViewController <PAAFriendListViewControllerDelegate>

@property (nonatomic, strong) UITextField *textFieldName;
@property (nonatomic, strong) UITextField *textFieldSurname;
@property (nonatomic, strong) UIDatePicker *dueDatePicker;
@property (nonatomic, strong) UIDatePicker *debtAppearedDatePicker;
@property (nonatomic, strong) UIImageView *personPhotoView;
@property (nonatomic, strong) Debt *currentDebt;

- (instancetype)initWithAddFeature;
- (instancetype)initWithEditFeature;

@end
