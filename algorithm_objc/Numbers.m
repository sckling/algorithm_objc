//
//  Numbers.m
//  algorithm_objc
//
//  Created by Stephen Ling on 4/18/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import "Numbers.h"

@implementation Numbers

- (void)setup {
    // Case: number = 0, 1
    // Case: n=umber = negative
    // Case: number overflow or divided by 0
    [self isHappyNumber:5 original:5];
}

- (BOOL)isHappyNumber:(NSUInteger)number original:(NSUInteger)original {
    
    if (number == 1) {
        NSLog(@"Happy: %lu", (long int)number);
        return YES;
    }
    else {
        NSUInteger sum = 0;
        while (number > 0) {
            NSUInteger lastDigit = number%10;
            sum += lastDigit*lastDigit;
            NSLog(@"%lu, %lu", (long int)lastDigit, (long int)sum);
            number = number/10;
        }
        if (number == original) {
            NSLog(@"Unhappy: %lu", (long int)number);
            return NO;
        }
        else {
            NSLog(@"%lu", (long int)sum);
            [self isHappyNumber:sum original:original];
        }
    }
    return NO;
}

@end
