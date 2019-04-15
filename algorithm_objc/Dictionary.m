//
//  Dictionary.m
//  algorithm_objc
//
//  Created by Stephen Ling on 1/14/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import "Dictionary.h"
#import "NSDictionary+Methods.h"
#import "NTree.h"

@implementation Dictionary

- (void)setup {
//    [self mergeDictSetup];
//    [self printTopIPsSetup];
    [self longestFilePathSetup];
}

- (void)longestFilePathSetup {
    /*
     dir
        subdir1
        subdir2
            file.ext
     longest path 20: dir/subdir2/file.ext
     */
    NSString *s = @"dir\n\tsubdir1\n\tsubdir2\n\t\tfile.ext";
    NSLog(@"Longest path 20: received: %d", [self longestFilePath:s]);
    
    /*
     dir
        subdir1
            file1.ext
            subsubdir1
        subdir2
            subsubdir2
                file2.ext
     longest path 32: dir/subdir2/subsubdir2/file2.ext
     */
    s = @"dir\n\tsubdir1\n\t\tfile1.ext\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.ext";
    NSLog(@"Longest path 32: received: %d", [self longestFilePath:s]);
}

- (int)longestFilePath:(NSString *)s {
    NTree *root = [self convertStringToTree:s];
    return [self printPaths:root path:[NSString new]];
}

- (int)printPaths:(NTree *)root path:(NSString *)path {
    if (!root) {
        return 0;
    }
    path = [path stringByAppendingString:root.value];
	// No more child => end of file path
    if (root.nodes.count == 0) {
        printf("%s\n", [path UTF8String]);
        // If end of path is a dir, don't count the length
        if ([root.value componentsSeparatedByString:@"."].count == 1) {
            return 0;
        }
        // If it's a file, return length of the path
        return (int)path.length;
    }
    path = [path stringByAppendingString:@"\\"];
    int max = 0;
	// Traverse paths for each child from current node
    for (NTree *n in root.nodes) {
        max = MAX(max, [self printPaths:n path:path]);
    }
    return max;
}

- (NTree *)convertStringToTree:(NSString *)s {
    /*
     dir\n\tsubdir1\n\t\tfile1.ext\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.ext
     
     tokenize \n
     dir
     \tS1
     \t\tF1.ext
     \t\tSS1
     \tS2
     \t\tSS2
     \t\t\tF2.ext
     
     for each item
     store it in path[no. of \t] -> dir, s1, f1
     path[t-1].child add:item, can use dictionary
     */
    NSArray<NSString *> *items = [s componentsSeparatedByString:@"\n"];
	NSMutableDictionary<NSNumber *, NTree *> *path = [NSMutableDictionary new];
	// Add root directory
    path[@0].value = items[0];
    for (NSString *item in items) {
        int t = [self countDepth:item];
//        NSLog(@"d:%d %@", t, item);
		// Remove all \t and add to the path for future use if needed to add child to it
        path[@(t)] = [[NTree alloc] initWithValue:[item stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
		// Except root node, add current node as child from parent node. Hence path[t-1]
		// Since we already added root node, t should never be 0. Hence no need to check for t>0
        //if (t > 0) {
            [path[@(t-1)].nodes addObject:path[@(t)]];
        //}
    }
	// Path length should be the longest file path
//	NSLog(@"%@", path);
    return path[@0];
}

- (int)countDepth:(NSString *)item {
    int count = 0;
    for (int i=0; i<item.length; i++) {
        if ([item characterAtIndex:i] == '\t') {
            count++;
        }
    }
    return count;
}


- (void)printTopIPsSetup {
    NSArray *a = @[@1,@1,@4,@4,@3,@2,@1,@9,@9,@9,@9,@7,@1,@2,@4,@0,@0,@1];
    [self printTopIPs:a top:3];
}

- (void)printTopIPs:(NSArray *)ip top:(NSInteger)top {
    NSCountedSet *set = [NSCountedSet new];
    for (NSNumber *n in ip) {
        [set addObject:n];
    }
    // Sort by object counts using comparator
    NSArray *sortedValues = [set.allObjects sortedArrayUsingComparator:^(id obj1, id obj2) {
        return ([set countForObject:obj1] > [set countForObject:obj2]) ? NSOrderedAscending : NSOrderedDescending;
    }];
    NSLog(@"Sorted by count 1: %@", sortedValues);
    NSLog(@"Top %ld: %@",  top, [sortedValues subarrayWithRange:NSMakeRange(0, top)]);
    
    // Sort by object counts using NSComparisonResult
    NSArray *array = [set.allObjects sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        // NSOrderedAscending >; NSOrderedDescending <
        return ([set countForObject:obj1] < [set countForObject:obj2]);
    }];
//    NSLog(@"Sorted by count 2: %@", array);
//    NSLog(@"Sorted by count 3: %@", array.reverseObjectEnumerator.allObjects);  // Reverse array order
    NSMutableArray *dictArray = [NSMutableArray array];
    [set enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        [dictArray addObject:@{@"object": obj,
                               @"count": @([set countForObject:obj])}];
    }];
    NSLog(@"Sorted by count: %@", [dictArray sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"count" ascending:NO]]]);
}

/*
 Problem: Write a method m which merges two hashmaps (i.e. dictionaries) and returns a new hashmap.
 
 The merge rules:
 1) All keys of mapA and mapB should appear in result
 2) If there is a key collision, the general rule is that you can pick either value
 (in other words, when both values are ints, or one is an int and the other a hashmap)
 3) If there is a key collision and both values are hashmaps, you need to merge again. The nesting can be n levels deep
 
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

- (void)mergeDictSetup {
    NSDictionary *dict1 = @{@"John": @{@"age": @18}, @"Ivy": @{@"age": @28}};
    NSDictionary *dict2 = @{@"John": @{@"ssn": @1234, @"sex": @"M"}, @"Betty": @{@"sex": @"F"}};
    NSDictionary *dict3 = [self mergeDictionary:dict1 dictionary:dict2];
    NSLog(@"Merged dict: %@", dict3);
}

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
