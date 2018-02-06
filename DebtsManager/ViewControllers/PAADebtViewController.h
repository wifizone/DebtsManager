//
//  PAADebtViewController.h
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PAADebtViewController : UIViewController

@property (nonatomic, strong) Debt *currentDebt;

- (instancetype)initWithAddFeature;
- (instancetype)initWithEditFeature;

@end
