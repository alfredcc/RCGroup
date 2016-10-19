//
//  RCDataManager.h
//  RCGroup
//
//  Created by race on 19/10/2016.
//  Copyright © 2016 com.chao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCDataManager : NSObject

+ (instancetype)sharedManager;

- (void)syncFriendListWithBlock:(void (^)(NSMutableArray* friends))block;
@end
