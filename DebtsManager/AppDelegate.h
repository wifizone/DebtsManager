//
//  AppDelegate.h
//  DebtsManager
//
//  Created by Антон Полуянов on 30/01/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

