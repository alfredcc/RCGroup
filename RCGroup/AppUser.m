//
//  User.m
//  RCGroup
//
//  Created by race on 18/10/2016.
//  Copyright © 2016 com.chao. All rights reserved.
//

#import "AppUser.h"


@implementation AppUser


@end

@implementation AppUser (NSCoding)

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userID forKey:@"RC.userID"];
    [aCoder encodeObject:self.token forKey:@"RC.token"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.userID = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"RC.userID"];
    self.token = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"RC.token"];
    
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
