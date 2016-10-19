//
//  NewGroupViewController.m
//  RCGroup
//
//  Created by race on 19/10/2016.
//  Copyright © 2016 com.chao. All rights reserved.
//

#import "NewGroupViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "RCDataManager.h"
#import "RCAPIProvider.h"
#import "AppDelegate.h"
#import "NSString+Hashes.h"

@interface NewGroupViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSMutableSet *userIds;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NewGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (IBAction)downItemTapped:(UIBarButtonItem *)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"群组"
                                                                             message: @"请输入群名称"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入群名";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleNone;
    }];

    [alertController addAction:[UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
        NSString *userIdsString = [[self.userIds allObjects] componentsJoinedByString:@","];
        NSString *groupId = [[NSString stringWithFormat:@"%@%@",userIdsString,namefield.text] sha1];
        NSLog(@"%@", groupId);
        [RCAPIProvider createGroupWithGroupId:groupId userIds:self.userIds groupName:namefield.text block:^(NSString *code, NSError *error) {
            NSLog(@"%@", code);
            if (error == nil) {
//                RCConversationViewController *conversationVC = [[RCConversationViewController alloc] init];
//                conversationVC.conversationType = ConversationType_GROUP;
//                conversationVC.targetId = groupId;
//                conversationVC.title = [NSString stringWithFormat:@"%@",namefield.text];
//                [self.navigationController pushViewController:conversationVC animated:YES];
                [self dismissViewControllerAnimated:true completion:nil];
            }
        }];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)cancleItemTapped:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"friendCell"];
    RCUserInfo *userInfo = self.dataSource[indexPath.row];
    cell.textLabel.text = userInfo.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RCUserInfo *userInfo = self.dataSource[indexPath.row];
    NSLog(@"%@", userInfo.userId);
    [self.userIds addObject:userInfo.userId];
}


#pragma mark - getters and setters

- (NSArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSArray alloc] init];
        _dataSource = [AppDelegate shareAppDelegate].friendsArray;
    }
    return _dataSource;
}

- (NSMutableSet *)userIds {
    if (_userIds == nil) {
        _userIds = [[NSMutableSet alloc] init];
        [_userIds addObject:[AppDelegate shareAppDelegate].currentUserId];
    }
    return _userIds;
}
@end
