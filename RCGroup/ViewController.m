//
//  ViewController.m
//  Group
//
//  Created by race on 18/10/2016.
//  Copyright © 2016 com.racechao. All rights reserved.
//

#import "ViewController.h"
#import "ChatListViewController.h"
#import "RCAPIProvider.h"
#import "AppUser.h"
#import "AppDelegate.h"
#import "RCDataManager.h"

static NSString * const showTabBar = @"presentTabBarVC";

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self _viewSetup];
        
}

- (void)_viewSetup {
    self.loginButton.layer.cornerRadius = 5.0;
    [self.loginButton addTarget:self action:@selector(loginRongCloud) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loginRongCloud {
    NSString *userID = _userIdTextField.text;
    NSString *userName = _userIdTextField.text;
    
    [RCAPIProvider loginWithUserId:userID name:userName block:^(AppUser *user, NSError *error) {
        [[RCIM sharedRCIM] connectWithToken: user.token success:^(NSString *userId) {
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
            [AppDelegate shareAppDelegate].currentUserId = userId;
            [[RCIM sharedRCIM] setUserInfoDataSource:self];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:showTabBar sender:nil];
//                ChatListViewController *chatListViewController = [[ChatListViewController alloc]init];
//                [self.navigationController pushViewController:chatListViewController animated:YES];
            });
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%ld", (long)status);
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
        }];
    }];
}

// 在方法中要提供给融云用户的信息, 缓存在本地
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
    for (RCUserInfo *user in [AppDelegate shareAppDelegate].friendsArray) {
        if ([userId isEqualToString:user.userId]) {
            completion(user);
            break;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
