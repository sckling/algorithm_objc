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
    TreeNode *right = [[TreeNode alloc] initWithValue:@4];
    node.left = left;
    node.right = right;
    right.left = [[TreeNode alloc] initWithValue:@3];
    right.right = [[TreeNode alloc] initWithValue:@5];
    
    /*
        2
       /\
      1  4
         /\
        3  5
     
     */

    //deep copy of object using NSCopying
    //node = [left copy];
    //[node checkBST:node];

    //   3
    //  2 6
    // Pre-order: 3, 2, 6. Parent->Left->Right
    // In-order: 2, 3, 6.  Left->Parent->Right. Sort all the node from small to large
    // Post-order: 2, 6, 3 Left->Right->Parent
    // Input: 85, Largest value smaller than input: 80
    // Input: 11, Largest value smaller than input: 10
    //         20
    //       /   \
    //      /     \
    //     8      22
    //   /  \       \
    //  4    12     99
    //       / \    /
    //      10 14  90
    //             / \
    //            80 95
    
    //NSArray *array = @[@3, @2, @6];
    //NSArray *array = @[@"j", @"f", @"a", @"d", @"h", @"k", @"z"];
    //NSArray *array = @[@"c", @"b", @"f"];
    NSArray *array = @[@20, @8, @4, @12, @10, @14, @22, @99, @90, @80, @95];
    TreeNode *root = [self createBinarySearchTree:array];
    [root breadthFirstTraverseByLevelSingleQueue:root];
    NSString *serialize = [root serialize:root];
//    NSString *serialize = [root serializeBFS:root];
    NSLog(@"Serialize: %@", serialize);
//    TreeNode *new = [root deserializeBFS:serialize];
    TreeNode *new = [root deserialize:serialize];
    [new breadthFirstTraverseByLevelSingleQueue:new];
    
//    NSLog(@"Path to sum 32: %d", [root pathEqualToSum:root sum:32]);
//    NSLog(@"Path to sum 40: %d", [root pathEqualToSum:root sum:40]);
//    NSLog(@"Path to sum 54: %d", [root pathEqualToSum:root sum:54]);
//    NSLog(@"Path to sum 42: %d", [root pathEqualToSum:root sum:42]);
//    NSLog(@"Path to sum 326: %d", [root pathEqualToSum:root sum:326]);
    
//    [root enumerateNodes:^(NSString *string) {
//        NSLog(@"Node: %@", string);
//    }];
    
//    NSLog(@"Depth of tree: %ld", [root depthOfTree:root]);
	TreeNode *t = [root largestNodeInBST:root];
	NSLog(@"Largest node in BST: %@", t.value);
	
	t = [root secondLargestNodeInBST:root parent:nil];
	NSLog(@"Second largest node in BST: %@", t.value);
	
//    [root checkBST:root];
//    NSLog(@"Diameter of tree: %d", [root diameterOfTree:root]);
    
//    NSUInteger value = 21;
//    printf("Largest value smaller than %ld: %ld\n", value, [[root largestValue2:root value:value].value integerValue]);
//    value = 92;
//    printf("Largest value smaller than %ld: %ld\n", value, [[root largestValue2:root value:value].value integerValue]);
    
//    [root breadthFirstTraverseByLevelSingleQueue:root];
//    [root reverseTree:root];
//    [root breadthFirstTraverseByLevelSingleQueue:root];
    
//    NSMutableArray *path = [NSMutableArray arrayWithCapacity:array.count];
//    [root allPathsOfTree:root path:path];

//    [root depthFirstTraverse:root order:PreOrder];
//    [root depthFirstTraverse:root order:InOrder];
//    [root depthFirstTraverse:root order:PostOrder];
    
//    NSArray *serialized = @[@20, @8 ,@4 ,@-1 ,@-1 ,@12 ,@10 ,@-1 ,@-1 ,@14 ,@-1 ,@-1 ,@-1];
//    root = [[TreeNode alloc] init];
//
//    TreeNode *binaryTree = [root deSerialize1:root array:[serialized mutableCopy]];
//    [binaryTree depthFirstTraverse:binaryTree order:InOrder];
//
//    [self buildBinaryTreeSetup];
}

- (void)buildBinaryTreeSetup {
    /*
        5
       / \
      7   1
      /\ /
     2 6 3
        / \
        8 4
     */
//    NSArray *parents  = @[@1,@1,@2,@2,@3,@3,@7,@7];
//    NSArray *children = @[@2,@3,@4,@5,@6,@7,@8,@9];
    NSArray *parents  = @[@7,@1,@5,@7,@3,@5,@3];
    NSArray *children = @[@2,@3,@7,@6,@8,@1,@4];

    TreeNode *root1 = [self buildBinaryTree:parents nodes:children];
    [root1 breadthFirstTraverseByLevelSingleQueue:root1];
}

- (TreeNode *)buildBinaryTree:(NSArray *)parents nodes:(NSArray *)children {
    NSMutableSet *childNodes = [NSMutableSet new];
    for (NSNumber *child in children) {
        [childNodes addObject:child];
    }
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSNumber *root = [NSNumber new];
    for (int i=0; i<parents.count; i++) {
        if ([childNodes containsObject:parents[i]] == NO) {
            root = parents[i];
        }
        if (dict[parents[i]] == nil) {
            TreeNode *parentNode = [[TreeNode alloc] initWithValue:parents[i]];
            TreeNode *childNode = [[TreeNode alloc] initWithValue:children[i]];
            parentNode.left = childNode;
            dict[parents[i]] = parentNode;
        }
        else {
            TreeNode *parentNode = dict[parents[i]];
            TreeNode *child = [[TreeNode alloc] initWithValue:children[i]];
            parentNode.right = child;
            dict[parents[i]] = parentNode;
        }
    }
    for (NSNumber *parent in dict) {
        TreeNode *node = dict[parent];
        NSLog(@"p=%@, c=%@, %@", node.value, node.left.value, node.right.value);
    }
    TreeNode *rootNode = dict[root];
    NSMutableArray *queue = [NSMutableArray new];
    [queue addObject:rootNode];
    while (queue.count > 0) {
        TreeNode *node = queue[0];
        TreeNode *parent = dict[node.value];
        
        [queue removeObjectAtIndex:0];
        if (parent.left) {
            node.left = parent.left;
            [queue addObject:node.left];
        }
        if (parent.right) {
            node.right = parent.right;
            [queue addObject:node.right];
        }
    }
    
    return rootNode;
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
