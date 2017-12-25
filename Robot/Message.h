//
//  Message.h
//  Robot
//
//  Created by macbook on 25/12/2017.
//  Copyright © 2017 bessem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) NSString* date;
@property (nonatomic) NSInteger creatorType;
@end
