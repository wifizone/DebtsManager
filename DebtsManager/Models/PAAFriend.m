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
        _personPhotoUrlString = friendModelDictionary[@"photo_100"];
    }
    return self;
}

+ (NSArray<PAAFriend *> *)getFriendListFromDictionaryArray:(NSArray<NSDictionary *> *)friendListDictionaries
{
    NSMutableArray<PAAFriend *> *friendList = [NSMutableArray new];
    for (NSDictionary *friendDictionary in friendListDictionaries)
    {
        PAAFriend *friend = [[PAAFriend alloc] initWithDictionary:friendDictionary];
        [friendList addObject:friend];
    }
    return friendList;
}

//+ (NSArray<NSDictionary *> *)filterFriendListFromDeletedFriends:(NSArray<PAAFriend *> *)filteredFriendList
//{
//    NSPredicate *deletedFriendsFilterPredicate;
//    deletedFriendsFilterPredicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject,
//                                                                          NSDictionary<NSString *,id> * _Nullable bindings) {
//        PAAFriend *friend = evaluatedObject;
//        if (friend.name == @"DELETED")
//        {
//            return NO;
//        }
//        else
//        {
//            return YES;
//        }
//    };
//    NSArray *filteredFriendList =
//}

@end
