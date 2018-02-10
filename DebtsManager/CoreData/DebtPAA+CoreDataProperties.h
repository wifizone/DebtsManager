//
//  DebtPAA+CoreDataProperties.h
//  DebtsManager
//
//  Created by Антон Полуянов on 10/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//
//

#import "DebtPAA+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DebtPAA (CoreDataProperties)

+ (NSFetchRequest<DebtPAA *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *debtAppearedDate;
@property (nullable, nonatomic, copy) NSDate *debtDueDate;
@property (nonatomic) double debtSum;
@property (nullable, nonatomic, copy) NSString *personName;
@property (nullable, nonatomic, copy) NSString *personPhotoUrl;
@property (nullable, nonatomic, copy) NSString *personSurname;

@end

NS_ASSUME_NONNULL_END
