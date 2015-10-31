//
//  main.m
//  algorithm_objc
//
//  Created by Stephen Ling on 10/10/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Array.h"
#import "Graph.h"
#import "Tree.h"
#import "NSArray+Methods.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Array *array = [[Array alloc] init];
//        [array executeBlock:^NSString *(int a, float b) {
//            float c = a + b;
//            return [NSString stringWithFormat:@"%lf", c];
//        }];
        [array setup];

        for (int i=0; i<10; i++) {
            NSLog(@"Next: %@", [array nextObject]);
        }
        
//        Tree *binarySearchTree = [[Tree alloc] init];
//        [binarySearchTree setup];
        
        //Graph *graph = [[Graph alloc] initWithSize:9];
        //[graph setup];
        
        // done: lca, binary tree ad binary search tree
        // is BST balanced?
        // done: find all the paths of a binary tree
        // done: find the largest value that is smaller than n in a BST
        // done: reverse linked list

        // Determine if a number is a happy number
        // Extract most and least significant digit of a number: 1234
        // Implement LRU - Least Recently Used Memory
        // Fibonacci number - recursive, iterative, dynamic programming
        // string permutation

        // circular linked list
        // XOR X^X=0, 0^X=X, X^Y^X = Y, X^X^X=0
        // X&(X-1) clear least significant bit
        // 5&(5-1) = 101 & 100 = 100
        // X&!(X-1) extract lowest set of bit
        // 5&!(5-1) = 101 & 011 = 001
    }
    return 0;
}
