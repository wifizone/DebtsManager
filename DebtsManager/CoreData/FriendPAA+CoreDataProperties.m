//
//  FriendPAA+CoreDataProperties.m
//  DebtsManager
//
//  Created by Антон Полуянов on 17/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//
//

#import "FriendPAA+CoreDataProperties.h"

@implementation FriendPAA (CoreDataProperties)

+ (NSFetchRequest<FriendPAA *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FriendPAA"];
}

@dynamic name;
@dynamic photoUrl;
@dynamic surname;
@dynamic debt;

@end
