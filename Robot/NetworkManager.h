//
//  NetworkManager.h
//  Robot
//
//  Created by macbook on 26/12/2017.
//  Copyright © 2017 bessem. All rights reserved.
//



#import <Foundation/Foundation.h>


@protocol MessageSendProtocol;
@interface NetworkManager : NSObject
@property (nonatomic, weak) id<MessageSendProtocol>delegate;

+ (id)sharedManager;

-(void) sendMessage:(NSString*)text;


@end

@protocol MessageSendProtocol <NSObject>
@optional
-(void)sendMessageDidUpdateWithWeather:(NSArray*)messagesArray;
-(void)sendMessageDidFailWithError:(NSString*)raisonFail;
@end

