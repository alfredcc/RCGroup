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
/**
 *  将该群解散，所有用户都无法再接收该群的消息。
 *
 *  @param groupId 要解散的群 Id。（必传）
 *  @param userId  操作解散群的用户 Id。（必传）
 *  @param block   请求成功回调
 *
 *  @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)loginWithUserId:(NSString *)userId name:(NSString *)name block:(void (^)(AppUser *user, NSError *error))block;
/**
 *  创建群组 方法
 *
 *  @param groupId   创建群组 Id。（必传）
 *  @param userIds   要加入群的用户 Id。（必传）
 *  @param groupName 群组 Id 对应的名称。（必传）
 *  @param block     block   请求成功回调
 *
 *  @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)createGroupWithGroupId:(NSString *)groupId userIds:(NSSet *)userIds groupName:(NSString *)groupName block:(void (^)(NSString *code, NSError *))block;
/**
 *  加入群组 方法
 *
 *  @param groupId   要加入的群 Id。（必传）
 *  @param userIds   要加入群的用户 Ids，可提交多个，最多不超过 1000 个。（必传）
 *  @param groupName 要加入的群 Id 对应的名称。（必传）
 *  @param block     请求成功回调
 *
 *  @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)joinGroupWithGroupId:(NSString *)groupId userIds:(NSSet *)userIds groupName:(NSString *)groupName block:(void (^)(NSString *code, NSError *))block;
/**
 *  退出群组 方法
 *
 *  @param groupId 要退出的群 Id。（必传）
 *  @param userId  要退出群的用户 Id。（必传）
 *  @param block   请求成功回调
 *
 *  @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)quitGroupWithGroupId:(NSString *)groupId userId:(NSString *)userId block:(void (^)(NSString *code, NSError *))block;
/**
 *  将该群解散，所有用户都无法再接收该群的消息。
 *
 *  @param groupId 要解散的群 Id。（必传）
 *  @param userId  操作解散群的用户 Id。（必传）
 *  @param block   请求成功回调
 *
 *  @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)dismissGroupWithGroupId:(NSString *)groupId userId:(NSString *)userId block:(void (^)(NSString *code, NSError *))block;
/**
 *  查询群成员 方法
 *
 *  @param groupId 群 Id。（必传）
 *  @param block   请求成功回调
 *
 *  @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)queryGroupUserWithGroupId:(NSString *)groupId block:(void (^)(NSArray *users, NSError *))block;

+ (NSURLSessionDataTask *)sendGroupMessageFromUserId:(NSString *)userId toGroupId:(NSString *)toGroupId content:(NSString *)content block:(void (^)(NSString *code, NSError *))block;

@end
