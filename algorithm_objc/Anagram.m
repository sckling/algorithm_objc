//
//  Anagram.m
//  algorithm_objc
//
//  Created by ling, stephen on 1/17/19.
//  Copyright © 2019 sling. All rights reserved.
//

#import "Anagram.h"

@interface Anagram ()
@property NSString *s1;
@property NSString *s2;
@property NSInteger r1;
@end

@implementation Anagram

- (void)setup {
//    [self anagramSubstringsSetup];
    [self minCharDeletionForAnagramSetup];
}

- (void)anagramSubstringsSetup {
    self.s1 = @"abba";
    self.r1 = 4;
    NSLog(@"Expect: %ld, %ld", self.r1, [self anagramSubstrings:self.s1]);
    
    self.s1 = @"abcd";
    self.r1 = 0;
    NSLog(@"Expect: %ld, %ld", self.r1, [self anagramSubstrings:self.s1]);
    
    self.s1 = @"ifailuhkqq";
    self.r1 = 3;
    NSLog(@"Expect: %ld, %ld", self.r1, [self anagramSubstrings:self.s1]);
    
    self.s1 = @"kkkk";
    self.r1 = 10;
    NSLog(@"Expect: %ld, %ld", self.r1, [self anagramSubstrings:self.s1]);
}

/*
 1. Find all the substrings from input string
 2. For each substring, convert it to a set/256-array/sorted string and put it in a dict or NSCountedSet
    - NSSet can only contain unique keys, so a,b,b becomes a,b, which would mess up the count for a,b anagram
    - Array and NSCountedSet with different element counts won't be treated as unique key.
    - Only sorted string can be used as unique keys.
    - If use hash table and take care of duplicate keys, runtime = O(1)
    - If use array[256] for frequency count, runtime = O(1) and space = O(1) since it's constant 256
 3. For each match, add original count + 1
 4. When done with substrings, loop all the key counts
    - Total pairs for each key = count*(count-1)/2
    - c=1, t=0 pair; c=2, t=1 pair; c=3, t=3 pair; c=4, t=6 pair
 
 Example: abba
 a[a]
 a[a], a[b]
 a[a], a[b]*2
 a[a]*2, a[b]*2
 
 a[b]
 a[b]*2
 a[b]*2, a[a]
 
 a[b],
 a[b], a[a]
 a[a]
 
 a[a]*1, a[b]*1, a[ab]*1, a[abb]*1
 Runtime = n*n*n*log(n) = n^3 log(n) if use sorted strings. Could use binary search to insert each char. Runtime = log(n)
 O(n*n) if can use set or array
 */

- (NSInteger)anagramSubstrings:(NSString *)s {
    NSInteger count = 0;
    NSInteger total = 0;
    NSCountedSet *set = [NSCountedSet new];
    for (int i=0; i<s.length; i++) {
        NSMutableArray *array = [NSMutableArray new];
        for (int j=i; j<s.length; j++) {
            // Add substring character one at a time to an array
            [array addObject:[NSString stringWithFormat:@"%c", [s characterAtIndex:j]]];
            // Return a sorted string as a key. n*log(n)
            NSString *key = [self sortCharacters:array];
            // Add count for each sorted substring key
            [set addObject:key];
        }
    }
    for (NSString *key in set.allObjects) {
        count = [set countForObject:key];
        total += count*(count-1)/2;
    }
    return total;
}

- (NSString *)sortCharacters:(NSArray *)array {
    NSString *s = [NSString new];
    NSArray *sortedStrings = [array sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *c in sortedStrings) {
        s = [s stringByAppendingString:c];
    }
    return s;
}

/*
 Given two strings a and b, that may or may not be of the same length, determine the minimum number of character deletions required to make a and b anagrams. Any characters can be deleted from either of the strings.
 
 Example: cde, abc, output = 4
 1. s1: remove d and e to get c
 2. s2: remove a and b to get c
 */

- (void)minCharDeletionForAnagramSetup {
    self.s1 = @"fsqoiaidfaukvngpsugszsnseskicpejjvytviya";
    self.s2 = @"ksmfgsxamduovigbasjchnoskolfwjhgetnmnkmcphqmpwnrrwtymjtwxget";
    self.r1 = 4;
    NSLog(@"Expect: %ld, %ld", self.r1, [self minCharDeletionForAnagram:self.s1 string:self.s2]);
    self.s1 = @"cde";
    self.s2 = @"abc";
    self.r1 = 4;
    NSLog(@"Expect: %ld, %ld", self.r1, [self minCharDeletionForAnagram:self.s1 string:self.s2]);
}

/*
 1. Find the longer string
 2. Add characters to NSCountedSet
 3. Loop characters in shorted string
 4. If char exist, reduce count by 1
 5. When complete, loop through all objects in set and adds up the count
 
 eg: cddf, fdc
 1st string c:1
            d:2
            f:1
 2nd string c:0
            d:1
            c:0
 Answer: 1
 */

- (NSInteger)minCharDeletionForAnagram:(NSString *)s1 string:(NSString *)s2 {
    return 0;
}




/*
 Solution:
 cde, abc -> c
 abb, caab -> ab
 1. put first string in hash
 2. loop second string and check each character
 3. Add matched character to another hash
 4. H2: c, n=2
 5. loop string one again and remove unmatched character
 6. Return n
 */
/*
- (int)anagrams:(NSString *)s1 string:(NSString *)s2 {
    int n=0;
    unichar c = 'c';
    NSString *cha = [NSString stringWithCharacters:&c length:1];
    NSLog(@"char: %@", cha);
    NSCountedSet *set1 = [[NSCountedSet alloc] initWithCapacity:s1.length];
    NSCountedSet *set2 = [[NSCountedSet alloc] initWithCapacity:s2.length];
    for (int i=0; i<s1.length; i++) {
        NSString *c = [NSString stringWithFormat:@"%c", [s1 characterAtIndex:i]];
        [set1 addObject:c];
    }
    for (int i=0; i<s2.length; i++) {
        NSString *c = [NSString stringWithFormat:@"%c", [s2 characterAtIndex:i]];
        // character matched in s1, added to a new hash
        if ([set1 countForObject:c] > 0) {
            [set2 addObject:c];
            [set1 removeObject:c];
        }
        else {
            n++;
        }
    }
    for (int i=0; i<s1.length; i++) {
        NSString *c = [NSString stringWithFormat:@"%c", [s1 characterAtIndex:i]];
        if ([set2 countForObject:c] > 0) {
            [set2 removeObject:c];
        }
        else {
            n++;
        }
    }
    return n;
}
 */

/*
 You are given a list, containg english language words. Please design a function that takes a word and returns all possible anagrams.
 An anagram is defined as a rearrangement of the given word that is a valid english word.
 
 eye => eye
 on => no, on
 ton => not, ton,
 saint => stain, saint
 emit => item, mite, time, emit
 */

@end
