//
//  PAANetworkService.h
//  DebtsManager
//
//  Created by Антон Полуянов on 03/02/2018.
//  Copyright © 2018 Антон Полуянов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAANetworkServiceProtocol.h"

@interface PAANetworkService : NSObject <PAANetworkServiceInputProtocol>

@property (nonatomic, weak) id<PAANetworkServiceOutputProtocol> output;
- (instancetype)init;

@end
