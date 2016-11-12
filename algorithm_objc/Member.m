//
//  Member.m
//  algorithm_objc
//
//  Created by Stephen Ling on 11/9/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import "Member.h"

@implementation Member

- (instancetype)initWithName:(NSString *)name memberId:(NSUInteger)memberId {
    return [self initWithName:name memberId:memberId friends:nil];
}

- (instancetype)initWithName:(NSString *)name memberId:(NSUInteger)memberId friends:(NSArray *)friends {
    self = [super init];
    if (self != nil) {
        _name = name;
        _memberId = memberId;
        _friends = friends;
    }
    return self;
}

@end
