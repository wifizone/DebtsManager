//
//  PAANetworkServiceProtocol.h
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <Foundation/Foundation.h>


/**
 * Протокол для делегирования обработки загруженных с сервера данных
 */
@protocol PAANetworkServiceOutputProtocol <NSObject>
@optional

/**
 Процедура вызывается при загрузке JSON со списком друзей
 @param friendItemsReceived JSON со списком друзей
 */
- (void)loadingIsDoneWithJsonRecieved: (NSArray<NSDictionary *> *)friendItemsReceived;


/**
 Процедура вызывается при изображения друга с сервера
 @param personPhoto Изображение друга
 */
- (void)loadingIsDoneWithImageReceived: (NSData *)personPhoto;
- (void)loadingIsDoneWithImageReceived: (NSData *)personPhoto forIndexPath:(NSIndexPath *)indexPath;

@end


@protocol PAANetworkServiceInputProtocol <NSObject>
@optional
- (void)configureUrlSessionWithParams: (NSDictionary *)params;

- (void)loadFriendListOfPerson;
- (void)loadImageOfPerson: (NSString *)imageUrlString;
- (void)loadImageOfPerson:(NSString *)imageUrlString forIndexPath:(NSIndexPath *)indexPath;

@end
