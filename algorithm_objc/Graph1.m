//
//  Graph1.m
//  algorithm_objc
//
//  Created by Stephen Ling on 3/3/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import "Graph1.h"

@interface Graph1()
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, copy) NSMutableArray *list;
@end

@implementation Graph1

- (instancetype)initWithSize:(NSUInteger)size {
    self = [super init];
    if (self != nil) {
        _list = [NSMutableArray arrayWithCapacity:size];
        for (NSUInteger idx=0; idx<size; idx++) {
            _list[idx] = [NSMutableArray new];
        }
    }
    return self;
}

- (void)insertEdge:(NSUInteger)start end:(NSUInteger)end {
    NSMutableArray *connections = self.list[start];
    [connections addObject:@(end)];
    self.list[start] = connections;
}

- (void)breadthFirstSearch:(Vertex *)vertex visited:(NSArray *)visited {
    
}

- (void)depthFirstSearch:(Vertex *)vertex visited:(NSArray *)visited {
    
    
}


@end
