//
//  Dictionary.m
//  algorithm_objc
//
//  Created by Stephen Ling on 1/14/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import "Dictionary.h"
#import "NSDictionary+Methods.h"

@implementation Dictionary

- (void)setup {
    NSDictionary *dict1 = @{@"John": @{@"age": @18}, @"Ivy": @{@"age": @28}};
    NSDictionary *dict2 = @{@"John": @{@"ssn": @1234, @"sex": @"M"}, @"Betty": @{@"sex": @"F"}};
    NSDictionary *dict3 = [self mergeDictionary:dict1 dictionary:dict2];
    NSLog(@"Merged dict: %@", dict3);
}

/*
 Problem: Write a method m which merges two hashmaps (i.e. dictionaries) and returns a new hashmap.
 
 The merge rules:
 1) All keys of mapA and mapB should appear in result
 2) If there is a key collision, the general rule is that you can pick either value
 (in other words, when both values are ints, or one is an int and the other a hashmap)
 3) If there is a key collision and both values are hashmaps,
 you need to merge again. The nesting can be n levels deep
 
 For example, given two input maps,
 
 mapA = {
 "a": 1,
 "b": {"x": 2},
 "c": {"x": {"q": 3}, "y": 9}
 }
 
 mapB = {
 "b": 6,
 "c": {"x": {"p": 9}, "z": 10},
 "d": 2
 }
 
 
 calling result = m(mapA, mapB) returns a result map like so:
 
 result = {
 "a": 1,
 "b": {"x": 2},
 "d": 2,
 "c": {"x": {"q": 3, "p": 9}, "y": 9, "z": 10}
 }
 
 */

/*
- (NSDictionary *)mergeDict:(NSDictionary *)mapA dictionary:(NSDictionary *)mapB {
    for (NSString *key in mapA) {
        if ([mapB objectForKey:key] != nil) {
            if ([mapA[key] isKindOfClass:[NSDictionary class]] && [mapB[key] isKindOfClass:[NSDictionary class]]) {
                mapB[key] = [self mergeDict:mapA[key] dictionary:mapB[key]];
            }
        }
        else {
            // Should merge the dictionary here because no need to merge dict every time.
            // If mapA is large, there will be space/memory issue.
        }
    }
    NSMutableDictionary *mergedMap = [mapA mutableCopy];
    [mergedMap addDictionay:mapB];
    return mergedMap;
}
 */

- (NSDictionary *)mergeDictionary:(NSDictionary *)dict1 dictionary:(NSDictionary *)dict2 {
    NSMutableDictionary *d1copy = [dict1 mutableCopy];
    NSMutableDictionary *d2copy = [dict2 mutableCopy];
    for (NSString *key in dict1) {
        if ([d2copy objectForKey:key]) {
            if ([d1copy[key] isKindOfClass:[NSDictionary class]] && [d2copy[key] isKindOfClass:[NSDictionary class]]) {
                d2copy[key] = [self mergeDictionary:d1copy[key] dictionary:d2copy[key]];
            }
        }
        else {
    //        [d1copy addEntriesFromDictionary:d2copy];
        }
    }
    [d1copy addEntriesFromDictionary:d2copy];
    dict1 = d1copy;
    return dict1;
}

@end
