//
//  PAAUserInputChecker.h
//  DebtsManager
//
//  Created by Антон Полуянов on 19/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface PAAAlertMaker : NSObject

+ (UIAlertController *)getAlertControllerWithText:(NSString *)message;

@end
