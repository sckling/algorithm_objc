//
//  NSArray+Methods.h
//  algorithm_objc
//
//  Created by Stephen Ling on 10/10/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Methods)

// find if there's a consecutive range of subarray in an array equal to a given number n.

- (NSUInteger)maximumSubArraySum;

- (void)findPairsOfElementsEqualToSum:(NSUInteger)sum;

- (NSInteger)binarySearch:(NSUInteger)start end:(NSUInteger)end number:(NSUInteger)number;

- (NSUInteger)binarySearch:(NSUInteger)start end:(NSUInteger)end character:(NSString *)character;

- (NSInteger)binarySearchIterative:(id)key;

- (NSDictionary *)executeBlock:(id (^)(id object))myBlock;

- (void)sortArrayZeros:(NSMutableArray *)array;

- (NSUInteger)stickerCount;

@end
