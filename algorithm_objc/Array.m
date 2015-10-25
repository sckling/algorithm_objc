//
//  Array.m
//  algorithm_objc
//
//  Created by Stephen Ling on 10/11/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import "Array.h"
#import "NSArray+Methods.h"

@implementation Array

- (void)executeBlock:(NSString *(^)(int, float))myBlock {
    int a = 10;
    float b = 20;
    // myBlock function already defined, calling it to execute
    NSString *result = myBlock(a, b);
    NSLog(@"Result: %@", result);
    
    // Define newBlock
    NSString *(^newBlock)(int, float) = ^NSString *(int a, float b) {
        return @"something";
    };
    
    // execute new block
    result = newBlock(a, b);
    NSLog(@"Result: %@", result);
}

- (void)setup {
    // max subarray = 4, -1, 2, 1 = 6
    NSArray *array1 = @[@-2, @1, @-3, @4, @-1, @2, @1, @-5, @4];
    [self passArrayByReference:&array1];
    NSLog(@"New array: %@", array1);
    
    NSLog(@"Maximum sub-array sum: %ld", [array1 maximumSubArraySum]);
    
    NSArray *array2 = @[@2, @7, @2, @-2, @5, @-7];
    [array2 findPairsOfElementsEqualToSum:7];
    NSArray *array3 = @[@2, @4, @7, @10];
    NSInteger number = 10;
    NSLog(@"Binary search of %ld found: %ld", (long)number, (long)[array3 binarySearch:0 end:array3.count-1 number:number]);
    
    NSArray *array4 = @[@"b", @"d", @"g", @"k"];
    NSLog(@"Binary search %@ found: %lu", @"b", (unsigned long)[array4 binarySearch:0 end:array4.count-1 character:@"z"]);
}

- (void)passArrayByReference:(NSArray **)array {
    NSLog(@"Original array: %@", *array);
    NSArray *newArray = @[@1, @2, @3];
    *array = newArray;
}


@end
