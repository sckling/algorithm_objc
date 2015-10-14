//
//  main.m
//  algorithm_objc
//
//  Created by Stephen Ling on 10/10/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Array.h"
#import "Tree.h"
#import "NSArray+Methods.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Array *array = [[Array alloc] init];
        [array setup];
        
        Tree *binarySearchTree = [[Tree alloc] init];
        [binarySearchTree setup];
        
        //
        // Extract most and least significant digit of a number: 1234
        // Implement lmu - least memory use
        // Fibonacci number - recursive, iterative, dynamic programming
        // string permutation
        // reverse linked list
        // circular linked list
        // XOR X^X=0, 0^X=X, X^Y^X = Y, X^X^X=0
        // X&(X-1) clear least significant bit
        // 5&(5-1) = 101 & 100 = 100
        // X&!(X-1) extract lowest set of bit
        // 5&!(5-1) = 101 & 011 = 001
    }
    return 0;
}
