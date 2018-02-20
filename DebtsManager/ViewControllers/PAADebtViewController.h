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


/**
 * Вьюшка. Отображает все контролы, связанные с долгом
 */
@interface PAADebtViewController : UIViewController <PAAFriendListViewControllerDelegate>

/** Флаг. Указывает нужно ли создать или изменить долг */
@property (nonatomic, assign) BOOL addFeatureIsNeeded;

/** Текущяя модель долга, которая редактируется/создается в этом вьюконтроллере */
@property (nonatomic, strong) DebtPAA *currentDebt;

@end
