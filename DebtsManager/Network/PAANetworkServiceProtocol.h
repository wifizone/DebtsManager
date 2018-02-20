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
 Процедура вызывается при загрузке изображения друга с сервера
 @param personPhoto Изображение друга
 */
- (void)loadingIsDoneWithImageReceived: (NSData *)personPhoto;

/**
 Процедура вызывается при загрузке изображения друга с сервера
 @param personPhoto Изображение друга
 @param indexPath Индекс ячейки таблицы. Необходим для присвоения изображения к определенной ячейке
 */
- (void)loadingIsDoneWithImageReceived: (NSData *)personPhoto forIndexPath:(NSIndexPath *)indexPath;

@end


/**
 * Протокол для делегирования загрузки данных с сервера
 */
@protocol PAANetworkServiceInputProtocol <NSObject>
@optional

/**
 Процедура инициирует загрузку списка друзей
 */
- (void)loadFriendListOfPerson;

/**
 Процедура инициирует загрузку изображения друга
 @param imageUrlString Url изображения
 */
- (void)loadImageOfPerson: (NSString *)imageUrlString;

/**
 Процедура инициирует загрузку изображения друга
 @param imageUrlString Url изображения
 @param indexPath Индекс ячейки таблицы. Необходим для присвоения изображения к определенной ячейке
 */
- (void)loadImageOfPerson:(NSString *)imageUrlString forIndexPath:(NSIndexPath *)indexPath;

@end
