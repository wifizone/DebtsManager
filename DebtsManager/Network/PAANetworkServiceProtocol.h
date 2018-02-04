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

-(void)loadingContinuesWithProgress: (double)progress;
-(void)loadingIsDoneWithJsonRecieved: (NSArray *)friendItemsReceived;

@end


@protocol PAANetworkServiceInputProtocol <NSObject>
@optional
-(void)configureUrlSessionWithParams: (NSDictionary *)params;
-(void)startImageLoading: (NSString *)searchName;

-(BOOL)resumeNetworkLoading;
-(void)suspendNetworkLoading;

-(void)loadFriendListOfPerson;

@end
