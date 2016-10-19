//
//  RCDataManager.m
//  RCGroup
//
//  Created by race on 19/10/2016.
//  Copyright © 2016 com.chao. All rights reserved.
//

#import "RCDataManager.h"
#import "AppDelegate.h"
#import <RongIMKit/RongIMKit.h>

@implementation RCDataManager

+ (instancetype)sharedManager {
    static RCDataManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[RCDataManager alloc] init];
    });
    
    return _sharedManager;
}


-(void)syncFriendListWithBlock:(void (^)(NSMutableArray* friends))block {
    NSMutableArray *dataSoure = [[NSMutableArray alloc]init];
    NSArray *portraitURLs = @[@"https://coding.net/static/project_icon/scenery-17.png",
                              @"https://coding.net/static/project_icon/scenery-13.png",
                              @"https://coding.net/static/project_icon/scenery-1.png",
                              @"https://coding.net/static/project_icon/scenery-7.png",
                              @"https://coding.net/static/project_icon/scenery-9.png"];

    NSUInteger portraitIndex = arc4random() % portraitURLs.count;
    for (NSUInteger index = 1; index<100; index++) {
        RCUserInfo *userInfo = [[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"%ld",index] name:[NSString stringWithFormat:@"User%ld",index] portrait: portraitURLs[portraitIndex]];
        [dataSoure addObject:userInfo];
    }
    [AppDelegate shareAppDelegate].friendsArray = dataSoure;
    block(dataSoure);
}

@end
