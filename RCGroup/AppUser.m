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
    [aCoder encodeObject:self.userId forKey:@"RC.userId"];
    [aCoder encodeObject:self.token forKey:@"RC.token"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.userId = [aDecoder decodeObjectOfClass:[AppUser class] forKey:@"RC.userId"];
    self.token = [aDecoder decodeObjectOfClass:[AppUser class] forKey:@"RC.token"];
    
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
