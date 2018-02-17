//
//  CoreDataManager.m
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import "PAACoreDataManager.h"
#import "AppDelegate.h"

static NSString * const PAADeletedFriend = @"DELETED";
static NSString * const PAAEntityDebtName = @"DebtPAA";
static NSString * const PAAEntityFriendName = @"FriendPAA";
static NSString * const PAADebtDueDateCoreDataAttribute = @"dueDate";

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


#pragma mark - CRUD General

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

- (NSArray *)createSortDescriptionWithKey: (NSString *)sortDescriptionKey
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortDescriptionKey ascending:YES];
    NSArray *sortDescription = @[sortDescriptor];
    return sortDescription;
}


#pragma mark - CRUD Friend

- (NSArray<FriendPAA *> *)getCurrentFriendEntitiesFromInsertedObjectsInCoreDataContext
{
    NSSet<FriendPAA *> *friendsSet = self.coreDataContext.insertedObjects;
    NSArray *friendArray = [NSArray arrayWithArray:[friendsSet allObjects]];
    return [friendArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        FriendPAA *first = (FriendPAA *)obj1;
        FriendPAA *second = (FriendPAA *)obj2;
        return [first.surname compare:second.surname];
    }];
}

- (void)importFriendListFromArrayOfDictionaries: (NSArray<NSDictionary *> *)friendsDictionaries
{
    for (NSDictionary *friendDictionary in friendsDictionaries)
    {
        [self insertFriendObjectWithName:friendDictionary[@"first_name"]
                                 surname:friendDictionary[@"last_name"]
                          photoUrlString:friendDictionary[@"photo_200"]];
    }
}

- (void)insertFriendObjectWithName:(NSString *)name
                           surname:(NSString *)surname
                  photoUrlString:(NSString *)photoUrlString
{
    if (![name containsString:PAADeletedFriend])
    {
        FriendPAA *friend = [NSEntityDescription insertNewObjectForEntityForName:PAAEntityFriendName
                                                  inManagedObjectContext:self.coreDataContext];
        friend.name = name;
        friend.surname = surname;
        friend.photoUrl = photoUrlString;
    }
}


#pragma mark - CRUD Debt

- (NSArray<DebtPAA *> *)getCurrentDebtModel
{
    NSArray *sortDescription = [self createSortDescriptionWithKey:PAADebtDueDateCoreDataAttribute];
    NSFetchRequest *fetchRequest = [DebtPAA fetchRequest];
    [fetchRequest setSortDescriptors:sortDescription];
    return [self getModelUsingFetchRequest:fetchRequest];
}

- (void)insertDebtObjectWithName:(NSString *)name surname:(NSString *)surname
                  photoUrlString:(NSString *)photoUrlString
                         debtSum:(double)debtSum
                     debtDueDate:(NSDate *)dueDate
                debtAppearedDate:(NSDate *)dateAppeared
{
    DebtPAA *debt = [NSEntityDescription insertNewObjectForEntityForName:PAAEntityDebtName
                                                  inManagedObjectContext:self.coreDataContext];
    FriendPAA *friend = [NSEntityDescription insertNewObjectForEntityForName:PAAEntityFriendName
                                                      inManagedObjectContext:self.coreDataContext];
    friend.name = name;
    friend.surname = surname;
    friend.photoUrl = photoUrlString;
    debt.friend = friend;
    debt.sum = debtSum;
    debt.dueDate = dueDate;
    debt.appearedDate = dateAppeared;

    
    NSError *error;
    
    if (![debt.managedObjectContext save:&error] || ![debt.managedObjectContext save:&error])
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
           surname:(NSString *)surname
    photoUrlString:(NSString *)photoUrlString
           debtSum:(double)debtSum
       debtDueDate:(NSDate *)dueDate
  debtAppearedDate:(NSDate *)dateAppeared
{
    debt.friend.name = name;
    debt.friend.surname = surname;
    debt.friend.photoUrl = photoUrlString;
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
