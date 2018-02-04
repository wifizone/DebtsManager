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

@property (nonatomic, copy) NSDictionary *response;

@end

@implementation PAANetworkService

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSArray *arrayOfFriendsDownloaded = [NSArray arrayWithContentsOfURL:location];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.output loadingIsDoneWithJsonRecieved:arrayOfFriendsDownloaded];
    });
}

- (NSMutableURLRequest *)getConfiguredRequestForUrl:(NSString *)urlString {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-ww-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:15];
    return request;
}

-(void)loadFriendListOfPerson
{
    NSString *urlString = [PAAApiManager getFriendsIdsRequestUrl];
    NSMutableURLRequest * request = [self getConfiguredRequestForUrl:urlString];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: sessionConfiguration];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *temp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];  //ошибку обработать
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.output loadingIsDoneWithJsonRecieved: [PAAApiManager parseFriendList:temp]];
        });
    }];
    [sessionDataTask resume];
}

@end
