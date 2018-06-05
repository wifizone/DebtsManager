//
//  PAANetworkService.h
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "PAANetworkServiceProtocol.h"


/**
 * Класс позволяет работать с загрузкой данных с сервера
 */
@interface PAANetworkService : NSObject <PAANetworkServiceInputProtocol>

/** Делегат для обработки загруженных данных */
@property (nonatomic, weak) id<PAANetworkServiceOutputProtocol> output;

/** Инициализирует url сессию */
- (instancetype)init;

@end
