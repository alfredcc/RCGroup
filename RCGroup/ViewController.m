//
//  ViewController.m
//  Group
//
//  Created by race on 18/10/2016.
//  Copyright © 2016 com.racechao. All rights reserved.
//

#import "ViewController.h"
#import "ChatListViewController.h"
#import "RCAPIClient.h"
#import "AppUser.h"

// 客户端不提供获取 Token的接口, 通过 API 调试的功能获取
NSString * const kUserToken = @"dq4Dareui+f5x+qiy9U7hvuHz/6FdTGTzF/Xcx6QPQGpm65bjSJevkiP85QB/73HotKvEO6r0vX24wBaqAhU9FB1wBFz3p/v";

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self _viewSetup];
    
    
    
   
        
}

- (void)_viewSetup {
    self.loginButton.layer.cornerRadius = CGRectGetHeight(self.loginButton.frame) / 2 ;
    [self.loginButton addTarget:self action:@selector(loginRongCloud) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loginRongCloud {
    
    [AppUser fetchUserInfoWithBlock:^(AppUser *user, NSError *error) {
        NSLog(@"%@", user.token);
        [[RCIM sharedRCIM] connectWithToken: user.token success:^(NSString *userId) {
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
            [[RCIM sharedRCIM] setUserInfoDataSource:self];
            dispatch_async(dispatch_get_main_queue(), ^{
                ChatListViewController *chatListViewController = [[ChatListViewController alloc]init];
                [self.navigationController pushViewController:chatListViewController animated:YES];
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
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
