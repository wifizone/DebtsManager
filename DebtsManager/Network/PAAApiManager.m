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
    if (!accessToken)
    {
        return nil;
    }
    return [NSString stringWithFormat:PAAGetFriendsRequest, PAAVkApiVersion, accessToken];
}


#pragma mark - ManagingAccessToken

+ (void)saveAccessTokenToUserDefaults:(NSURL *)url
{
    if (!url)
    {
        return;
    }
    NSString *accessToken = [self parseTokenFromUrl:url];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:PAAAccessTokenInUserDefaultsKey];
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
    if (!url)
    {
        return nil;
    }
    NSString *urlString = url.absoluteString;
    NSArray *matches = [self getAccessTokenMatchesFromString:urlString];
    if (matches.count == 0)
    {
        return nil;
    }
    NSRange rangeOfFirstGroup = [matches[0] rangeAtIndex:1];
    NSString *accessToken = [urlString substringWithRange:rangeOfFirstGroup];
    return accessToken;
}

+ (NSArray *)getAccessTokenMatchesFromString:(NSString *)urlString
{
    if (!urlString)
    {
        return nil;
    }
    NSString *pattern = @"access_token=(.*?)(&|$)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSArray *matches = [regex matchesInString:urlString options:NSMatchingReportProgress
                                        range:NSMakeRange(0, urlString.length)];
    return matches;
}

+ (NSArray *)parseFriendList:(NSDictionary *)friendList
{
    if (!friendList)
    {
        return nil;
    }
    if ([friendList valueForKey:@"error"])
    {
        return nil;
    }
    NSDictionary *responseContainer = friendList[@"response"];
    NSArray<NSDictionary *> *friendListItems = responseContainer[@"items"];
    return friendListItems;
}

@end
