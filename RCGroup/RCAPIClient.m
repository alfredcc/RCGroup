//
//  RCAPIClient.m
//  RCGroup
//
//  Created by race on 18/10/2016.
//  Copyright © 2016 com.chao. All rights reserved.
//

#import "RCAPIClient.h"
#import "NSString+Hashes.h"

static NSString * const RCAPIBaseURLString = @"http://api.cn.ronghub.com/";

@implementation RCAPIClient

+ (instancetype)sharedClient {
    static RCAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[RCAPIClient alloc] initWithBaseURL:[NSURL URLWithString:RCAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        NSString *appSecret = @"OHJw3pD2y7oZ";
        NSString *timestamp = [[NSString alloc] initWithFormat:@"%ld",(NSInteger)[NSDate timeIntervalSinceReferenceDate]];
        NSString * nonce = [NSString stringWithFormat:@"%d",arc4random()];
        NSString * appkey = @"pvxdm17jxm03r";
        NSString * signature = [[NSString stringWithFormat:@"%@%@%@",appSecret,nonce,timestamp] sha1];
        
        // 需要提供 4 个 HTTP Request Header
        [_sharedClient.requestSerializer setValue:appkey forHTTPHeaderField:@"App-Key"];
        [_sharedClient.requestSerializer setValue:nonce forHTTPHeaderField:@"Nonce"];
        [_sharedClient.requestSerializer setValue:timestamp forHTTPHeaderField:@"Timestamp"];
        [_sharedClient.requestSerializer setValue:signature forHTTPHeaderField:@"Signature"];
        [_sharedClient.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

    });
    
    return _sharedClient;
}

@end
