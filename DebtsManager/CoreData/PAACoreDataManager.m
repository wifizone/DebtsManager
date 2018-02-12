//
//  CoreDataManager.m
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import "PAACoreDataManager.h"
#import "DebtPAA+CoreDataClass.h"
#import "AppDelegate.h"

NSString * const PAAPersonNameCoreDataField = @"personName";
NSString * const PAAPersonSurnameCoreDataField = @"personSurname";
NSString * const PAAPersonPhotoUrlCoreDataField = @"personPhotoUrl";
NSString * const PAADebtAppearedDateCoreDataField = @"debtAppearedDate";
NSString * const PAADebtDueDateCoreDataField = @"debtDueDate";
NSString * const PAADebtSumCoreDataField = @"debtSum";

@implementation PAACoreDataManager

+ (PAACoreDataManager *)sharedCoreDataManager
{
    static PAACoreDataManager *coreDataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coreDataManager = [[self alloc] init];
    });
    return coreDataManager;
}

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


#pragma mark - CRUD

- (NSArray<DebtPAA *> *)getCurrentModel
{
    NSArray<DebtPAA *> *modelArray = [self.coreDataContext executeFetchRequest:[DebtPAA fetchRequest] error:nil];
    return modelArray;
}

- (void)insertDebtObjectWithName:(NSString *)name surname:(NSString *)surename
                  photoUrlString:(NSString *)photoUrlString
                         debtSum:(double)debtSum
                     debtDueDate:(NSDate *)dueDate
                debtAppearedDate:(NSDate *)dateAppeared
{
    NSManagedObjectContext *context = [PAACoreDataManager sharedCoreDataManager].coreDataContext;
    DebtPAA *debt = [NSEntityDescription insertNewObjectForEntityForName:@"DebtPAA" inManagedObjectContext:context];
    debt.personName = name;
    debt.personSurname = surename;
    debt.personPhotoUrl = photoUrlString;
    debt.debtSum = debtSum;
    debt.debtDueDate = dueDate;
    debt.debtAppearedDate = dateAppeared;
    
    NSError *error;
    
    if (![debt.managedObjectContext save:&error])
    {
        NSLog(@"Не удалось сохрнаить объект");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

- (void)deleteObject: (DebtPAA *)debt
{
    //    NSError *error;
    [self.coreDataContext deleteObject:debt];
    
    if (![debt isDeleted])
    {
        NSLog(@"Ошибка при удалении из CoreData");
    }
    
    [self.coreDataContext save:nil];
}

- (void)editObject:(DebtPAA *)debt name:(NSString *)name
           surname:(NSString *)surename
    photoUrlString:(NSString *)photoUrlString
           debtSum:(double)debtSum
       debtDueDate:(NSDate *)dueDate
  debtAppearedDate:(NSDate *)dateAppeared
{
    debt.personName = name;
    debt.personSurname = surename;
    debt.personPhotoUrl = photoUrlString;
    debt.debtSum = debtSum;
    debt.debtDueDate = dueDate;
    debt.debtAppearedDate = dateAppeared;
    
    NSError *error;
    
    if (![debt.managedObjectContext save:&error])
    {
        NSLog(@"Не удалось изменить объект");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

@end
