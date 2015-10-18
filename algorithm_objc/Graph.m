//
//  Graph.m
//  algorithm_objc
//
//  Created by Stephen Ling on 10/16/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import "Graph.h"
#import "EdgeNode.h"

@implementation Graph

- (id)init {
    return [self initWithSize:maxVertices];
}

- (id)initWithSize:(NSUInteger)size {
    self = [super init];
    if (self != nil) {
        _vertices = 0;
        _edges = 0;
        _directed = NO;
        _edgeNodes = [NSMutableArray arrayWithCapacity:size];
        _vertexDegree = [NSMutableArray arrayWithCapacity:size];
        _discovered = [NSMutableArray arrayWithCapacity:size];
        _processed = [NSMutableArray arrayWithCapacity:size];
        _parent = [NSMutableArray arrayWithCapacity:size];
        for (int i=0; i<size; i++) {
            _edgeNodes[i] = [[EdgeNode alloc] init];
            _vertexDegree[i] = @0;
            _discovered[i] = @NO;
            _processed[i] = @NO;
            _parent[i] = @-1;
        }
    }
    return self;
}

- (void)findPath:(NSUInteger)start end:(NSUInteger)end {
    if ((start == end)||(end == -1)) {
        NSLog(@"Start: %ld", start);
    }
    else {
        [self findPath:start end:[self.parent[end] integerValue]];
        NSLog(@"%ld", end);
    }
}

- (void)breathFirstSearch:(NSUInteger)startVertex {
    NSLog(@"BFS graph starting from vertex: %ld", startVertex);
    NSMutableArray *queue = [NSMutableArray arrayWithCapacity:self.edges];
    self.discovered[startVertex] = @YES;
    [queue addObject:[NSNumber numberWithInteger:startVertex]];
    EdgeNode *node = nil;
    while (queue.count > 0) {
        // dequeue vertex number.
        NSUInteger source = [[queue objectAtIndex:0] integerValue];
        [queue removeObjectAtIndex:0];
        
        // Process vertex
        NSLog(@"Process vertex %ld", source);
        self.processed[source] = @YES;
        
        // Loop the entire adjacency list for the vertex
        node = self.edgeNodes[source];
        while (node.next) {
            
            // Print every edge in the graph once
            if ([self.processed[node.dest] isEqualToNumber:@NO] || self.isDirected == YES) {
                [self processEdge:source destination:node.dest];
            }
            
            // If vertex has not been discovered, add it to the queue and process it later
            if ([self.discovered[node.dest] isEqualToNumber:@NO]) {
                //NSLog(@"Discovered: %ld", node.dest);
                self.discovered[node.dest] = @YES;
                [queue addObject:[NSNumber numberWithInteger:node.dest]];
                self.parent[node.dest] = [NSNumber numberWithInteger:source];
            }
            node = node.next;
        }
        // processVertexLate(vertex)
    }
}

- (void)processEdge:(NSUInteger)source destination:(NSUInteger)destination {
    NSLog(@"Process edge: %ld, %ld", source, destination);
}

- (void)printGraph {
    [self.edgeNodes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"Vertex: %ld, Degree: %@, %@", idx, self.vertexDegree[idx], self.processed[idx]);
        if ([self.processed[idx] isEqualToNumber:@NO]) {
            NSLog(@"something");
        }
        EdgeNode *headNode = (EdgeNode *)obj;
        // Since end pointer is always an empty alloc'ed pointer, need to check next instead
        while (headNode.next) {
            NSLog(@"%ld ", headNode.dest);
            headNode = headNode.next;
        }
    }];
    self.vertices = self.edgeNodes.count;
    NSLog(@"Total Vertices: %ld, Total Edges: %ld", self.vertices, self.edges);
}

- (void)insertEdgeNode:(NSUInteger)source dest:(NSUInteger)dest directed:(BOOL)directed {
    EdgeNode *node = [[EdgeNode alloc] init];
    node.dest = dest;
    node.weight = 0;
    node.next = self.edgeNodes[source];
    self.edgeNodes[source] = node;
    NSUInteger newValue = [(NSNumber *)self.vertexDegree[source] integerValue] + 1;
    self.vertexDegree[source] = [NSNumber numberWithInteger:newValue];
    
    if (directed == NO) {
        [self insertEdgeNode:dest dest:source directed:YES];
    }
    else {
        self.edges++;
    }
    
    // 1--2\
    // | /| \ 3
    // |/ | /
    // 5--4/
    //
    // (2)-> [1]
    // insert (1,2)
    // create edgeNode(2)
    // edgeNode(2)->next = edges[1]?
    // [1] head = NULL
    // (2)->next pointers to [1] head pointer
    // shift the head pointer to (2)->next
    // Make [1] points to (2)
    // edges[1] = head of an edgeNode
    // In this case, edges[1] = edgeNode(2)
    //
}

@end
