//
//  FriendListViewController.m
//  RCGroup
//
//  Created by race on 19/10/2016.
//  Copyright © 2016 com.chao. All rights reserved.
//

#import "FriendListViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "RCDataManager.h"
#import "UIImageView+AFNetworking.h"

@interface FriendListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FriendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [[RCDataManager sharedManager] syncFriendListWithBlock:^(NSMutableArray *friends) {
        self.dataSource = friends;
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"friendCell"];
    RCUserInfo *userInfo = self.dataSource[indexPath.row];
    cell.textLabel.text = userInfo.name;
    [cell.imageView setImageWithURL:[NSURL URLWithString:userInfo.portraitUri]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RCUserInfo *userInfo = self.dataSource[indexPath.row];
    
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:userInfo.userId];
    conversationVC.title = userInfo.name;
    conversationVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:conversationVC animated:YES];
}


#pragma mark - getters and setters

- (NSArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSArray alloc] init];
    }
    return _dataSource;
}
@end
