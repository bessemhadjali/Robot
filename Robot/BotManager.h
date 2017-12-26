//
//  BotManager.h
//  Robot
//
//  Created by macbook on 26/12/2017.
//  Copyright © 2017 bessem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^NetworkManagerSuccess)(id responseObject);

typedef void (^NetworkManagerFailure)(NSString *failureReason, NSInteger statusCode);

@interface BotManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager* networkingManager;

-(void) sendMessage:(NSString*)text success:(NetworkManagerSuccess)success failure:(NetworkManagerFailure)failure;


@end
