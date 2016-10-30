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
//    [self isHappyNumber:5 original:5];
    int n=10;
    printf("Fibonacci of %d = %d\n", n, [self fibonacci:n]);
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

- (int)fibonacci:(int)n {
    if (n==0) {
        return 0;
    }
    if (n==1) {
        return 1;
    }
    int *fib = malloc(sizeof(int)*(n+1));
    for (int i=0; i<n; i++) {
        fib[i] = -1;
    }
    fib[0] = 0;
    fib[1] = 1;
//    [self fibArray:n array:fib];
    [self fibArrayIterative:n array:fib];
    for (int i=0; i<=n; i++) {
        printf("%d ", fib[i]);
    }
    printf("\n");
    return fib[n];
}

- (int)fibArray:(int)n array:(int *)fib {
    if (fib[n-2] == -1) {
        [self fibArray:n-2 array:fib];
    }
    if (fib[n-1] == -1) {
        [self fibArray:n-1 array:fib];
    }
    fib[n] = fib[n-2]+fib[n-1];
    return fib[n];
}

- (int)fibArrayIterative:(int)n array:(int *)fib {
    for (int i=2; i<=n; i++) {
        fib[i] = fib[i-1] + fib[i-2];
        printf("f%d=%d\n", i, fib[i]);
        if (fib[i-2] == -1) {
            fib[i-2] = fib[i-1];
        }
        if (fib[i-1] == -1) {
            fib[i-1] = fib[i];
        }
    }
    return fib[n];
}

@end
