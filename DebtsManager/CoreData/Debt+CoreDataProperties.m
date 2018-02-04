//
//  Debt+CoreDataProperties.m
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//
//

#import "Debt+CoreDataProperties.h"

@implementation Debt (CoreDataProperties)

+ (NSFetchRequest<Debt *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Debt"];
}

@dynamic debtAppearedDate;
@dynamic debtDueDate;
@dynamic debtSum;
@dynamic personName;
@dynamic personPhotoUrl;
@dynamic personSurname;

@end
