//
//  Graph.h
//  algorithm_objc
//
//  Created by Stephen Ling on 10/16/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

#define maxVertices 100

@interface Graph : NSObject

@property (nonatomic, strong) NSMutableArray *edgeNodes;
@property (nonatomic, strong) NSMutableArray *vertexDegree;
@property (nonatomic, strong) NSMutableArray *discovered;
@property (nonatomic, strong) NSMutableArray *processed;
@property (nonatomic, strong) NSMutableArray *parent;
@property (nonatomic, strong) NSMutableArray *entryTime;
@property (assign) NSUInteger vertices;
@property (assign) NSUInteger edges;
@property (assign, getter=isDirected) BOOL directed;

- (id)initWithSize:(NSUInteger)size;
- (id)initWithMember;
- (void)setup;
- (void)setupSocialGraph;
- (void)setupSocialGraphWithLevel;
- (void)printGraph;
- (void)insertEdgeNode:(NSUInteger)source dest:(NSUInteger)dest weight:(NSInteger)weight directed:(BOOL)directed;
- (void)breathFirstSearch:(NSUInteger)startVertex;
- (void)findPath:(NSUInteger)start end:(NSUInteger)end;

@end
