//
//  TrieNode.h
//  algorithm_objc
//
//  Created by ling, stephen on 3/24/18.
//  Copyright © 2018 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrieNode : NSObject

@property (nonatomic, strong) NSMutableDictionary<NSString *, TrieNode *> *children;
@property (nonatomic) BOOL isEndOfWord;

@end
