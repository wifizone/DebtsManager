//
//  DebtPAA+CoreDataProperties.m
//  DebtsManager
//
//  Created by Антон Полуянов on 17/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//
//

#import "DebtPAA+CoreDataProperties.h"

@implementation DebtPAA (CoreDataProperties)

+ (NSFetchRequest<DebtPAA *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DebtPAA"];
}

@dynamic appearedDate;
@dynamic dueDate;
@dynamic sum;
@dynamic friend;

@end
