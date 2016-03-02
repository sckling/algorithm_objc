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
- (NSUInteger)depthOfTree:(TreeNode *)node;
- (void)allPathsOfTree:(TreeNode *)node path:(NSMutableArray *)path;
- (void)deSerialize:(TreeNode **)node array:(NSMutableArray *)array;
- (TreeNode *)deSerialize1:(TreeNode *)node array:(NSMutableArray *)array;

// For unit test demo only
- (NSInteger)addNums:(NSInteger)num1 num2:(NSInteger)num2;

@end
