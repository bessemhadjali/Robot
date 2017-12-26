//
//  BotManager.m
//  Robot
//
//  Created by macbook on 26/12/2017.
//  Copyright © 2017 bessem. All rights reserved.
//

#import "BotManager.h"
#define BASE_URL @"http://www.trusttic.com"
#define API_VERSION @"1.0"
#define DEVICE_TYPE UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? @"tablet" : @"phone"

@implementation BotManager


- (AFHTTPSessionManager*)getNetworkingManager{
    
    if (self.networkingManager == nil) {
        self.networkingManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        self.networkingManager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.networkingManager.responseSerializer.acceptableContentTypes = [self.networkingManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/html", @"application/json", @"text/json"]];
       
    }
    return self.networkingManager;
}

-(void) sendMessage:(NSString*)text success:(NetworkManagerSuccess)success failure:(NetworkManagerFailure)failure
{
    
     NSMutableDictionary *params = [self getBaseParams];
    [params setObject:text forKey:@"message"];
    
    [[self getNetworkingManager] POST:@"/bot" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        if (success != nil) {
            success(responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSString *errorMessage = [self getError:error];
        if (failure != nil) {
            failure(errorMessage, ((NSHTTPURLResponse*)operation.response).statusCode);
        }
    }];
    
}

- (NSMutableDictionary*)getBaseParams {
    NSMutableDictionary *baseParams = [NSMutableDictionary dictionary];
    [baseParams setObject:@"version" forKey:API_VERSION];
    [baseParams setObject:@"device_type" forKey:DEVICE_TYPE];
    [baseParams setObject:@"json" forKey:@"format"];
    return baseParams;
}

- (NSString*)getError:(NSError*)error {
    if (error != nil) {
        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
        if (responseObject != nil && [responseObject isKindOfClass:[NSDictionary class]] && [responseObject objectForKey:@"message"] != nil && [[responseObject objectForKey:@"message"] length] > 0) {
            return [responseObject objectForKey:@"message"];
        }
    }
    return @"Server Error. Please try again later";
}

@end
