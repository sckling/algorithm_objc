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
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
        if (dict[counterValue]) {
            NSLog(@"Found pairs: %@, Position: %@, Counter values: %@, Position: %@", key, dict[key], counterValue, dict[counterValue]);
            [dict removeObjectForKey:key];
            [dict removeObjectForKey:counterValue];
        }
    }
}

- (NSUInteger)binarySearch:(NSUInteger)start end:(NSUInteger)end number:(NSUInteger)number {
    NSUInteger middle = (start+end) / 2;
    NSUInteger currentNumber = [self[middle] integerValue];
    
    if (start < end) {
        if (currentNumber == number) {
            return middle;
        }
        else if (currentNumber > number) {
            return [self binarySearch:start end:middle-1 number:number];
        }
        else if (currentNumber < number) {
            return [self binarySearch:middle+1 end:end number:number];
        }
    }
    return start;
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
    return start;
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

@end