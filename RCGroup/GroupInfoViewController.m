//
//  GroupInfoViewController.m
//  RCGroup
//
//  Created by race on 19/10/2016.
//  Copyright © 2016 com.chao. All rights reserved.
//

#import "GroupInfoViewController.h"
#import "GroupUserCollectionViewCell.h"
#import "RCAPIProvider.h"
#import "AppDelegate.h"
#import "UIImageView+AFNetworking.h"
#import <RongIMKit/RongIMKit.h>

@interface GroupInfoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation GroupInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.collectionView setContentInset:UIEdgeInsetsMake(64, 15, 15, 15)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self _fetchGroupUsers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GroupUserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GroupUserCollectionViewCell" forIndexPath:indexPath];
    RCUserInfo *userInfo = self.dataSource[indexPath.row];
    cell.nameLabel.text = userInfo.userId;
    [cell.portraitImageView setImageWithURL:[NSURL URLWithString:userInfo.portraitUri]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80, 80);
}

#pragma mark - getters and setters

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

#pragma mark - private mothods

- (void)_fetchGroupUsers {
    [RCAPIProvider queryGroupUserWithGroupId:self.groupId block:^(NSArray *users, NSError *error) {
        for (NSDictionary *user in users) {
            NSString *userId = [user objectForKey:@"id"];
            for (RCUserInfo *userInfo in [AppDelegate shareAppDelegate].friendsArray) {
                if ([userInfo.userId isEqualToString:userId]) {
                    [self.dataSource addObject:userInfo];
                    break;
                }
            }
        }
        
        [self.collectionView reloadData];
    }];
}
@end
