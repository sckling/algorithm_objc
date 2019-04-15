//
//  MaxHeap.h
//  algorithm_objc
//
//  Created by Stephen Ling on 11/30/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaxHeap : NSObject

- (void)insertElement:(NSNumber *)element;
- (NSNumber *)extract;
- (NSNumber *)peek;
- (NSInteger)size;
- (instancetype)initWithArray:(NSArray *)array  NS_DESIGNATED_INITIALIZER;

@end
