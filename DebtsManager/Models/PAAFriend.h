//
//  PAAFriend.h
//  DebtsManager
//
//  Created by Антон Полуянов on 06/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface PAAFriend : NSObject

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *surname;
@property (nonatomic, copy) NSString *personPhotoUrlString;

- (instancetype)initWithDictionary: (NSDictionary *)friendModelDictionary;
+ (NSArray <PAAFriend *> *)getFriendListFromDictionaryArray: (NSArray<NSDictionary *> *)friendListDictionaries;
+ (NSArray <PAAFriend *> *)filterFriendListFromDeletedFriends:(NSArray<PAAFriend *> *)friendList;
@end
