//
//  TreeNode.m
//  algorithm_objc
//
//  Created by Stephen Ling on 10/10/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import "TreeNode.h"

@implementation TreeNode

- (id)initWithValue:(id)value {
    self = [super init];
    if (self != nil) {
        _value = value;
    }
    return self;
}

// For subclasses of this class, if override copyWithZone, must call [super copyWithZone:zone] first, unless subclass descend direcly from NSObject
- (id)copyWithZone:(NSZone *)zone {
    id copy = [[[self class] alloc] init];
    if (copy) {
        [copy setLeft:[self.left copyWithZone:zone]];
        [copy setRight:[self.right copyWithZone:zone]];
        [copy setValue:[self.value copyWithZone:zone]];
    }
    return copy;
}

- (void)insertNode:(TreeNode *)node {
    if (node.value != nil) {
        if ([node.value isGreaterThanOrEqualTo:self.value]) {
            if (self.right) {
                [self.right insertNode:node];
            }
            else {
                self.right = node;
            }
        }
        else if ([node.value isLessThan:self.value]) {
            if (self.left) {
                [self.left insertNode:node];
            }
            else {
                self.left = node;
            }
        }
    }
}

- (void)insertValue:(id)value {
    if ([value isGreaterThanOrEqualTo:self.value]) {
        if (self.right) {
            [self.right insertValue:value];
        }
        else {
            self.right = [[TreeNode alloc] initWithValue:value];
        }
    }
    else if ([value isLessThan:self.value]) {
        if (self.left) {
            [self.left insertValue:value];
        }
        else {
            self.left = [[TreeNode alloc] initWithValue:value];
        }
    }
}

- (void)depthFirstTraverse:(TreeNode *)node order:(Order)order {
    if (node) {
        if (order == PreOrder) {
            NSLog(@"Pre-order: %@", node.value);
        }
        [self depthFirstTraverse:node.left order:order];
        if (order == InOrder) {
            NSLog(@"In-order: %@", node.value);
        }
        [self depthFirstTraverse:node.right order:order];
        if (order == PostOrder) {
            NSLog(@"Post-order: %@", node.value);
        }
    }
}

- (void)breadthFirstTraverse:(TreeNode *)node {
    NSMutableArray *queue = [NSMutableArray new];
    [queue addObject:node];
    while (queue.count > 0) {
        TreeNode *tempNode = [queue firstObject];
        NSLog(@"%@", tempNode.value);
        if (tempNode.left) {
            [queue addObject:tempNode.left];
        }
        if (tempNode.right) {
            [queue addObject:tempNode.right];
        }
        [queue removeObjectAtIndex:0];
    }
}

//        20
//      /    \
//     8     22
//   /  \      \
//  4    12    99
//       / \
//      10 14
// Keep track of the nodes in the same level in the same queue
// Use queue for current level, queueNext to store next level

- (void)breadthFirstTraverseByLevel:(TreeNode *)node {
    NSMutableArray *currentQueue = [NSMutableArray new];
    NSMutableArray *nextQueue = [NSMutableArray new];
    [currentQueue addObject:node];
    while (currentQueue.count > 0) {
        TreeNode *tempNode = [currentQueue firstObject];
        NSLog(@"%@", tempNode.value);
        if (tempNode.left) {
            [nextQueue addObject:tempNode.left];
        }
        if (tempNode.right) {
            [nextQueue addObject:tempNode.right];
        }
        [currentQueue removeObjectAtIndex:0];
        if (currentQueue.count == 0) {
            currentQueue = [nextQueue mutableCopy];
            [nextQueue removeAllObjects];
            NSLog(@"Next");
        }
    }
}

- (NSUInteger)depthOfTree:(TreeNode *)node {
    if (node == nil) {
        return 0;
    }
    NSUInteger left = [self depthOfTree:node.left];
    NSUInteger right = [self depthOfTree:node.right];
    if (left>right) {
        return left+1;
    }
    return right+1;
}

// For unit test demo only
- (NSInteger)addNums:(NSInteger)num1 num2:(NSInteger)num2 {
    return num1 + num2;
}

@end
