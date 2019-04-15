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
#import "Anagram.h"
#import "DP.h"
#import "Set.h"
#import "GameOfLife.h"
#import "Sudoku.h"

/*
 Shortcuts:
 NSMArray, NSMDict, NSMSet
 s[i] => [s characterAtIndex:1]
 substring?? [s substring:NSMakeRange(1,1)];
 substringToIndex, substringFromIndex
 Assume int/double can be manipulate as objects
 NSCountedSet. Better to use dict and assume it can count directly
 set[str].count
 arr[i] = 3
 dict[i] += 3
 
 Sort values of dict, sort strings
 */

/*
 You are given a list, containg english language words. Please design a function that takes a word and returns all possible anagrams.
 An anagram is defined as a rearrangement of the given word that is a valid english word.
 
 eye => eye
 on => no, on
 ton => not, ton,
 saint => stain, saint
 emit => item, mite, time, emit
 
 1. Given a static list of valid english words in list
 2. lenght of word = m, O(m) traverse all letters and convert it into a set
 3. length of list = n, O(n*m)
 4. O(m+m*n) = O(m*n)
 
 i,t,e,m => set
 m,i,t,e => set
 
 key: set(i,t,e,m), value: item, mite
 */
@interface Node : NSObject
@property(strong) Node *next;
@property int val;
@end

@implementation Node
@end

//MyQueue class
@interface MyQueue : NSObject
@property(strong) Node *head;
@property(strong) Node *tail;
- (void)push_back:(int)val;
- (int)pop_front;
- (void)display;
@end

@implementation MyQueue

- (void)push_back:(int)val {
    Node *n = [Node new];
    n.val = val;
    // If no head pointer, it's an emoty q init new head and tail
    if (!self.head) {
        self.head = n;
        self.tail = self.head;
    }
    // q has existing nodes, add a new one to the tail
    else {
        self.tail.next = n;
        self.tail = n;
    }
}

- (int)pop_front {
    if (!self.head) {
        return -1;
    }
    int ret = self.head.val;
    Node *n = self.head;
    self.head = self.head.next;
    // Set previous head to nil to prevent memory leak
    n = nil;
    // If head is nil, q is empty and set tail to nil to prevent memory leak
    if (!self.head) {
        self.tail = nil;
    }
    return ret;
}

- (void)display {
    printf("Display all elements in q: ");
    Node *n = self.head;
    while (n) {
        printf("%d ", n.val);
        n = n.next;
    }
    printf("\n");
}

@end

NSSet *convertStringToSet(NSString *s) {
    NSMutableSet *set = [NSMutableSet new];
    for (int i=0; i<s.length; i++) {
        // [set addObject:[NSString stringWithFormat:@"%c", [s characterAtIndex:i]]];
        // Convert ASCII to NSNumber instead of string
        [set addObject:@([s characterAtIndex:i])];
    }
    return [set copy];
}

NSArray *anagramCheck(NSArray *words, NSString *word) {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSSet *set = [NSSet new];
    for (NSString *s in words) {
        // Alternatively, can use an array with 26 elements to represent counts of each character
        // Can also sort each string by characters but run time is n*log(n)
        set = convertStringToSet(s);
        if (!dict[set]) {
            dict[set] = [NSMutableArray new];
        }
        [dict[set] addObject:s];
    }
    return [dict[convertStringToSet(word)] copy];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        MyQueue *q = [MyQueue new];
//        [q push_back:1];
//        [q push_back:2];
//        [q push_back:3];
//        [q push_back:4];
//        [q display];                     // Print 1 2 3 4
//        assert( 1 == [q pop_front] );    // Pop 1
//        assert( 2 == [q pop_front] );    // Pop 2
//        assert( 3 == [q pop_front] );    // Pop 3
//        assert( 4 == [q pop_front] );    // Pop 4
//        assert(-1 == [q pop_front] );    // Nothing to pop, return -1
        
//        NSArray *a = @[@"on", @"no", @"bye"];
//        NSLog(@"anagram 'on': %@", anagramCheck(a, @"on"));
//        a = @[@"ton", @"item", @"mite", @"bye"];
//        NSLog(@"anagram 'item': %@", anagramCheck(a, @"item"));
//        a = @[@"ton", @"item", @"mite", @"bye"];
//        NSLog(@"anagram no match: %@", anagramCheck(a, @"something"));
        
        // Use nested arrays for multi-dimensional arrays
        // Design and code a task scheduler that can take unsynchronized or synchronized tasks.
        // Google iOS: Design an image browsing app
        // Big O of n*(n-1)*(n-2)*(n-3)... = n*(n+1)/2
		
//         NSLog(@"XOR: %d, %d, %d", 4^2^3^4^3, 1^2^2^3^4, (1^2^3^4)^(1^2^2^3^4));
//		NSLog(@"XOR: %d %d", 4^2^4^4^3^3^3, 5^(4^2^4^4^3^3^3));
		 /*
         XOR two arrays of numbers to find out the duplicate
         1,2,  3,4
         1,2,2,3,4
         XOR first and second set and XOR both set. The duplicate will be the answer.
         XOR is commutative (can change order of numbers) a*b=b*a
         and associative (doesn't matter how the numbers are grouped by parentheses): (a+b)+c=a+(b+c)
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
		
//		Sudoku *s = [Sudoku new];
//		[s setup];
//		[s printBoard];
//		printf("Found solution? %s\n", [s solveSudoku] ? "Yes" : "No");
//		[s printBoard];
		
//        DP *dp = [[DP alloc] init];
//        [dp setup];
        
//        Anagram *anagram = [[Anagram alloc] init];
//        [anagram setup];
        
//        Trie *trie = [[Trie alloc] init];
//        [trie setup];
        
//        Interval *interval = [[Interval alloc] init];
//        [interval setup];
        
//        BinarySearch *binarySearch = [[BinarySearch alloc] init];
//        [binarySearch setup];

//        Dictionary *dict = [[Dictionary alloc] init];
//        [dict setup];
		
        Matrix *matrix = [[Matrix alloc] init];
        [matrix setup];
		
//        Numbers *numbers = [[Numbers alloc] init];
//        [numbers setup];

//        Array *array = [[Array alloc] init];
//        [array setup];
        
//        String *string = [[String alloc] init];
//        [string setup];
		
//        Recursion *recursion = [[Recursion alloc] init];
//        [recursion setup];
		
//		Set *set = [Set new];
//		[set setup];
		
//		GameOfLife *game = [[GameOfLife alloc] initWithSize:5];
//		[game start:2];

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
        
//        Graph *graph = [[Graph alloc] initWithSize:9];
//        [graph setup];
		
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
