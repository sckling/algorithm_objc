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
    [self printAllWords:self.root word:[NSString new]];
    NSLog(@"Found? %d", [self search:@"hello"]);
    NSLog(@"Found? %d", [self search:@"holla"]);
    NSLog(@"Found? %d", [self search:@"holle"]);
    NSLog(@"Found? %d", [self search:@"hel"]);
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
