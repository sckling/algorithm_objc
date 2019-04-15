//
//  MaxHeap.m
//  algorithm_objc
//
//  Created by Stephen Ling on 11/30/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import "MaxHeap.h"

@interface MaxHeap()
@property (nonatomic, copy) NSMutableArray *heap;

- (NSInteger)parentIndex:(NSInteger)childIndex;
- (NSInteger)leftChildIndex:(NSInteger)parentIndex;
- (NSInteger)rightChildIndex:(NSInteger)parentIndex;

- (NSNumber *)parent:(NSInteger)index;
- (NSNumber *)leftChild:(NSInteger)index;
- (NSNumber *)rightChild:(NSInteger)index;

- (BOOL)hasParent:(NSInteger)index;
- (BOOL)hasLeftChild:(NSInteger)index;
- (BOOL)hasRightChild:(NSInteger)index;

- (void)heapifyUp;
- (void)heapifyDown;

@end

@implementation MaxHeap

- (instancetype)init {
    return [self initWithArray:[NSArray new]];
}

- (instancetype)initWithArray:(NSArray *)array {
    self = [super init];
    if (self != nil) {
        _heap = [array mutableCopy];
        if (_heap.count > 0) {
            [self buildHeap];
        }
    }
    return self;
}

- (void)buildHeap {
    NSInteger i = (self.heap.count-1)/2;
    while (i>=0) {
        [self heapify:i];
        i--;
    }
}

- (void)heapify:(NSInteger)index {
    NSInteger left = [self leftChildIndex:index];
    NSInteger right = [self rightChildIndex:index];
    NSInteger largest = index;
    if (left < self.heap.count && [self.heap[left] isGreaterThan:self.heap[index]]) {
        largest = left;
    }
    if (right < self.heap.count && [self.heap[right] isGreaterThan:self.heap[largest]]) {
        largest = right;
    }
    if (largest != index) {
        [self.heap exchangeObjectAtIndex:index withObjectAtIndex:largest];
        [self heapify:largest];
    }
}

/*
 Min heap:
 Insert element: insert new element at the end of the heap and bubble it up
 Remove top element: replace the top min element with the last element and bubble it down
 
 Parent = (index-2)/2
 Left child = index*2+1
 Right child = index*2+2
 
 3
 / \
 4   8
 /\  /\
 9 7 10 9
 
 3,4,8,9,7,10,9
 index of 7=5, parent=(5-2)/2=1 index(1)=4
 index of 8=2, left child=2*2+1=5 index(5)=10, right child=2*2+2=6 index(6)=9, parent=(2-2)/2=0 index(0)=3
 
 */

- (NSInteger)size {
    return self.heap.count;
}

- (NSInteger)leftChildIndex:(NSInteger)parentIndex {
    return parentIndex*2+1;
}

- (NSInteger)rightChildIndex:(NSInteger)parentIndex {
    return parentIndex*2+2;
}

- (NSInteger)parentIndex:(NSInteger)childIndex {
    // Both 3 & 4 have parent index = 1. Need to run up (3-2)/2=0.5 to 1
    //return ceilf((childIndex-2.0)/2.0);
    return (childIndex-1)/2;
}

- (NSNumber *)parent:(NSInteger)index {
    return self.heap[[self parentIndex:index]];
}

- (NSNumber *)leftChild:(NSInteger)index {
    return self.heap[[self leftChildIndex:index]];
}

- (NSNumber *)rightChild:(NSInteger)index {
    return self.heap[[self rightChildIndex:index]];
}

- (BOOL)hasParent:(NSInteger)index {
    return [self parentIndex:index] >= 0;
}

- (BOOL)hasLeftChild:(NSInteger)index {
    return [self leftChildIndex:index] < self.heap.count;
}

- (BOOL)hasRightChild:(NSInteger)index {
    return [self rightChildIndex:index] < self.heap.count;
}

// O(1)
- (NSNumber *)peek {
    return self.heap.count > 0 ? self.heap[0] : nil;
}

// O(log n)
- (void)insertElement:(NSNumber *)element {
    // To insert new element, add it to the last of the array and heapify up
    [self.heap addObject:element];
    [self heapifyUp];
}

- (void)heapifyUp {
    NSInteger index = self.heap.count-1;
    NSInteger parentIndex = [self parentIndex:index];
    
    while ([self hasParent:index] && [self.heap[parentIndex] isLessThan:self.heap[index]]) {
        [self.heap exchangeObjectAtIndex:parentIndex withObjectAtIndex:index];
        index = parentIndex;
        parentIndex = [self parentIndex:index];
    }
}

// O(log n)
- (NSNumber *)extract {
    if (self.heap.count == 0) {
        return nil;
    }
    // To remove max, need to put the last element to the top and heapify down
    NSNumber *max = self.heap[0];
    self.heap[0] = [self.heap lastObject];
    [self.heap removeLastObject];
    [self heapifyDown];
    return max;
}

- (void)heapifyDown {
    NSInteger index = 0;
    
    while ([self hasLeftChild:index]) {
        NSInteger largerIndex = [self leftChildIndex:index];
        if ([self hasRightChild:index] && [[self rightChild:index] isGreaterThan:[self leftChild:index]]) {
            largerIndex = [self rightChildIndex:index];
        }
        if (self.heap[index] > self.heap[largerIndex]) {
            return;
        }
        [self.heap exchangeObjectAtIndex:largerIndex withObjectAtIndex:index];
        index = largerIndex;
    }
}

@end
