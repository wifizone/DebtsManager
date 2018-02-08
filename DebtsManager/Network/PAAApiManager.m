//
//  PAAApiManager.m
//  DebtsManager
//
//  Created by Антон Полуянов on 01/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import "PAAApiManager.h"

static NSString * const PAAapplicationId = @"6355774";
static NSString * const PAAVkApiVersion = @"5.71";
static NSString * const PAAAccessTokenInUserDefaultsKey = @"accessToken";


@implementation PAAApiManager


#pragma mark - VKQueries

+ (NSString *)getAuthorizaitionUrl
{
    NSString *redirectUri = [NSString stringWithFormat:@"vk%@://authorize", PAAapplicationId];
    return [NSString stringWithFormat:@"https://oauth.vk.com/authorize?client_id=%@&display=page&redirect_uri=%@&scope=friends&response_type=token&v=%@", PAAapplicationId, redirectUri, PAAVkApiVersion];
}

+ (NSString *)getFriendsIdsRequestUrl
{
    NSString *accessToken = [self getAccessTokenFromUserDefaults];
    return [NSString stringWithFormat:@"https://api.vk.com/method/friends.get?order=name&fields=photo_100&v=%@&access_token=%@", PAAVkApiVersion, accessToken];
}


#pragma ManagingAccessToken

+ (void)saveAccessTokenToUserDefaults:(NSURL *)url
{
    NSString *accessToken = [self parseTokenFromUrl:url];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:PAAAccessTokenInUserDefaultsKey];
    [defaults synchronize];
}

+ (NSString *)getAccessTokenFromUserDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:PAAAccessTokenInUserDefaultsKey];
}


#pragma mark - ParsingResponse

+ (NSString *)parseTokenFromUrl:(NSURL *)url
{
    NSString *urlString = url.absoluteString;
    NSRange tokenStartRange = [urlString rangeOfString:@"access_token="];
    NSRange tokenEndRange = [urlString rangeOfString:@"&"];
    NSUInteger tokenStartLocation = tokenStartRange.location + tokenStartRange.length;
    NSUInteger tokenEndLocation = tokenEndRange.location - tokenEndRange.length;
    NSUInteger tokenLength = tokenEndLocation - tokenStartLocation + 1;
    NSString *accessToken = [urlString substringWithRange:NSMakeRange(tokenStartLocation, tokenLength)];
    return accessToken;
}

+ (NSArray *)parseFriendList:(NSDictionary *)friendList
{
    NSDictionary *responseContainer = friendList[@"response"];
    NSArray<NSDictionary *> *friendListItems = responseContainer[@"items"];
    return friendListItems;
}

@end
