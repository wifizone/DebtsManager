//
//  PAADebtView.h
//  DebtsManager
//
//  Created by Антон Полуянов on 11/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface PAADebtView : UIView

@property (nonatomic, strong) UITextField *textFieldName;
@property (nonatomic, strong) UITextField *textFieldSurname;
@property (nonatomic, strong) UITextField *textFieldSum;
@property (nonatomic, strong) UIDatePicker *dueDatePicker;
@property (nonatomic, strong) UIDatePicker *debtAppearedDatePicker;
@property (nonatomic, strong) UIImageView *personPhotoView;

- (instancetype)init;

@end
