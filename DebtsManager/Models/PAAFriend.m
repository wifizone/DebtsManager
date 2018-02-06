//
//  PAAFriend.m
//  DebtsManager
//
//  Created by Антон Полуянов on 06/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import "PAAFriend.h"

@implementation PAAFriend

- (instancetype)initWithDictionary: (NSDictionary *)friendModelDictionary
{
    self = [super init];
    if (self)
    {
        _userId = friendModelDictionary[@"id"];
        _name = friendModelDictionary[@"first_name"];
        _surname = friendModelDictionary[@"last_name"];
        _personPhoto50UrlString = friendModelDictionary[@"photo_50"];
    }
    return self;
}

@end
