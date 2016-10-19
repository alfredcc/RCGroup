//
//  User.h
//  RCGroup
//
//  Created by race on 18/10/2016.
//  Copyright © 2016 com.chao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AppUser : NSObject

@property (nonatomic, assign) NSString *userId;
@property (nonatomic, strong) NSString *token;



@end

@interface AppUser (NSCoding) <NSSecureCoding>
@end
