//
//  CoreDataManager.h
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "DebtPAA+CoreDataClass.h"
#import "FriendPAA+CoreDataClass.h"

@interface PAACoreDataManager : NSObject

@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;

+ (PAACoreDataManager *)sharedCoreDataManager;
- (NSManagedObjectContext *)coreDataContext;
- (NSArray<FriendPAA *> *)getCurrentFriendModel;
- (void)importFriendListFromArrayOfDictionaries: (NSArray<NSDictionary *> *)friendsDictionaries;
- (NSArray<DebtPAA *> *)getCurrentDebtModel;
- (void)insertDebtObjectWithName:(NSString *)name
                         surname:(NSString *)surename
                  photoUrlString:(NSString *)photoUrlString
                         debtSum:(double)debtSum
                     debtDueDate:(NSDate *)dueDate
                debtAppearedDate:(NSDate *)dateAppeared;
- (void)editObject:(DebtPAA *)debt
              name:(NSString *)name
           surname:(NSString *)surename
    photoUrlString:(NSString *)photoUrlString
           debtSum:(double)debtSum
       debtDueDate:(NSDate *)dueDate
  debtAppearedDate:(NSDate *)dateAppeared;
- (void)deleteObject: (DebtPAA *)debt;

@end
