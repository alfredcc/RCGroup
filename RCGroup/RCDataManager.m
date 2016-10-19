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
    NSArray *portraitURLs = @[@"https://coding.net/static/project_icon/scenery-1.png",
                              @"https://coding.net/static/project_icon/scenery-2.png",
                              @"https://coding.net/static/project_icon/scenery-3.png",
                              @"https://coding.net/static/project_icon/scenery-4.png",
                              @"https://coding.net/static/project_icon/scenery-6.png",
                              @"https://coding.net/static/project_icon/scenery-7.png",
                              @"https://coding.net/static/project_icon/scenery-8.png",
                              @"https://coding.net/static/project_icon/scenery-9.png",
                              @"https://coding.net/static/project_icon/scenery-10.png",
                              @"https://coding.net/static/project_icon/scenery-11.png",
                              @"https://coding.net/static/project_icon/scenery-12.png",
                              @"https://coding.net/static/project_icon/scenery-13.png"];
    for (NSUInteger index = 1; index<100; index++) {
        NSUInteger portraitIndex = arc4random() % portraitURLs.count;
        RCUserInfo *userInfo = [[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"User%ld",index] name:[NSString stringWithFormat:@"User%ld",index] portrait: portraitURLs[portraitIndex]];
        [dataSoure addObject:userInfo];
    }
    [AppDelegate shareAppDelegate].friendsArray = dataSoure;
    block(dataSoure);
}

@end
