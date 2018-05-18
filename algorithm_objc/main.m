//
//  main.m
//  algorithm_objc
//
//  Created by Stephen Ling on 10/10/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Array.h"
#import "String.h"
#import "Graph.h"
#import "SocialGraph.h"
#import "Tree.h"
#import "NSArray+Methods.h"
#import "Dictionary.h"
#import "Matrix.h"
#import "Numbers.h"
#import "BinarySearch.h"
#import "Recursion.h"
#import "Interval.h"
#import "Trie.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
    
        NSLog(@"XOR: %d, %d, %d", 1^2^3^4, 1^2^2^3^4, (1^2^3^4)^(1^2^2^3^4));
        // Use nested arrays for multi-dimensional arrays
        /*
         XOR two arrays of numbers to find out the duplicate
         1,2,  3,4
         1,2,2,3,4
         XOR first and second set and XOR both set. The duplicate will be the answer.
         */
        /*
         Review:
         1. Extract numbers: leftmost->rightmost and vice versa. 23: (int)23/10=2, 23%10=3
         2. Binary search
         3. DFS and BFS on tree and graph
         4. Dynamic program and back tracking
         5. Recursively extract inner objects
         */
        
        /* fb
         Given an array of strings, remove any duplicates and return a new array containing the first occurrence of each string.
         Given a number e.g. 234, print all combinations of their dial pad letters
         Write a method to compare two binary trees.
         */
        
        /* Nest
         Sum of root to leaf nodes in a tree that equals to given input value.
         Reverse a tree
         Given an array of integers of length N from 1 to N-1, how would you detect a single duplicate in the array?
         Implement LRU cache.
         Print all permutations of a string. (x2)
         Implement a stack using an array in C
         Implement a trie data structure to hold words read from the input
         Write a code that, given a stream of data compress it as the value and its frequencies that occurs consecutively
         Example: (1,1,1,1,2,2,3,3,3,2) return (1,4) (2,2) (3,3) (2,1).
         
         Given an array with input - [1,2,3,4,5] , [1,3,4,5,7]
         Program should output [1-5],[1-1,3-5,7-7] Compress consecutive numbers
         
         Write a browser app that replace all instance of "nest" word with an arbitrary word (eg. Hello)
         Implement a trie data structure to hold words read from the input
         
         The system design question was more focused on a Nest-specific scenario.
         */
        
//        Trie *trie = [[Trie alloc] init];
//        [trie setup];
        
//        Interval *interval = [[Interval alloc] init];
//        [interval setup];
        
//        BinarySearch *binarySearch = [[BinarySearch alloc] init];
//        [binarySearch setup];
//        Dictionary *dict = [[Dictionary alloc] init];
//        [dict setup];
        
//        Matrix *matrix = [[Matrix alloc] init];
//        [matrix setup];
        
//        Numbers *numbers = [[Numbers alloc] init];
//        [numbers setup];

        Array *array = [[Array alloc] init];
        [array setup];
//        [array twoDimenionalArray];
//        [array blockExecution];

        
//        String *string = [[String alloc] init];
//        [string setup];
//        [string distanceBetweenTwoWordsSetup];
//        [string filterWordSetup];
        
//        Recursion *recursion = [[Recursion alloc] init];
//        [recursion setup];

//        BOOL stop = NO;
//        while (stop == NO) {
//            id obj = [array nextObject];
//            if (obj) {
//                NSLog(@"%@", obj);
//            }
//            else {
//                stop = YES;
//            }
//        }
//        NSLog(@"All object: %@", [array allObjects]);

//        Tree *tree = [[Tree alloc] init];
//        [tree setup];
        
//        Graph *graph = [[Graph alloc] initWithMember];
//        [graph setupSocialGraphWithLevel];
//        [graph setupSocialGraph];
        
//        SocialGraph *socialGraph = [[SocialGraph alloc] init];
//        [socialGraph printSocialGraphSetup];
//        [socialGraph getRankedCourses:@"Joe"];
        
        //Graph *graph = [[Graph alloc] initWithSize:9];
        //[graph setup];
        
        // done: lca, binary tree and binary search tree
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
        
        // Completion block execustion
//        NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        NSURLResponse *response = [NSURLResponse new];
//        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
//        NSLog(@"data: %@\nresponse: %@", data, response);
//        //NSLog(@"Data: %@, Response: %@, Error: %@", data1,  response, error);
//        
//        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//            NSLog(@"Response: %@, Data: %@, Error: %@", response, data, connectionError);
//        }];
    }
    return 0;
}
