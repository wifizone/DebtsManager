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

-(void)loadingIsDoneWithJsonRecieved: (NSArray *)friendItemsReceived;
-(void)loadingIsDoneWithImageReceived: (NSData *)personPhoto;

@end


@protocol PAANetworkServiceInputProtocol <NSObject>
@optional
- (void)configureUrlSessionWithParams: (NSDictionary *)params;

- (BOOL)resumeNetworkLoading;
- (void)suspendNetworkLoading;

- (void)loadFriendListOfPerson;
- (void)loadImageOfPerson: (NSString *)imageUrlString;


@end
