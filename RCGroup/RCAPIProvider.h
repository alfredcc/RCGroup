//
//  RCAPIProvider.h
//  RCGroup
//
//  Created by race on 19/10/2016.
//  Copyright © 2016 com.chao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCAPIClient.h"
@class AppUser;

@interface RCAPIProvider : NSObject

+ (NSURLSessionDataTask *)loginWithUserId:(NSString *)userID name:(NSString *)name block:(void (^)(AppUser *user, NSError *error))block;

@end
