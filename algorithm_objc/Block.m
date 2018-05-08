//
//  Block.m
//  algorithm_objc
//
//  Created by Stephen Ling on 12/13/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import "Block.h"

@implementation Block

- (void)blockExecution {
    // We supply the executeBlock method with this inline defined block.
    // executeBlock can execute this block and it'll return an NSString whenever it's executed
    NSLog(@"First run of block");
    [self executeBlock:^NSString *(int a, float b) {
        float c = a + b;
        NSString *string = [NSString stringWithFormat:@"Block result: %lf", c];
        NSLog(@"%@", string);
        return string;
    }];
    
    NSLog(@"Second run of block");
    self.propertyBlock = ^NSString *(int a, float b) {
        return @"property block";
    };
    [self executeBlock:self.propertyBlock];
    [self executeBlock:^NSString *(int a, float b) {
        printf("inline defined block %d, %.1f", a, b);
        return @"inline defined block";
    }];
    [self executeDispatchBlock:^void{
        NSLog(@"Inside a dispatch block");
    }];
}

- (void)executeDispatchBlock:(dispatch_block_t)block {
    // typedef void (^dispatch_block_t)(void);
    block();
}

- (void)executeBlock:(NSString *(^)(int, float))myBlock {
    int a = 10;
    float b = 20;
    
    // myBlock function already defined, supply it with the required parameters and it'll return the result
    if (myBlock) {
        NSString *result = myBlock(a, b);
        NSLog(@"Execute input myBlock: %@", result);
    }
    
    // Define newBlock
    NSString *(^newBlock)(int, float) = ^NSString *(int a, float b) {
        return @"something";
    };
    
    // Execute new block
    NSLog(@"Execute newBlock created inside a method: %@", newBlock(a, b));
    
    // Local variable
    dispatch_block_t localBlock = ^void{NSLog(@"Execute a localBlock");};
    localBlock();
    
    // Create a typedef block: take int and NSNumber and returns NSNumber
    newTypeDefBlock anotherBlock = ^NSNumber *(int a, NSNumber *b) {
        return @(a+[b integerValue]);
    };
    self.aTypeDefBlock = anotherBlock;
    NSLog(@"Execute a typedef block: %@", self.aTypeDefBlock(1, @2));
}


@end
