//
//  PAAAuthoriseViewController.h
//  DebtsManager
//
//  Created by Антон Полуянов on 01/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <UIKit/UIKit.h>


/** Константа глобальная. Имя нотификации, которая срабатывает при получении токена */
extern NSString * const PAAAccessTokenReceivedNotification;

/**
 * Вьюконтроллер содержит одну кнопку для входа в вк
 */
@interface PAAAuthoriseViewController : UIViewController

@end
