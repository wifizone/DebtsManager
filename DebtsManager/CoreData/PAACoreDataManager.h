//
//  CoreDataManager.h
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DebtPAA+CoreDataClass.h"


extern NSString * const PAAPersonNameCoreDataField;
extern NSString * const PAAPersonSurnameCoreDataField;
extern NSString * const PAAPersonPhotoUrlCoreDataField;
extern NSString * const PAADebtAppearedDateCoreDataField;
extern NSString * const PAADebtDueDateCoreDataField;
extern NSString * const PAADebtSumCoreDataField;


@interface PAACoreDataManager : NSObject

@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;

+ (PAACoreDataManager *)sharedCoreDataManager;
- (NSManagedObjectContext *)coreDataContext;
- (NSManagedObjectContext *)getCurrentModel;
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
