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


static NSString * const PAAEntityDebtName = @"DebtPAA";

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
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"debtDueDate" ascending:YES];
    NSArray *sortDescription = @[sortDescriptor];
    NSFetchRequest *fetchRequest = [DebtPAA fetchRequest];
    [fetchRequest setSortDescriptors:sortDescription];
    NSArray<DebtPAA *> *modelArray;
    
    NSError *error;
    if (!(modelArray = [self.coreDataContext executeFetchRequest:fetchRequest error:nil]))
    {
        NSLog(@"Не удалось загрузить модель");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    return modelArray;
}

- (void)insertDebtObjectWithName:(NSString *)name surname:(NSString *)surename
                  photoUrlString:(NSString *)photoUrlString
                         debtSum:(double)debtSum
                     debtDueDate:(NSDate *)dueDate
                debtAppearedDate:(NSDate *)dateAppeared
{
    NSManagedObjectContext *context = [PAACoreDataManager sharedCoreDataManager].coreDataContext;
    DebtPAA *debt = [NSEntityDescription insertNewObjectForEntityForName:PAAEntityDebtName
                                                  inManagedObjectContext:context];
    debt.personName = name;
    debt.personSurname = surename;
    debt.personPhotoUrl = photoUrlString;
    debt.debtSum = debtSum;
    debt.debtDueDate = dueDate;
    debt.debtAppearedDate = dateAppeared;
    
    NSError *error;
    
    if (![debt.managedObjectContext save:&error])
    {
        NSLog(@"Не удалось сохранить объект");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

- (void)deleteObject: (DebtPAA *)debt
{
    [self.coreDataContext deleteObject:debt];
    
    if (![debt isDeleted])
    {
        NSLog(@"Ошибка при удалении из CoreData");
    }
    
    NSError *error;
    if ([self.coreDataContext save:&error])
    {
        NSLog(@"Не удалось сохранить контекст посое удаления объекта из CoreData");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
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
