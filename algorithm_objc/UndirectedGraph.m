//
//  UndirectedGraph.m
//  algorithm_objc
//
//  Created by Stephen Ling on 12/8/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import "UndirectedGraph.h"

typedef struct Node {
    int dest;
    struct Node *next;
} Node;

@implementation UndirectedGraph

- (instancetype)init {
    Node *node1, *node2;
    node1 = malloc(sizeof(Node));
    node2 = malloc(sizeof(Node));
    node1->dest = 10;
    node1->next = node2;
    node2->dest = 20;
    return self;
}

@end
