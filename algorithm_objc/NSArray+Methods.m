//
//  NSArray+Methods.m
//  algorithm_objc
//
//  Created by Stephen Ling on 10/10/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import "NSArray+Methods.h"

@implementation NSArray (Methods)

- (NSUInteger)maximumSubArraySum {
    // Given an array of numbers, find the maximum sum of a sub-array
    // Example: 2,1,-3,4,1,-2,3,-5,-4
    // Max: 4+1-2+3=6
    //
    // NSArray *array = @[@2, @1, @-3, @4, @1, @-2, @3, @-5, @-4];
    // Kadane's algorithm
    // max subarray = 4, -1, 2, 1 = 6
    
    __block NSInteger maxSoFar = 0;
    __block NSInteger sum = 0;
    __weak typeof(self) weakSelf = self;
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (weakSelf) {
            //__strong typeof(weakSelf) strongSelf = weakSelf;
        }
        sum += [(NSNumber *)obj integerValue];
        if (sum > maxSoFar) {
            maxSoFar = sum;
        }
        else if (sum < 0) {
            sum = 0;
        }
    }];
    return maxSoFar;
}

- (void)findPairsOfElementsEqualToSum:(NSUInteger)sum {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (int i=0; i<self.count; i++) {
        if (dict[self[i]]) {
            NSMutableArray *values = dict[self[i]];
            NSNumber *value = [NSNumber numberWithInt:i];
            [values addObject:value];
            dict[self[i]] = values;
        }
        else {
            NSMutableArray *values = [NSMutableArray new];
            NSNumber *value = [NSNumber numberWithInt:i];
            [values addObject:value];
            dict[self[i]] = values;
        }
    }
    for (NSNumber *key in [dict allKeys]) {
        NSInteger pairValue = sum - [key integerValue];
        NSNumber *counterValue = [NSNumber numberWithInteger:pairValue];
        
        if ([counterValue compare:key] == NSOrderedAscending || NSOrderedSame) {

        }
        
        
        if (dict[counterValue]) {
            NSLog(@"Found pairs: %@, Position: %@, Counter values: %@, Position: %@", key, dict[key], counterValue, dict[counterValue]);
            [dict removeObjectForKey:key];
            [dict removeObjectForKey:counterValue];
        }
    }
}

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
