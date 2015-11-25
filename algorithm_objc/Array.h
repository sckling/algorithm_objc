//
//  Array.h
//  algorithm_objc
//
//  Created by Stephen Ling on 10/11/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Array : NSEnumerator

typedef NSNumber *(^newTypeDefBlock)(int, NSNumber *);

@property (nonatomic, copy) newTypeDefBlock aTypeDefBlock;
@property (nonatomic, copy) NSString * (^propertyBlock)(int, float);

- (void)setup;
- (void)blockExecution;
- (void)executeDispatchBlock:(dispatch_block_t)block;
- (void)executeBlock:(NSString * (^)(int a, float b))myBlock;

@end
