//
//  PAAApiManager.h
//  DebtsManager
//
//  Created by Антон Полуянов on 01/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PAAApiManager : NSObject

+ (NSString *)getAuthorizaitionUrl;
+ (NSString *)getFriendsIdsRequestUrl;
+ (void)saveAccessTokenToUserDefaults:(NSURL *)url;
+ (NSString *)getAccessTokenFromUserDefaults;
+ (NSString *)parseTokenFromUrl:(NSURL *)url;
+ (NSArray *)parseFriendList:(NSDictionary *)friendList;


@end
