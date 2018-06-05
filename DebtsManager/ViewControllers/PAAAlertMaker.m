//
//  PAAUserInputChecker.m
//  DebtsManager
//
//  Created by Антон Полуянов on 19/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import "PAAAlertMaker.h"


@implementation PAAAlertMaker

+ (UIAlertController *)getAlertControllerWithText:(NSString *)message
{
    if (!message)
    {
        return nil;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ошибка"
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDefault
                                                        handler:nil];
    [alertController addAction:alertAction];
    return alertController;
}

@end
