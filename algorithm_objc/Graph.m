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
        _entryTime = [NSMutableArray arrayWithCapacity:size];
        _vertices = size;
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

- (void)setup {
//    Graph *graph = [[Graph alloc] initWithSize:5];
//    [self insertEdgeNode:0 dest:1 directed:NO];
//    [self insertEdgeNode:0 dest:4 directed:NO];
//    [self insertEdgeNode:1 dest:2 directed:NO];
//    [self insertEdgeNode:1 dest:3 directed:NO];
//    [self insertEdgeNode:1 dest:4 directed:NO];
//    [self insertEdgeNode:2 dest:3 directed:NO];
//    [self insertEdgeNode:3 dest:4 directed:NO];
//    [self printGraph];
    
//    [self insertEdgeNode:0 dest:1 weight:0 directed:YES];
//    [self insertEdgeNode:0 dest:2 weight:0 directed:YES];
//    [self insertEdgeNode:1 dest:2 weight:0 directed:YES];
//    [self insertEdgeNode:2 dest:0 weight:0 directed:YES];
//    [self insertEdgeNode:2 dest:3 weight:0 directed:YES];
//    [self insertEdgeNode:3 dest:3 weight:0 directed:YES];
//    [self printGraph];
    
    // Dijstra shortest path testing
    [self insertEdgeNode:0 dest:1 weight:4 directed:NO];
    [self insertEdgeNode:0 dest:7 weight:8 directed:NO];
    [self insertEdgeNode:1 dest:2 weight:8 directed:NO];
    [self insertEdgeNode:1 dest:7 weight:11 directed:NO];
    [self insertEdgeNode:2 dest:3 weight:7 directed:NO];
    [self insertEdgeNode:2 dest:8 weight:2 directed:NO];
    [self insertEdgeNode:2 dest:5 weight:4 directed:NO];
    [self insertEdgeNode:3 dest:4 weight:9 directed:NO];
    [self insertEdgeNode:3 dest:5 weight:14 directed:NO];
    [self insertEdgeNode:4 dest:5 weight:10 directed:NO];
    [self insertEdgeNode:5 dest:6 weight:2 directed:NO];
    [self insertEdgeNode:6 dest:7 weight:1 directed:NO];
    [self insertEdgeNode:6 dest:8 weight:6 directed:NO];
    [self insertEdgeNode:7 dest:8 weight:7 directed:NO];
    [self dijkstra:0];
    
    
//    For test connected components only
//    [self insertEdgeNode:4 dest:5 directed:YES];
    self.directed = YES;
//    [self depthFirstSearch:2];
//    [self connectedComponents];
//    [self printGraph];
//    [self breathFirstSearch:2];
//    [self findPath:1 end:3];
//    [self findPath:2 end:1];
}

- (void)dijkstra:(NSUInteger)start {
    EdgeNode *node = nil;
    NSMutableArray *intree = [NSMutableArray arrayWithCapacity:self.vertices];
    NSMutableArray *distance = [NSMutableArray arrayWithCapacity:self.vertices];
    NSUInteger currentVertex;
    NSUInteger nextVertex;
    NSUInteger weight;
    NSNumber *dist;
    
    for (int i=0; i<self.vertices; i++) {
        intree[i] = @NO;
        distance[i] = @(INFINITY);
        self.parent[i] = @-1;
    }
    distance[start] = @0;
    currentVertex = start;
    
    while ([intree[currentVertex] isEqualToNumber:@NO]) {
        intree[currentVertex] = @YES;
        node = self.edgeNodes[currentVertex];
        
        // Loop through adjacent vertices that are linked to the current vertex
        while (node.next) {
            nextVertex = node.dest;
            weight = node.weight;
            
            // Calculate the distance from startVertex to currentVert. Initialize, all distance values are INF
            if ([distance[nextVertex] integerValue] > [distance[currentVertex] integerValue]+weight) {
                distance[nextVertex] = @([distance[currentVertex] integerValue]+weight);
                // Record the parent vertex of current vertex for backtracking
                self.parent[nextVertex] = @(currentVertex);
            }
            node = node.next;
        }
        
        // Search for the smallest vertex in all discovered vertices
        currentVertex = 0;
        dist = @(INFINITY);
        for (int i=1; i<self.vertices; i++) {
            //NSLog(@"dist:%@, distance: %@", dist, distance[i]);
            if ([intree[i] isEqualToNumber:@NO] && [dist isGreaterThan:distance[i]]) {
                dist = distance[i];
                currentVertex = i;
            }
        }
    }
    [self shortestPath:distance start:0 end:8];
}

// Print the shortest path from start to finish from the distance array in dijkstra
- (void)shortestPath:(NSArray *)distance start:(NSUInteger)start end:(NSUInteger)end {
    [distance enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"Vertex: %ld Parent:%@ Distance: %@", idx, self.parent[idx], obj);
    }];
    NSMutableArray *path = [NSMutableArray new];
    [path insertObject:@(end) atIndex:0];
    while (start < end) {
        [path insertObject:self.parent[end] atIndex:0];
        end = [self.parent[end] integerValue];
    }
    NSLog(@"Path %@", path);
    
}

- (void)depthFirstSearch:(NSUInteger)startVertex {
    EdgeNode *node = self.edgeNodes[startVertex];
    self.discovered[startVertex] = @YES;
    
    NSLog(@"Discover early: %ld", startVertex);
    while (node.next) {
        //node = self.edgeNodes[node.dest];
        if ([self.discovered[node.dest] isEqualToNumber:@NO]) {
            [self depthFirstSearch:node.dest];
        }
        node = node.next;
        //NSLog(@"Discover late: %ld", startVertex);
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

- (void)connectedComponents {
    NSUInteger components = 0;
    for (EdgeNode *node in self.edgeNodes) {
        if ([self.discovered[node.dest] isEqualToNumber:@NO]) {
            [self breathFirstSearch:node.dest];
            components++;
        }
    }
    NSLog(@"Total components in graph: %ld", components);
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

- (void)printGraph {
    [self.edgeNodes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"Vertex: %ld, Degree: %@, %@", idx, self.vertexDegree[idx], self.processed[idx]);
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

- (void)insertEdgeNode:(NSUInteger)source dest:(NSUInteger)dest weight:(NSInteger)weight directed:(BOOL)directed {
    EdgeNode *node = [[EdgeNode alloc] init];
    node.dest = dest;
    node.weight = weight;
    node.next = self.edgeNodes[source];
    self.edgeNodes[source] = node;
    NSUInteger newValue = [(NSNumber *)self.vertexDegree[source] integerValue] + 1;
    self.vertexDegree[source] = [NSNumber numberWithInteger:newValue];
    
    if (directed == NO) {
        [self insertEdgeNode:dest dest:source weight:weight directed:YES];
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
