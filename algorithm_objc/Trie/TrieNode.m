//
//  TrieNode.m
//  algorithm_objc
//
//  Created by ling, stephen on 3/24/18.
//  Copyright © 2018 sling. All rights reserved.
//

#import "TrieNode.h"

@implementation TrieNode

- (instancetype)init {
    self = [super init];
    if (self) {
        _children = [NSMutableDictionary new];
        _isEndOfWord = NO;
    }
    return self;
}

@end
