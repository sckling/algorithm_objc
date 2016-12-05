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
    // If the next value is greater than current value, insert to the right child if it's empty, or go to next right to insert
    if ([value isGreaterThanOrEqualTo:self.value]) {
        if (self.right) {
            [self.right insertValue:value];
        }
        else {
            self.right = [[TreeNode alloc] initWithValue:value];
        }
    }
    // If the next value is less than current value, insert to the left child if it's empty, or go to next left to insert
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
        //NSLog(@"%@", tempNode.value);
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
            NSLog(@"Current level");
            for (TreeNode *node in currentQueue) {
                NSLog(@"%@", node.value);
            }
        }
    }
}

- (void)breadthFirstTraverseByLevelSingleQueue:(TreeNode *)node {
    NSUInteger levelNodes = 0;
    NSUInteger treeLevel = 0;
    NSMutableArray *queue = [NSMutableArray new];
    [queue addObject:node];

    while (queue.count > 0) {
        // All nodes queued up for the level
        levelNodes = queue.count;
        printf("Level %ld: ", treeLevel);
        // Within the same level, add all the child nodes from parent nodes
        while (levelNodes > 0) {
            TreeNode *tempNode = [queue firstObject];
            [queue removeObjectAtIndex:0];
            printf("%ld ", (long)[tempNode.value integerValue]);
            if (tempNode.left) {
                [queue addObject:tempNode.left];
            }
            if (tempNode.right) {
                [queue addObject:tempNode.right];
            }
            levelNodes--;
        }
        // Level processing conmpleted. Start next level
        treeLevel++;
        printf("\n");
    }
}

- (int)diameterOfTree:(TreeNode *)root {
    if (root == nil) {
        return 0;
    }
    int left = [self depthOfTree:root.left];
    int right = [self depthOfTree:root.right];
    int ldiameter = [self diameterOfTree:root.left];
    int rdiameter = [self diameterOfTree:root.left];
    printf("LH: %d RH: %d LD: %d RD: %d\n", left, right, ldiameter, rdiameter);
    int diameter = MAX(ldiameter, rdiameter);
    int height = left+right+1;
    return MAX(diameter, height);
}

- (Boolean)checkBST:(TreeNode *)node {
    // In-order traverse with an array
    NSArray *array = [self dfsTraverse:node array:@[]];
    NSLog(@"tree nodes: %@", array);
    
    // In-order traverse without an array, just the previous node
    NSLog(@"tree nodes: %d", [self dfsTraverse:node node:nil]);
    return [self dfsTraverse:node node:nil];
}

- (TreeNode *)largestValue:(TreeNode *)node value:(NSInteger)value {
    // Can pass previous node to avoid static variable
    static TreeNode *previous = nil;
    if (node == nil) {
        return nil;
    }
    [self largestValue:node.left value:value];
    if (previous) {
        if ([node.value integerValue] > value) {
            return previous;
        }
    }
    previous = node;
    [self largestValue:node.right value:value];
    return previous;
}

// Doesn't work?
- (TreeNode *)largestValue2:(TreeNode *)node value:(NSInteger)value {
    static TreeNode *previous = nil;
    if (node == nil) {
        return nil;
    }
    if (previous != nil && [node.value integerValue] > value) {
        return previous;
    }
    if ([node.value integerValue] < value) {
        return [self largestValue:node.left value:value];
    }
    previous = node;
    return [self largestValue:node.right value:value];
}

- (Boolean)dfsTraverse:(TreeNode *)node node:(TreeNode *)previous {
    // An empty tree is consider as BST
    if (node == nil) {
        return YES;
    }
    // Once detected it's not BST, keeps return NO all the way back
    if ([self dfsTraverse:node.left node:previous] == NO) {
        return NO;
    }
    if (previous != nil) {
        // Once detected it's not BST, keeps return NO all the way back
        if ([node.value isLessThan:previous.value]) {
            return NO;
        }
    }
    // Updates previous node and traverse it to the right
    previous = node;
    return [self dfsTraverse:node.right node:previous];
}

- (NSArray *)dfsTraverse:(TreeNode *)node array:(NSArray *)array {
    if (node == nil) {
        return array;
    }
    array = [self dfsTraverse:node.left array:array];
    NSMutableArray *temp = [NSMutableArray arrayWithArray:array];
    [temp addObject:node.value];
    array = [self dfsTraverse:node.right array:temp];
    return array;
}

- (int)depthOfTree:(TreeNode *)node {
    if (node == nil) {
        return 0;
    }
    int left = [self depthOfTree:node.left];
    int right = [self depthOfTree:node.right];
    if (left>right) {
        return left+1;
    }
    return right+1;
}

//        20
//      /    \
//     8     22
//   /  \      \
//  4    12    99
//       / \
//      10 14

- (void)allPathsOfTree:(TreeNode *)node path:(NSArray *)path {
    NSLog(@"node: %@", node.value);
    if (node == nil) {
        //NSLog(@"Path: %@", path);
        return;
    }
    NSMutableArray *newPath = [NSMutableArray arrayWithArray:path];
    [newPath addObject:node.value];
    if ((node.left == nil) && (node.right == nil)) {
        NSLog(@"Path: %@", newPath);
    }
    else {
        [self allPathsOfTree:node.left path:newPath];
        [self allPathsOfTree:node.right path:newPath];
    }
}

- (void)deSerialize:(TreeNode **)node array:(NSMutableArray *)array {
    if (array.count > 0) {
        NSNumber *value = [array firstObject];
        if ([value isEqualTo:@-1]) {
            return;
        }
        *node = [[TreeNode alloc] initWithValue:value];
//        *(node.left) = node;
//        [self deSerialize:*(node.left) array:array];
    }
}

- (TreeNode *)deSerialize1:(TreeNode *)node array:(NSMutableArray *)array {
    //NSLog(@"node: %@ array: %@", node.value, array);
    if (array.count > 0) {
        NSNumber *value = [array firstObject];
        [array removeObjectAtIndex:0];
        if ([value isEqualTo:@-1]) {
            return nil;
        }
        node = [[TreeNode alloc] initWithValue:value];
        node.left = [self deSerialize1:node.left array:array];
        node.right = [self deSerialize1:node.right array:array];
        return node;
    }
    return nil;
}

// For unit test demo only
- (NSInteger)addNums:(NSInteger)num1 num2:(NSInteger)num2 {
    return num1 + num2;
}

// Doesn't work on BST that the largest right node has left node(s)
- (NSInteger)secondLargestInteger:(TreeNode *)node {
    static NSInteger second;
    static NSInteger maxSoFar;
    if (node == nil) {
        return 0;
    }
    // Go all the way to the leftmost
    [self secondLargestInteger:node.left];
    
    NSInteger value = [(NSNumber *)node.value integerValue];
    if (value > maxSoFar) {
        maxSoFar = value;
    }
    NSLog(@"value: %lu", value);
    NSLog(@"max value: %lu", maxSoFar);
    [self secondLargestInteger:node.right];
    if ((value>second)&&(value < maxSoFar)) {
        second = value;
    }
    //NSLog(@"2nd value: %lu", second);
    return second;
}

- (NSInteger)largestValueSmallerThanK:(TreeNode *)node value:(NSInteger)value {
    static NSInteger prev;

    if (node == nil) {
        return 0;
    }
    [self largestValueSmallerThanK:node.left value:value];
    if ([node.value integerValue] < prev) {
        prev = [node.value integerValue];
    }
    
    return [self largestValueSmallerThanK:node.right value:value];
}

// lowest common ancestor of two nodes in a binary tree
- (TreeNode *)findLCA:(TreeNode *)root value:(int)n1 value:(int)n2 {
    TreeNode *node = nil;
    [self findLCAUtility:root value:n1 value:n2 completion:^(TreeNode *lca, BOOL n1Found, BOOL n2Found) {

    }];
    return nil;
}

typedef void(^myCompletion)(BOOL, BOOL);

- (void)findLCAUtility:(TreeNode *)node  value:(int)n1 value:(int)n2 completion:(void(^)(TreeNode *lca, BOOL n1Found, BOOL n2Found))completion {
    completion(nil, YES, YES);
}

// print binary tree in vertical order
/*
 Perform pre-order traversal of the tree. Pass 0 as initial horizontal distance from root
 For left child traversal, hd=hd-1
 For right child traversal, hd+hd+1
 Store the hd as key and node as value (in array)
 To print in order from left to right, need to traverse the hash table to obtain the min and max, and retrieve the values from low to high.
 Runtime = O(n)
 
 */

/*
 Find the largest subtree in a tree that is a BST
 1. Perform an in order traverse of the tree and store nodes in an array (may not be necessary to store in an array)
 2. Traverse the array.
 3. For each subarray that is in order, compare the size to the current largest size.
 4. If it's larger, store it's start node and end node
 10,12,9,10,11,99,20,15

 For each node, if next node is larger and start node is nil, set current node as start node. Increment tree size
 If next node is smaller and start node is not nil, set current node as end node. Compute the final tree size.
 If tree size is greater than current max, update the max size and the start and end nodes
 Reset start and end nodes to nil
 
 start node: 10,9
 end node: 12,99
 size: 2,4
 */


@end
