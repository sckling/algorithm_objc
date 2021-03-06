//
//  NSArray+Methods.m
//  algorithm_objc
//
//  Created by Stephen Ling on 10/10/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import "NSArray+Methods.h"

@implementation NSArray (Methods)

- (NSInteger)binarySearch:(NSUInteger)start end:(NSUInteger)end number:(NSUInteger)number {
    if (start > end) {
        // key not found
        return -1;
    }
    
    NSUInteger middle = (start+end) / 2;
    NSUInteger currentNumber = [self[middle] integerValue];
    
    if (currentNumber == number) {
        return middle;
    }
    if (currentNumber > number) {
        return [self binarySearch:start end:middle-1 number:number];
    }
    else {
        return [self binarySearch:middle+1 end:end number:number];
    }
}

- (NSUInteger)binarySearch:(NSUInteger)start end:(NSUInteger)end character:(NSString *)character {
    NSUInteger middle = (start+end) / 2;
    NSString *currentChar = self[middle];
    
    if (start < end) {
        if ([currentChar isEqualToString:character]) {
            return middle;
        }
        else if ([currentChar isGreaterThan:character]) {
            return [self binarySearch:start end:middle-1 character:character];
        }
        else if ([currentChar isLessThan:character]) {
            return [self binarySearch:middle+1 end:end character:character];
        }
    }
    [self executeBlock:^id(id object) {
        NSInteger result = [(NSNumber *)object integerValue] * [(NSNumber *)object integerValue];
        return [NSNumber numberWithInteger:result];
    }];
    return start;
}

// Test case 1: Array with 0 element. This method will run infinitely
- (NSInteger)binarySearchIterative:(id)key {
    NSUInteger low = 0;
    NSUInteger high = self.count-1;

    while (low <= high) {
        NSUInteger middle = low + ((high-low)/2);
//        NSUInteger middle = (unsigned long)low + ((unsigned long)high>>1);
        NSNumber *midValue = self[middle];
        if ([midValue isEqualTo:key]) {
            return middle;
        }
        if ([midValue isLessThan:key]) {
            low = middle+1;
        }
        else {
            high = middle-1;
        }
    }
//    return -(low+1);
    // Need to define what to return when key not found
    return -1;
}

- (NSArray *)moveZerosToStartUsingSwap:(NSMutableArray *)array {
    if (array.count <= 1) {
        return [NSArray arrayWithArray:array];
    }
    NSInteger zeroIndex = 0;
    for (NSInteger i=0; i<array.count; i++) {
        if ([array[i] isEqualToNumber:@0]) {
            array[i] = array[zeroIndex];
            array[zeroIndex++] = @0;
        }
    }
    return [NSArray arrayWithArray:array];
}

- (NSArray *)moveZerosToStart:(NSMutableArray *)array {
    /*
     Question:
     1. Need to preserve original non-zero order?
     2. Negative integer
     3. No zeroes
     
     Algorithm:
     1. Check the number of elements. If only one, return immediately
     2. Create a zero counter. For each 0, increase counter by one and remove the 0 in the array
     3. Very important: if a zero is removed, the for-loop count should be decrease by 1. Otherwise it'll out-of-bound and crash
     4. Create a new array with correct amount of zeroes and concatenate with original array
     5. Edge cases: 1 element, all zeros, no zeros
     */
    if (array.count <= 1) {
        return [NSArray arrayWithArray:array];
    }
    NSInteger zeroCount = 0;
    NSInteger arrayCount = array.count;
    for (NSInteger i=0; i<arrayCount; i++) {
        if ([array[i] isEqualToNumber:@0]) {
            [array removeObjectAtIndex:i];
            arrayCount--;
            zeroCount++;
        }
    }
    for (NSInteger i=0; i<zeroCount; i++) {
        [array insertObject:@0 atIndex:0];
    }
    return [NSArray arrayWithArray:array];
}

- (void)sortArrayZeros:(NSMutableArray *)array {
    // NSArray *array5 = @[@3, @0, @-1, @4, @5, @0, @2, @0];

    __block NSUInteger end = array.count;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx >= end) {
            *stop = YES;
        }
        if ([(NSNumber *)obj isEqualToNumber:@0]) {
            [array removeObjectAtIndex:idx];
            [array addObject:@0];
            end--;
        }
    }];
    NSLog(@"New array: %@", array);
}

- (NSDictionary *)executeBlock:(id (^)(id))myBlock {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:self.count];
    
    if (myBlock) {
        for (id element in self) {
            if ([element isKindOfClass:[NSNumber class]]) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    id result = myBlock(element);
                    if ([result isKindOfClass:[NSNumber class]]) {
                        dict[element] = result;
                    }
                });
            }
        }
    }
    return dict;
}

// Apple Interview - Andrew Leeper, PD Code Labs Manager, 12/18/15
// Given an input array of words that only contain letters a, p, l, e,
// count how many Apple stickers a user needs to buy.
// For example, input = ["ape", "peel", "pale"]
// sticker count = 4 since there are 4 e's that can make 4 Apple stickers.
//
// Unit test ArrayTests.m contains all test cases

- (NSUInteger)stickerCount {
    NSUInteger maxSoFar = 0;
    NSCountedSet *set = [[NSCountedSet alloc] initWithCapacity:4];
    
    // Assume objects inside the input array are all NSString
    for (NSString *word in self) {
        for (NSUInteger i=0; i<word.length; i++) {
            NSString *character = [[NSString stringWithFormat:@"%c", [word characterAtIndex:i]] lowercaseString];
            [set addObject:character];
            NSUInteger count = [set countForObject:character];
            if ([character isEqualToString:@"p"]) {
                count = (count/2)+count%2;
            }
            if (count > maxSoFar) {
                maxSoFar = count;
            }
        }
    }
    return maxSoFar;
}


@end
