//
//  User.m
//  RCGroup
//
//  Created by race on 18/10/2016.
//  Copyright © 2016 com.chao. All rights reserved.
//

#import "AppUser.h"
#import "RCAPIClient.h"

@implementation AppUser

+ (NSURLSessionDataTask *)fetchUserInfoWithBlock:(void (^)(AppUser *user, NSError *))block {
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

@implementation AppUser (NSCoding)

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userID forKey:@"RC.userID"];
    [aCoder encodeObject:self.token forKey:@"RC.token"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.userID = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"RC.userID"];
    self.token = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"RC.token"];
    
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
