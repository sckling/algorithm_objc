//
//  Array.m
//  algorithm_objc
//
//  Created by Stephen Ling on 10/11/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import "Array.h"
#import "NSArray+Methods.h"

@interface Array()
@property (assign) NSUInteger enumeratorIdx;
@property (nonatomic, strong) NSMutableArray *enumeratorArray;
@end

@implementation Array

- (void)setup {
    // max subarray = 4, -1, 2, 1 = 6
//    NSArray *array1 = @[@-2, @1, @-3, @4, @-1, @2, @1, @-5, @4];
//    [self passArrayByReference:&array1];
//    NSLog(@"New array after pass by reference: %@", array1);
//    
//    NSLog(@"Maximum sub-array sum: %ld", [array1 maximumSubArraySum]);
//    
//    NSArray *array2 = @[@2, @7, @2, @-2, @5, @-7];
//    [array2 findPairsOfElementsEqualToSum:7];
//    NSArray *array3 = @[@2, @4, @7, @10];
//    NSInteger number = 10;
//    NSLog(@"Binary search of %ld found: %ld", (long)number, (long)[array3 binarySearch:0 end:array3.count-1 number:number]);
//    
//    NSArray *array4 = @[@"b", @"d", @"g", @"k"];
//    NSLog(@"Binary search %@ found: %lu", @"b", (unsigned long)[array4 binarySearch:0 end:array4.count-1 character:@"z"]);
//    
//    NSArray *array5 = @[@3, @0, @-1, @4, @5, @0, @2, @0];
//    [array5 sortArrayZeros:[array5 mutableCopy]];

    self.enumeratorIdx = 0;
    self.enumeratorArray = [NSMutableArray arrayWithArray:@[@"a", @"b", @[@"c", @[@"d"]], @[ @[@"e", @[@"f"]], @"g" ] ]];
    self.enumeratorArray = [self.enumeratorArray mutableCopy];
}

// NSEnumerator
- (id)nextObject {
    if (self.enumeratorArray.count > 0) {
        id obj = self.enumeratorArray[0];
        [self.enumeratorArray removeObjectAtIndex:0];
        return [self firstObject:obj];
    }
    return nil;
}

// Takes out the first object and insert it back to the array recursively until the object is a string, then return it
- (id)firstObject:(id)obj {
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }
    else if ([obj isKindOfClass:[NSArray class]]) {
        NSMutableArray *newArray = [obj mutableCopy];
        id firstObj = newArray[0];
        [newArray removeObjectAtIndex:0];

        if (newArray.count > 0) {
            [self.enumeratorArray insertObject:[newArray copy] atIndex:0];
        }
        return [self firstObject:firstObj];
    }
    return nil;
}

- (void)passArrayByReference:(NSArray **)array {
    NSLog(@"Original array: %@", *array);
    NSArray *newArray = @[@1, @2, @3];
    *array = newArray;
}

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
    self.propertyBlock = ^NSString *(int a, float b){return @"property block";};
    [self executeBlock:self.propertyBlock];
    [self executeBlock:^NSString *(int a, float b){return @"inline defined block";}];
    [self executeDispatchBlock:^void{NSLog(@"Inside a dispatch block");}];
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
    
    // Execute typedef block
    newTypeDefBlock anotherBlock = ^NSNumber *(int a, NSNumber *b) {return @(a+[b integerValue]);};
    self.aTypeDefBlock = anotherBlock;
    NSLog(@"Execute a typedef block: %@", self.aTypeDefBlock(1, @2));
    
}

@end
