//
//  NetworkManager.m
//  Robot
//
//  Created by macbook on 26/12/2017.
//  Copyright © 2017 bessem. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager()

@end

@implementation NetworkManager

#pragma mark -
#pragma mark Constructors

static NetworkManager *sharedManager = nil;

+ (NetworkManager*)sharedManager {
    static dispatch_once_t once;
    dispatch_once(&once, ^
                  {
                      sharedManager = [[NetworkManager alloc] init];
                  });
    return sharedManager;
}

- (id)init {
    if ((self = [super init])) {
    }
    return self;
}



@end
