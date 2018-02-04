//
//  CoreDataManager.m
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import "PAACoreDataManager.h"
#import "AppDelegate.h"

NSString * const PAAPersonNameCoreDataField = @"personName";
NSString * const PAAPersonSurnameCoreDataField = @"personSurname";
NSString * const PAAPersonPhotoUrlCoreDataField = @"personPhotoUrl";
NSString * const PAADebtAppearedDateCoreDataField = @"debtAppearedDate";
NSString * const PAADebtDueDateCoreDataField = @"debtDueDate";
NSString * const PAADebtSumCoreDataField = @"debtSum";

@implementation PAACoreDataManager

- (NSManagedObjectContext *)coreDataContext
{
    if (_coreDataContext)
    {
        return _coreDataContext;
    }
    
    UIApplication *application = [UIApplication sharedApplication];
    NSPersistentContainer *container = ((AppDelegate *) (application.delegate)).persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    
    return context;
}

+ (PAACoreDataManager *)sharedCoreDataManager
{
    static PAACoreDataManager *coreDataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coreDataManager = [[self alloc] init];
    });
    return coreDataManager;
}

@end
