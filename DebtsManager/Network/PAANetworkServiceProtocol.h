//
//  PAANetworkServiceProtocol.h
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <Foundation/Foundation.h>


@protocol PAANetworkServiceOutputProtocol <NSObject>
@optional

- (void)loadingIsDoneWithJsonRecieved: (NSArray *)friendItemsReceived;
- (void)loadingIsDoneWithImageReceived: (NSData *)personPhoto;
- (void)loadingIsDoneWithImageReceived: (NSData *)personPhoto forIndexPath:(NSIndexPath *)indexPath;

@end


@protocol PAANetworkServiceInputProtocol <NSObject>
@optional
- (void)configureUrlSessionWithParams: (NSDictionary *)params;

- (BOOL)resumeNetworkLoading;
- (void)suspendNetworkLoading;

- (void)loadFriendListOfPerson;
- (void)loadImageOfPerson: (NSString *)imageUrlString;
- (void)loadImageOfPerson:(NSString *)imageUrlString forIndexPath:(NSIndexPath *)indexPath;

@end
