//
//  TreeNode.h
//  algorithm_objc
//
//  Created by Stephen Ling on 10/10/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeNode : NSObject <NSCopying>

@property (nonatomic) TreeNode *left;
@property (nonatomic) TreeNode *right;
@property (nonatomic) id value;

typedef enum {
    PreOrder = 1,
    InOrder,
    PostOrder
} Order;

- (id)initWithValue:(id)value;
- (void)insertNode:(TreeNode *)node;
- (void)insertValue:(id)value;
- (void)depthFirstTraverse:(TreeNode *)node order:(Order)order;
- (void)breadthFirstTraverse:(TreeNode *)node;
- (void)breadthFirstTraverseByLevel:(TreeNode *)node;
- (NSUInteger)depthOfTree:(TreeNode *)node;

// lca, binary tree ad binary search tree
// is BST balanced?
// find the largest value that is smaller than n in a BST

// For unit test demo only
- (NSInteger)addNums:(NSInteger)num1 num2:(NSInteger)num2;

@end
