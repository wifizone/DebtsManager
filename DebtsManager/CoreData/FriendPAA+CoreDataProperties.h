//
//  FriendPAA+CoreDataProperties.h
//  DebtsManager
//
//  Created by Антон Полуянов on 17/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//
//

#import "FriendPAA+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FriendPAA (CoreDataProperties)

+ (NSFetchRequest<FriendPAA *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *photoUrl;
@property (nullable, nonatomic, copy) NSString *surname;
@property (nullable, nonatomic, retain) NSSet<DebtPAA *> *debt;

@end

@interface FriendPAA (CoreDataGeneratedAccessors)

- (void)addDebtObject:(DebtPAA *)value;
- (void)removeDebtObject:(DebtPAA *)value;
- (void)addDebt:(NSSet<DebtPAA *> *)values;
- (void)removeDebt:(NSSet<DebtPAA *> *)values;

@end

NS_ASSUME_NONNULL_END
