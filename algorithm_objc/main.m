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
        //Array *array = [[Array alloc] init];
        //[array setup];
        
        //Tree *binarySearchTree = [[Tree alloc] init];
        //[binarySearchTree setup];
        
//        Graph *graph = [[Graph alloc] initWithSize:5];
//        [graph insertEdgeNode:0 dest:1 directed:NO];
//        [graph insertEdgeNode:0 dest:4 directed:NO];
//        [graph insertEdgeNode:1 dest:2 directed:NO];
//        [graph insertEdgeNode:1 dest:3 directed:NO];
//        [graph insertEdgeNode:1 dest:4 directed:NO];
//        [graph insertEdgeNode:2 dest:3 directed:NO];
//        [graph insertEdgeNode:3 dest:4 directed:NO];
//        [graph printGraph];
        
        Graph *graph = [[Graph alloc] initWithSize:4];
        [graph insertEdgeNode:0 dest:1 directed:YES];
        [graph insertEdgeNode:0 dest:2 directed:YES];
        [graph insertEdgeNode:1 dest:2 directed:YES];
        [graph insertEdgeNode:2 dest:0 directed:YES];
        [graph insertEdgeNode:2 dest:3 directed:YES];
        [graph insertEdgeNode:3 dest:3 directed:YES];
        graph.directed = YES;
        [graph printGraph];
        [graph breathFirstSearch:2];
        [graph findPath:1 end:3];
        [graph findPath:2 end:1];
        
        
        // lca, binary tree ad binary search tree
        // is BST balanced?
        // find all the paths of a binary tree
        // find the largest value that is smaller than n in a BST
        // Print all the paths in a BST
        // Determine if a number is a happy number
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
