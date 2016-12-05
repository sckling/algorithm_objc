//
//  Heap.h
//  algorithm_objc
//
//  Created by Stephen Ling on 11/29/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MinHeap : NSObject

- (void)insertElement:(NSNumber *)element;
- (NSNumber *)poll;
- (NSNumber *)peek;
- (NSInteger)size;

@end
