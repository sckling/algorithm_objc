//
//  NTree.m
//  algorithm_objc
//
//  Created by ling, stephen on 3/9/19.
//  Copyright © 2019 sling. All rights reserved.
//

#import "NTree.h"

@implementation NTree

- (instancetype)init {
    return [self initWithValue:nil];
}

- (instancetype)initWithValue:(NSString *)value {
    if (self = [super init]) {
        _value = value;
        _nodes = [NSMutableArray new];
    }
    return self;
}

@end
