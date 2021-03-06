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

- (NSString *)serialize:(TreeNode *)node {
    if (!node) {
        return @"#";
    }
    return [NSString stringWithFormat:@"%@,%@,%@", node.value, [self serialize:node.left], [self serialize:node.right]];
}

- (TreeNode *)deserialize:(NSString *)string {
    NSArray<NSString *> *a = [string componentsSeparatedByString:@","];
    return [self deserializeDFS:[a mutableCopy]];
}

- (TreeNode *)deserializeDFS:(NSMutableArray *)a {
    if (a.count == 0 || [a[0] isEqualToString:@"#"]) {
        [a removeObjectAtIndex:0];
        return nil;
    }
    TreeNode *node = [[TreeNode alloc] initWithValue:@([[a firstObject] integerValue])];
    [a removeObjectAtIndex:0];
    node.left = [self deserializeDFS:a];
    node.right = [self deserializeDFS:a];
    return node;
}

- (NSString *)serializeBFS:(TreeNode *)root {
    NSMutableString *s = [NSMutableString new];
    NSMutableArray *q = [NSMutableArray new];
    [q addObject:root];
    
    while (q.count > 0) {
        TreeNode *n = [q firstObject];
        [q removeObjectAtIndex:0];
        NSString *next = n.value ? [NSString stringWithFormat:@"%@,", n.value] : @"n,";
        [s appendString:next];
        if (n.value) {
            [q addObject:n.left ? n.left : [TreeNode new]];
            [q addObject:n.right ? n.right : [TreeNode new]];
        }
    }
    return s;
}

- (TreeNode *)deserializeBFS:(NSString *)nodes {
    NSMutableArray *q = [NSMutableArray new];
    NSArray<NSString *> *a = [nodes componentsSeparatedByString:@","];
    int i = 0;
    TreeNode *node = [[TreeNode alloc] initWithValue:a[i++]];
    [q addObject:node];
    while (q.count > 0) {
        TreeNode *n = [q firstObject];
        [q removeObjectAtIndex:0];

        NSNumber *left = [a[i] isEqualToString:@"n"] ? nil : @([a[i] integerValue]);
        if (left) {
            n.left = [[TreeNode alloc] initWithValue:left];
            [q addObject:n.left];
        }
        i++;
        NSNumber *right = [a[i] isEqualToString:@"n"] ? nil : @([a[i] integerValue]);
        if (right) {
            n.right = [[TreeNode alloc] initWithValue:right];
            [q addObject:n.right];
        }
        i++;
    }
    return node;
}


/*
 NSArray *array = @[@20, @8, @4, @12, @10, @14, @22, @99, @90, @80, @95];
 TreeNode *root = [self createBinarySearchTree:array];
 [root enumerateNodes:^(NSString *string) {
    NSLog(@"Node: %@", string);
 }];
 */

- (void)enumerateNodes:(void (^)(NSString *))block {
    if (block) {
        [self.left enumerateNodes:block];
        block(self.value);
        [self.right enumerateNodes:block];
    }
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

- (BOOL)areTreesEqual:(TreeNode *)r1 tree:(TreeNode *)r2 {
    if (r1 == nil && r2 == nil) {
        return YES;
    }
    NSMutableArray *q1 = [NSMutableArray new];
    NSMutableArray *q2 = [NSMutableArray new];
    [q1 addObject:r1];
    [q2 addObject:r2];
    while (q1.count > 0 && q2.count > 0) {
        TreeNode *n1 = [q1 firstObject];
        TreeNode *n2 = [q2 firstObject];
        [q1 removeObject:n1];
        [q2 removeObject:n2];
        // Check if both nodes are same class
        if (![q1.className isEqualToString:q2.className]) {
            return NO;
        }
        // Check if both nodes have same size of child nodes
        if (n1.nodes.count != n2.nodes.count) {
            return NO;
        }
        [q1 addObjectsFromArray:n1.nodes];
        [q2 addObjectsFromArray:n2.nodes];
    }
    return YES;
}

// Can pass only numbmer and subtract that until reaches to zero
// Time complexity O(n), n=number of tree nodes
// Need to take care of edge case like node is nil or single node
- (BOOL)pathEqualToSum:(TreeNode *)node sum:(int)sum {
    if (!node) {
        return NO;  // return (sum == number); Does it matter?
    }
//    NSLog(@"%@", node.value);
    int subsum = sum - [(NSNumber *)node.value intValue];
    // Optimize to return NO if sum exceed number. No need to continue this path
    if (subsum < 0) {
        return NO;
    }
    // If reaches leaf node, check if sum is equal to number
    if (!node.left && !node.right) {
//        return (sum == number) ? YES : NO;  <- No need. See next line
        return (subsum == 0);
    }
//    if ([self pathEqualToSum:node.left sum:subsum] == YES) {
//        return YES;
//    }
    // Continue on right node if left node doesn't has a path to sum
//    return [self pathEqualToSum:node.right sum:subsum];
    
    // Can do this in one line. If first method call returns YES, the second method call won't run
    return ([self pathEqualToSum:node.left sum:subsum] || [self pathEqualToSum:node.right sum:subsum]);
}

// Use BFS and traverse tree in level order. For each node, swap left and right nodes. O(n), n=number of tree nodes
- (void)reverseTree:(TreeNode *)root {
    if (!root) {
        return;
    }
    NSMutableArray *queue = [NSMutableArray new];
    [queue addObject:root];
    while (queue.count > 0) {
        TreeNode *node = [queue firstObject];
        [queue removeObjectAtIndex:0];
        TreeNode *temp = node.left;
        node.left = node.right;
        node.right = temp;
        NSLog(@"%@, ", node.value);
        if (node.left) {
            [queue addObject:node.left];
        }
        if (node.right) {
            [queue addObject:node.right];
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
//       / \   /
//      10 14 90
//            / \
//           80  95

- (void)allPathsOfTree:(TreeNode *)node path:(NSArray *)path {
    // if node == nil => previous node's left or right child is empty, but not both
    if (node == nil) {
        return;
    }
    NSMutableArray *newPath = [NSMutableArray arrayWithArray:path];
    [newPath addObject:node.value];
    // NSLog(@"node: %@", node.value);
    // Check if the node is an end node that has no left and right children
    if ((node.left == nil) && (node.right == nil)) {
        NSLog(@"Path: %@", newPath);
    }
    else {
        [self allPathsOfTree:node.left path:newPath];
        [self allPathsOfTree:node.right path:newPath];
    }
}

// For unit test demo only
- (NSInteger)addNums:(NSInteger)num1 num2:(NSInteger)num2 {
    return num1 + num2;
}

/*
 We know in a BST, the right node is always bigger. So we traverse to right node if available
 We can pass the current node for every traverse. When at the end of node, return nil and the previous stack and return it's value
 */
- (TreeNode *)largestNodeInBST:(TreeNode *)node {
	if (!node) {
		return nil;
	}
	if (!node.left && !node.right) {
		return node;
	}
	if (node.right) {
		return [self largestNodeInBST:node.right];
	}
	return [self largestNodeInBST:node.left];;
}


- (TreeNode *)secondLargestNodeInBST:(TreeNode *)node parent:(TreeNode *)parent {
	if (!node) {
		return nil;
	}
	if (!node.left && !node.right) {
		return parent ? parent : node;
	}
	if (node.right) {
		return [self secondLargestNodeInBST:node.right parent:node];
	}
	return [self secondLargestNodeInBST:node.left parent:node];
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
