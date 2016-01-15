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
#import "SocialGraph.h"
#import "Tree.h"
#import "NSArray+Methods.h"
#import "Dictionary.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Dictionary *dict = [[Dictionary alloc] init];
        [dict setup];

//        Array *array = [[Array alloc] init];
//        [array setup];
//        [array twoDimenionalArray];
//        [array blockExecution];

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
        
//        Tree *binarySearchTree = [[Tree alloc] init];
//        [binarySearchTree setup];
        
//        Graph *graph = [[Graph alloc] initWithMember];
//        [graph setupSocialGraph];
        
//        SocialGraph *socialGraph = [[SocialGraph alloc] init];
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
