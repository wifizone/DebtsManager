//
//  PAAUserInputChecker.h
//  DebtsManager
//
//  Created by Антон Полуянов on 19/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 Работает с генерацией UIAlertController
 */
@interface PAAAlertMaker : NSObject

/**
 Генерирует UIAlertController с заданным сообщением и кнопкой ОК
 @param message - сообщение для отображения в UIAlertController
 @return сгенерированный UIAlertController
 */
+ (UIAlertController *)getAlertControllerWithText:(NSString *)message;

@end
