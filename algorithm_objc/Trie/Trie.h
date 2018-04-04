//
//  Trie.h
//  algorithm_objc
//
//  Created by ling, stephen on 3/24/18.
//  Copyright © 2018 sling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrieNode.h"

@interface Trie : NSObject

- (void)setup;
- (void)insert:(NSString *)word;
- (BOOL)search:(NSString *)word;
//- (BOOL)startWith:(NSString *)prefix;

@end
