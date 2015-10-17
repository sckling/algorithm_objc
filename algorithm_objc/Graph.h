//
//  Graph.h
//  algorithm_objc
//
//  Created by Stephen Ling on 10/16/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EdgeNode;

@interface Graph : NSObject

@property (nonatomic, strong) NSMutableArray *edgeNodes;
@property (nonatomic, strong) NSMutableArray *vertexDegree;
@property (assign) NSUInteger vertices;
@property (assign) NSUInteger edges;
@property (assign, getter=isDirected) BOOL directed;

@end
