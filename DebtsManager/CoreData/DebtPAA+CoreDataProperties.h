//
//  DebtPAA+CoreDataProperties.h
//  DebtsManager
//
//  Created by Антон Полуянов on 16/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//
//

#import "DebtPAA+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DebtPAA (CoreDataProperties)

+ (NSFetchRequest<DebtPAA *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *appearedDate;
@property (nullable, nonatomic, copy) NSDate *dueDate;
@property (nonatomic) double sum;
@property (nullable, nonatomic, copy) NSString *personName;
@property (nullable, nonatomic, copy) NSString *personPhotoUrl;
@property (nullable, nonatomic, copy) NSString *personSurname;
@property (nullable, nonatomic, retain) FriendPAA *friend;

@end

NS_ASSUME_NONNULL_END
