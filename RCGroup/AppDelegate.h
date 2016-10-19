//
//  AppDelegate.h
//  Group
//
//  Created by race on 18/10/2016.
//  Copyright © 2016 com.racechao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSMutableArray *friendsArray;
@property (strong, nonatomic) NSString *currentUserId;

+ (AppDelegate* )shareAppDelegate;

@end

