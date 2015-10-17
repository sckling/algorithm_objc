//
//  Graph.m
//  algorithm_objc
//
//  Created by Stephen Ling on 10/16/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import "Graph.h"

@implementation Graph

- (id)init {
    self = [super init];
    if (self != nil) {
        _vertices = 0;
        _edges = 0;
        _directed = NO;
        _edgeNodes = [NSMutableArray new];
    }
    return self;
}

@end
