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

+ (NSURLSessionDataTask *)loginWithUserId:(NSString *)userId name:(NSString *) name block:(void (^)(AppUser *user, NSError *))block {
    NSDictionary *parameters =@{@"userId":userId,
                                @"name":name,
                                @"portraitUri":@"http://portra.wpshower.com/wp-content/uploads/2014/03/martin-schoeller-barack-obama-portrait-up-close-and-personal.jpg"
                                };
    return [[RCAPIClient sharedClient] POST:@"user/getToken.json" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        AppUser *user = [[AppUser alloc] init];
        user.userId = [responseObject valueForKeyPath:@"userId"];
        user.token = [responseObject valueForKeyPath:@"token"];
        block(user, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"API Error");
    }];
}

+ (NSURLSessionDataTask *)createGroupWithGroupId:(NSString *)groupId userIds:(NSSet *)userIds groupName:(NSString *)groupName block:(void (^)(NSString *code, NSError *))block {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:groupId forKey:@"groupId"];
    [parameters setObject:groupName forKey:@"groupName"];
    [parameters setObject:userIds forKey:@"userId"];
    
    return [[RCAPIClient sharedClient] POST:@"group/create.json" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *code = [responseObject valueForKeyPath:@"code"];
        block(code, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"API Error");
    }];
}

+ (NSURLSessionDataTask *)syncGroupWithGroupId:(NSString *)groupId userIds:(NSArray *)userIds groupName:(NSString *)groupName block:(void (^)(NSString *code, NSError *))block {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:groupId forKey:@"groupId"];
    [parameters setObject:groupName forKey:@"groupName"];
    for (NSString *userId in userIds) {
        [parameters setObject:userId forKey:@"userId"];
    }
    return [[RCAPIClient sharedClient] POST:@"group/sync.json" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *code = [responseObject valueForKeyPath:@"code"];
        block(code, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"API Error");
    }];
}


@end
