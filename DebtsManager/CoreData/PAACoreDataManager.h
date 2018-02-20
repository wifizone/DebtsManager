//
//  CoreDataManager.h
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "DebtPAA+CoreDataClass.h"
#import "FriendPAA+CoreDataClass.h"


/**
 * Синглтон класс для работы с CoreData. Реализует CRUD для модели долга и друга
 */
@interface PAACoreDataManager : NSObject

/** Позволяет работать с классом
 @return Cинглтон объект для работы с классом
 */
+ (PAACoreDataManager *)sharedCoreDataManager;

/**
 Функция возвращает список друзей из insertedObjects, то есть незакомиченный список друзей из контекста CoreData
 @return Массив моделей друзей
 */
- (NSArray<FriendPAA *> *)getCurrentFriendEntitiesFromInsertedObjectsInCoreDataContext;

/**
 Процедура парсит и сохраняет в CoreData модели друзей
 @param friendsDictionaries массив json словарей, состоящих из моделей друзей, из апи
 */
- (void)importFriendListFromArrayOfDictionaries: (NSArray<NSDictionary *> *)friendsDictionaries;

/**
 Процедура чистит insertedObjects у контекста, то есть незакомиченные изменения
 */
- (void)clearContextFromInsertedFriendEntities;

/**
 Функция получает ранее сохраненный в coreData список друзей
 @return Массив моделей друзей
 */
- (NSArray<DebtPAA *> *)getCurrentDebtModel;

/**
 Процедура cохраняет в CoreData долг
 @param name Имя друга
 @param surename Фамилия друга
 @param photoUrlString url Фото друга
 @param debtSum Сумма долга
 @param dueDate Дата возврата долга
 @param dateAppeared Дата, когда долг возник
 */
- (void)insertDebtObjectWithName:(NSString *)name
                         surname:(NSString *)surename
                  photoUrlString:(NSString *)photoUrlString
                         debtSum:(double)debtSum
                     debtDueDate:(NSDate *)dueDate
                debtAppearedDate:(NSDate *)dateAppeared;

/**
 Процедура изменяет долг в CoreData
 @param debt Объект долга в Coredata, который надо изменить
 @param name Имя друга
 @param surename Фамилия друга
 @param photoUrlString Url фото друга
 @param debtSum Сумма долга
 @param dueDate Дата возврата долга
 @param dateAppeared Дата, когда долг возник
 */
- (void)editObject:(DebtPAA *)debt
              name:(NSString *)name
           surname:(NSString *)surename
    photoUrlString:(NSString *)photoUrlString
           debtSum:(double)debtSum
       debtDueDate:(NSDate *)dueDate
  debtAppearedDate:(NSDate *)dateAppeared;

/**
 Процедура удаляет долг в CoreData
 @param debt Объект долга в Coredata, который надо удалить
 */
- (void)deleteObject: (DebtPAA *)debt;

@end
