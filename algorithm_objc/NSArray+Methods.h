//
//  NSArray+Methods.h
//  algorithm_objc
//
//  Created by Stephen Ling on 10/10/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Methods)

- (NSUInteger)maximumSubArraySum;
- (void)findPairsOfElementsEqualToSum:(NSUInteger)sum;
- (NSUInteger)binarySearch:(NSUInteger)start end:(NSUInteger)end number:(NSUInteger)number;
- (NSUInteger)binarySearch:(NSUInteger)start end:(NSUInteger)end character:(NSString *)character;
- (NSDictionary *)executeBlock:(id (^)(id object))myBlock;

@end
