//
//  RCAPIClient.h
//  RCGroup
//
//  Created by race on 18/10/2016.
//  Copyright © 2016 com.chao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface RCAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

