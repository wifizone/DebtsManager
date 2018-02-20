//
//  PAAApiManager.h
//  DebtsManager
//
//  Created by Антон Полуянов on 01/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <Foundation/Foundation.h>

/**
 * Класс позволяет работать с ВК апи. Управляет токеном, генерирует и парсит запросы
 */
@interface PAAApiManager : NSObject

/**
 Функция генерирует url для входа пользователя в вк
 @return Url для входа пользователя в вк
 */
+ (NSString *)getAuthorizaitionUrl;

/**
 Функция генерирует url запрос для загрузки списка друзей пользователя в вк
 @return Url запрос для загрузки списка друзей
 */
+ (NSString *)getFriendsIdsRequestUrl;

/**
 Процедура парсит и сохраняет токен в NSUserDefaults
 @param url Ответ сервера с токеном
 */
+ (void)saveAccessTokenToUserDefaults:(NSURL *)url;

/**
 Функция извлекает ранее сохраненный токен из NSUserDefaults
 @return сохраненный ранее токен
 */
+ (NSString *)getAccessTokenFromUserDefaults;

/**
 Процедура удаляет ранее сохраненный токен из NSUserDefaults
 */
+ (void)eraseAccessToken;

/**
 Функция парсит response сервера (убирает первый уровень response в json)
 @return список моделей друзей
 */
+ (NSArray<NSDictionary *> *)parseFriendList:(NSDictionary *)friendList;

@end
