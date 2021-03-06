//
//  ChatListViewController.m
//  Group
//
//  Created by race on 18/10/2016.
//  Copyright © 2016 com.racechao. All rights reserved.
//

#import "ChatListViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "RCGConversationViewController.h"
#import "FriendListViewController.h"

@interface ChatListViewController ()

@end

@implementation ChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"会话列表";
    
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION)]];
    [self conversationListTableView].tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    // 区分单聊和群组界面
    if (model.conversationType == ConversationType_GROUP) {
        RCGConversationViewController *conversationVC = [[RCGConversationViewController alloc] init];
        conversationVC.conversationType = model.conversationType;
        conversationVC.targetId = model.targetId;
        conversationVC.title = model.conversationTitle;
        conversationVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:conversationVC animated:YES];
    } else {
        RCConversationViewController *conversationVC = [[RCConversationViewController alloc] init];
        conversationVC.conversationType = model.conversationType;
        conversationVC.targetId = model.targetId;
        conversationVC.title = model.conversationTitle;
        conversationVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:conversationVC animated:YES];
    }
}

@end
