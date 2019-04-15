//
//  Numbers.h
//  algorithm_objc
//
//  Created by Stephen Ling on 4/18/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Numbers : NSObject

- (void)setup;


/*
 mod = remainder of m / n
 mod(12, 10) = 2
 mod(123, 10) = 3
 
 Extract right to left, 123 -> 3,2,1
 while (number != 0) {
    int digit = fmod(number, 10)   // extract the last digit as a remainder
    number = number / 10;          // reduce the number to the next least significant digit
 }
 
 Extract left to right, 123 -> 1,2,3
 while (number != 0) {
    int digit = fmod(number, 10)   // extract the last digit as a remainder
    number = number / 10;          // reduce the number to the next least significant digit
 }
 
 123 % 10 = 3
 223 % 100 = 23
 10^6 = 1,000,000
 567 - 567 % 100 = 567 - 67 = 500 => 500 / 100 = 5
 567 = 5 * 100 = 67
 
 1+2+3+.....n = n*(n+1)/2
 
 */

@end
