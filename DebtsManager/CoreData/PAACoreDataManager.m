//
//  CoreDataManager.m
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import "PAACoreDataManager.h"
#import "AppDelegate.h"


static NSString * const PAAEntityDebtName = @"DebtPAA";
static NSString * const PAADebtDueDateCoreDataAttribute = @"dueDate";
static NSString * const PAAFriendNameCoreDataAttribute = @"name";

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

- (NSArray<FriendPAA *> *)getCurrentFriendModel
{
    NSArray *sortDescription = [self createSortDescriptionWithKey:PAAFriendNameCoreDataAttribute];
    NSFetchRequest *fetchRequest = [FriendPAA fetchRequest];
    [fetchRequest setSortDescriptors:sortDescription];
    return [self getModelUsingFetchRequest:fetchRequest];
}

- (NSArray<DebtPAA *> *)getCurrentDebtModel
{
    NSArray *sortDescription = [self createSortDescriptionWithKey:PAADebtDueDateCoreDataAttribute];
    NSFetchRequest *fetchRequest = [DebtPAA fetchRequest];
    [fetchRequest setSortDescriptors:sortDescription];
    return [self getModelUsingFetchRequest:fetchRequest];
}

- (NSArray *)createSortDescriptionWithKey: (NSString *)sortDescriptionKey
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortDescriptionKey ascending:YES];
    NSArray *sortDescription = @[sortDescriptor];
    return sortDescription;
}

- (NSArray *)getModelUsingFetchRequest: (NSFetchRequest *)fetchRequest
{
    NSArray *modelArray;
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
    debt.sum = debtSum;
    debt.dueDate = dueDate;
    debt.appearedDate = dateAppeared;
    
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
    debt.sum = debtSum;
    debt.dueDate = dueDate;
    debt.appearedDate = dateAppeared;
    
    NSError *error;
    if (![debt.managedObjectContext save:&error])
    {
        NSLog(@"Не удалось изменить объект");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

@end
