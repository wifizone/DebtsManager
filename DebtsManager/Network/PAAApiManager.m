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
static NSString * const PAAAuthorizationUrlString = @"https://oauth.vk.com/authorize?client_id=%@&display=page&redirect_uri=%@&scope=65538&response_type=token&v=%@";
static NSString * const PAAGetFriendsRequest = @"https://api.vk.com/method/friends.get?order=name&fields=photo_200&v=%@&access_token=%@";

@implementation PAAApiManager


#pragma mark - VKQueries

+ (NSString *)getAuthorizaitionUrl
{
    NSString *redirectUri = [NSString stringWithFormat:@"vk%@://authorize", PAAapplicationId];
    return [NSString stringWithFormat:PAAAuthorizationUrlString, PAAapplicationId, redirectUri, PAAVkApiVersion];
}

+ (NSString *)getFriendsIdsRequestUrl
{
    NSString *accessToken = [self getAccessTokenFromUserDefaults];
    return [NSString stringWithFormat:PAAGetFriendsRequest, PAAVkApiVersion, accessToken];
}


#pragma mark - ManagingAccessToken

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

+ (void)eraseAccessToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:PAAAccessTokenInUserDefaultsKey];
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
