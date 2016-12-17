//
//  Block.h
//  algorithm_objc
//
//  Created by Stephen Ling on 12/13/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Block : NSObject

typedef NSNumber *(^newTypeDefBlock)(int, NSNumber *);

@property (nonatomic, copy) newTypeDefBlock aTypeDefBlock;
@property (nonatomic, copy) NSString * (^propertyBlock)(int, float);

- (void)setup;
- (void)blockExecution;
- (void)executeDispatchBlock:(dispatch_block_t)block;
- (void)executeBlock:(NSString * (^)(int a, float b))myBlock;


@end
