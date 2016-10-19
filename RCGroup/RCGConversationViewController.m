//
//  RCGConversationViewController.m
//  RCGroup
//
//  Created by race on 19/10/2016.
//  Copyright © 2016 com.chao. All rights reserved.
//

#import "RCGConversationViewController.h"
#import "GroupInfoViewController.h"

@interface RCGConversationViewController ()

@end

@implementation RCGConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemPressed:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 重载右边导航按钮的事件
-(void)rightBarButtonItemPressed:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GroupInfoViewController * viewController = (GroupInfoViewController *)[sb instantiateViewControllerWithIdentifier:@"GroupInfoViewController"];
    viewController.groupId = self.targetId;
    [[self navigationController] pushViewController:viewController animated:true];

}

@end
