//
//  PAANetworkService.m
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import "PAANetworkService.h"
#import "PAAApiManager.h"


@interface PAANetworkService()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation PAANetworkService

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    }
    return self;
}

- (NSMutableURLRequest *)getConfiguredRequestForUrl:(NSString *)urlString {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-ww-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:15];
    return request;
}

- (void)loadFriendListOfPerson
{
    NSString *urlString = [PAAApiManager getFriendsIdsRequestUrl];
    NSMutableURLRequest *request = [self getConfiguredRequestForUrl:urlString];
    
    NSURLSessionDataTask *sessionDataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];  //ошибку обработать
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.output loadingIsDoneWithJsonRecieved: [PAAApiManager parseFriendList:temp]];
        });
    }];
    [sessionDataTask resume];
}

- (void)loadImageOfPerson: (NSString *)imageUrlString
{
    NSMutableURLRequest *request = [self getConfiguredRequestForUrl:imageUrlString];
    
    NSURLSessionDataTask *sessionDataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.output loadingIsDoneWithImageReceived:data];
        });
    }];
    [sessionDataTask resume];
}

@end
