//
//  PAAFriend.m
//  DebtsManager
//
//  Created by Антон Полуянов on 06/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import "PAAFriend.h"

@implementation PAAFriend

- (instancetype)initWithUserId: (NSString *)userId name:(NSString *)name surname:(NSString *)surname personPhotoUrlString:(NSString *)personPhotoUrlString;
{
    self = [super init];
    if (self)
    {
        _userId = userId;
        _name = name;
        _surname = surname;
        _personPhoto50UrlString = personPhotoUrlString;
    }
    return self;
}

@end
