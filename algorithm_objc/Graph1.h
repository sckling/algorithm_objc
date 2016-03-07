//
//  Graph1.h
//  algorithm_objc
//
//  Created by Stephen Ling on 3/3/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Graph1 : NSObject

- (instancetype)initWithSize:(NSUInteger)size;
- (void)insertEdge:(NSUInteger)start end:(NSUInteger)end;
- (void)breadthFirstSearch:(NSUInteger)start;
- (void)depthFirstSearch:(NSUInteger)start;

@end
