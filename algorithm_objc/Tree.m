//
//  Tree.m
//  algorithm_objc
//
//  Created by Stephen Ling on 10/11/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import "Tree.h"
#import "TreeNode.h"

@implementation Tree

- (void)setup {
    TreeNode *node = [[TreeNode alloc] initWithValue:@2];
    TreeNode *left = [[TreeNode alloc] initWithValue:@1];
    TreeNode *right = [[TreeNode alloc] initWithValue:@3];
    node.left = left;
    node.right = right;
    //deep copy of object using NSCopying
    node = [left copy];

    //   3
    //  2 6
    // Pre-order: 3, 2, 6. Parent->Left->Right
    // In-order: 2, 3, 6.  Left->Parent->Right. Sort all the node from small to large
    // Post-order: 2, 6, 3 Left->Right->Parent
    //
    //        20
    //      /    \
    //     8     22
    //   /  \      \
    //  4    12    99
    //       / \
    //      10 14
    
    //NSArray *array = @[@3, @2, @6];
    //NSArray *array = @[@"j", @"f", @"a", @"d", @"h", @"k", @"z"];
    //NSArray *array = @[@"c", @"b", @"f"];
    NSArray *array = @[@20, @8, @4, @12, @10, @14, @22, @99];
    TreeNode *root = [self createBinarySearchTree:array];
    NSLog(@"Depth of tree: %ld", [root depthOfTree:root]);
//    [root breadthFirstTraverse:root];
    [root breadthFirstTraverseByLevel:root];
//    NSMutableArray *path = [NSMutableArray arrayWithCapacity:array.count];
//    [root allPathsOfTree:root path:path];
//    [root depthFirstTraverse:root order:PreOrder];
//    [root depthFirstTraverse:root order:InOrder];
//    [root depthFirstTraverse:root order:PostOrder];
    
    NSArray *serialized = @[@20, @8 ,@4 ,@-1 ,@-1 ,@12 ,@10 ,@-1 ,@-1 ,@14 ,@-1 ,@-1 ,@-1];
    root = [[TreeNode alloc] init];
    
    TreeNode *binaryTree = [root deSerialize1:root array:[serialized mutableCopy]];
    [binaryTree depthFirstTraverse:binaryTree order:InOrder];
}

- (TreeNode *)createBinarySearchTree:(NSArray *)nodes {
    TreeNode *root = nil;
    for (id value in nodes) {
        if (root == nil) {
            root = [[TreeNode alloc] initWithValue:value];
        }
        else {
            [root insertValue:value];
        }
    }
    return root;
}

@end
