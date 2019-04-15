//
//  TreeNode.h
//  algorithm_objc
//
//  Created by Stephen Ling on 10/10/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeNode : NSObject <NSCopying>

@property (nonatomic, strong) TreeNode *left;
@property (nonatomic, strong) TreeNode *right;
@property (nonatomic, strong) NSMutableArray<TreeNode *> *nodes;
@property (nonatomic, strong) id value;

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
- (void)breadthFirstTraverseByLevelSingleQueue:(TreeNode *)node;
- (int)depthOfTree:(TreeNode *)node;
- (void)allPathsOfTree:(TreeNode *)node path:(NSMutableArray *)path;
//- (void)deSerialize:(TreeNode **)node array:(NSMutableArray *)array;
//- (TreeNode *)deSerialize1:(TreeNode *)node array:(NSMutableArray *)array;
- (TreeNode *)largestNodeInBST:(TreeNode *)node;
- (TreeNode *)secondLargestNodeInBST:(TreeNode *)node parent:(TreeNode *)parent;
- (Boolean)checkBST:(TreeNode *)node;
- (TreeNode *)largestValue:(TreeNode *)node value:(NSInteger)value;
- (TreeNode *)largestValue2:(TreeNode *)node value:(NSInteger)value;
- (int)diameterOfTree:(TreeNode *)root;
- (void)enumerateNodes:(void(^)(NSString *string))block;
- (BOOL)pathEqualToSum:(TreeNode *)node sum:(int)sum;
- (void)reverseTree:(TreeNode *)root;
- (NSString *)serialize:(TreeNode *)root;
- (TreeNode *)deserialize:(NSString *)nodes;
- (NSString *)serializeBFS:(TreeNode *)root;
- (TreeNode *)deserializeBFS:(NSString *)nodes;


// For unit test demo only
- (NSInteger)addNums:(NSInteger)num1 num2:(NSInteger)num2;

@end
