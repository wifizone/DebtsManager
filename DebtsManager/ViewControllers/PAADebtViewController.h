//
//  PAADebtViewController.h
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "DebtPAA+CoreDataClass.h"
#import "PAAFriendListViewController.h"


@interface PAADebtViewController : UIViewController <PAAFriendListViewControllerDelegate>

@property (nonatomic, assign) BOOL addFeatureIsNeeded;
@property (nonatomic, strong) DebtPAA *currentDebt;

@end
