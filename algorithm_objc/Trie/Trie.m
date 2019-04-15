//
//  Trie.m
//  algorithm_objc
//
//  Created by ling, stephen on 3/24/18.
//  Copyright © 2018 sling. All rights reserved.
//

#import "Trie.h"

@interface Trie ()
@property(nonatomic, strong) TrieNode *root;
@end

@implementation Trie

- (void)setup {
    self.root = [[TrieNode alloc] init];
    [self insert:@"hello"];
    [self insert:@"holla"];
    [self insert:@"help"];
//    [self printAllWords:self.root word:[NSString new]];
//    NSLog(@"Found? %d", [self search:@"hello"]);
//    NSLog(@"Found? %d", [self search:@"holla"]);
//    NSLog(@"Found? %d", [self search:@"holle"]);
//    NSLog(@"Found? %d", [self search:@"hel"]);
    
    [self searchSuggestions:@"h"];
    [self searchSuggestions:@"hell"];
}

/*
  Naive solution is to compare each word in dictionary and see if it matches the prefix
  Runtime O(n), however, you need to compare every word even though only there's a single match.
  Trie is the best data structure than dictionary since we only evaluate words that match the preifx.
  While it's still O(n) if all words match prefix, average runtime is a lot faster.
 */
- (void)searchSuggestions:(NSString *)prefix {
    NSString *word = [NSString new];
    // Traverse each letter of the keyword
    TrieNode *n = self.root;
    for (int i=0; i<prefix.length; i++) {
        // Search for matched match in current node.children
        NSString *letter = [NSString stringWithFormat:@"%c", [prefix characterAtIndex:i]];
        if (n.children[letter]) {
            // Store each matched letter into a string
            word = [word stringByAppendingString:letter];
            n = n.children[letter];
        }
    }
    // Found the last node that contains all matched letters. Need to print all words of its children
    [self printWords:n word:word];
}

- (void)printWords:(TrieNode *)node word:(NSString *)word {
    if (!node) {
        return;
    }
    if (node.isEndOfWord) {
        printf("%s\n", [word UTF8String]);
    }
    NSArray *letters = node.children.allKeys;
    for (NSString *letter in letters) {
        word = [word stringByAppendingString:letter];
        [self printWords:node.children[letter] word:word];
        word = [word substringToIndex:word.length-1];
    }
}

- (void)insert:(NSString *)word {
    TrieNode *root = self.root;
    for (NSInteger i=0; i<word.length; i++) {
        NSString *character = [word substringWithRange:NSMakeRange(i, 1)];
        if (root.children[character] == nil) {
            root.children[character] = [[TrieNode alloc] init];
        }
        root = root.children[character];
    }
    root.isEndOfWord = YES;
}

- (BOOL)search:(NSString *)word {
    TrieNode *root = self.root;
    for (NSInteger i=0; i<word.length; i++) {
        NSString *character = [word substringWithRange:NSMakeRange(i, 1)];
        if (!root.children[character]) {
            return NO;
        }
        root = root.children[character];
    }
    return (root && root.isEndOfWord);
}

- (void)printAllWords:(TrieNode *)node word:(NSString *)word {
    if (!node) {
        return;
    }
    if (node.isEndOfWord) {
        NSLog(@"Word: %@", word);
        return;
    }
    // This is backtracking: add each child character of the current character and perform recursive call
    // After recursive call, remove the last character added before the call and addd the next character
    NSArray *letters = [node.children allKeys];
    for (NSString *letter in letters) {
        word = [word stringByAppendingString:letter];
        [self printAllWords:node.children[letter] word:word];
        word = [word substringToIndex:word.length-1];
    }
}

//- (BOOL)startWith:(NSString *)prefix {
//
//}

@end
