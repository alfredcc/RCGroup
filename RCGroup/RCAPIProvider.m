//
//  RCAPIProvider.m
//  RCGroup
//
//  Created by race on 19/10/2016.
//  Copyright © 2016 com.chao. All rights reserved.
//

#import "RCAPIProvider.h"
#import "AppUser.h"

@implementation RCAPIProvider

+ (NSURLSessionDataTask *)loginWithUserId:(NSString *)userID name:(NSString *) name block:(void (^)(AppUser *user, NSError *))block {
    NSDictionary *parameters =@{@"userId":@"test",
                                @"name":@"username",
                                @"portraitUri":@"http://portra.wpshower.com/wp-content/uploads/2014/03/martin-schoeller-barack-obama-portrait-up-close-and-personal.jpg"
                                };
    return [[RCAPIClient sharedClient] POST:@"user/getToken.json" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        AppUser *user = [[AppUser alloc] init];
        user.userID = [responseObject valueForKeyPath:@"userId"];
        user.token = [responseObject valueForKeyPath:@"token"];
        block(user, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Response JSON");
    }];
}

@end
