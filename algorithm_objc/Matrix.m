//
//  Matrix.m
//  algorithm_objc
//
//  Created by Stephen Ling on 2/23/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import "Matrix.h"

@implementation Matrix

typedef enum {
    up,
    down,
    left,
    right
} direction;

typedef NS_ENUM(NSInteger, Dir) {
    up1,
    down1
};

/*
 Adjacency matrix:
 4 nodes: 0-1 2
          | |
          3-4 5
   0 1 2 3 4
 0|1 1 1 1 0
 1|1 1 1 1 0
 2|1 1 0 1
 3|1 0 1 1
 4|0 1 1 1
 */

- (void)setup {
    [self squareCountSetup];
    [self connectedComponentsSetup];
}

- (void)squareCountSetup {
    // Test for array size no or 1 element
    NSLog(@"Square count should be 0: %d", [self totalSquareCount:[NSArray new]]);
    NSLog(@"Square count should be 1: %d", [self totalSquareCount:@[@0]]);
    NSLog(@"Square count should be 0: %d", [self totalSquareCount:@[@0, @0]]);
    NSArray *matrix = @[@0, @1, @0,
                        @0, @0, @0,
                        @0, @0, @0,];
    NSLog(@"Square count should be 8+2=10: %d", [self totalSquareCount:matrix]);

    matrix = @[@0, @1, @0,
               @0, @0, @0,
               @0, @0, @1,];
    NSLog(@"Square count should be 7+1=9: %d", [self totalSquareCount:matrix]);
    
    matrix = @[@0, @0, @0,
               @0, @0, @0,
               @0, @0, @0,];
    NSLog(@"Square count should be 14: %d", [self totalSquareCount:matrix]);

    matrix = @[@1, @1, @1,
               @1, @1, @1,
               @1, @1, @1,];
    NSLog(@"Square count should be 0: %d", [self totalSquareCount:matrix]);
}

- (BOOL)isSquare:(NSArray *)matrix {
    // Check for matrix size nil & 0
    if (matrix.count == 0) {
        return NO;
    }
    // Check if it's a square
    double size = sqrt(matrix.count);
    return fmod(size, 1.0)==0? YES: NO;
}

- (int)totalSquareCount:(NSArray *)matrix {
    if (![self isSquare:matrix]) {
        return 0;
    }
    int size = (int)sqrt(matrix.count);
    int count = 0;
    for (int y=0; y<size; y++) {
        for (int x=0; x<size; x++) {
            if ([matrix[x+y*size] isEqualToNumber:@0]) {
                count = [self squareCount:matrix row:x col:y size:1 count:count];
            }
        }
    }
    return count;
}

- (int)squareCount:(NSArray *)matrix row:(int)row col:(int)col size:(int)size count:(int)count {
    // Base case: reach the max size of the square
    if (row >= sqrt(matrix.count) || col >= sqrt(matrix.count)) {
        return count;
    }
    for (int x=row; x<size; x++) {
        if ([matrix[x+col*size] isEqualToNumber:@1]) {
            return count;
        }
    }
    for (int y=col; y<size; y++) {
        if ([matrix[row+y*size] isEqualToNumber:@1]) {
            return count;
        }
    }
    count = [self squareCount:matrix row:row+1 col:col+1 size:size+1 count:count+1];
    return count;
}

- (BOOL)isSquare:matrix row:(int)row col:(int)col {
    for (int i=0; i<row; i++) {
        for (int j=0; j<col; j++) {
            if ([matrix[i+j*row] isEqualToNumber:@1]) {
                return NO;
            }
        }
    }
    return YES;
}

/*
 n = 3
 arr[][] =
 {0, 0, 1},
 {0, 0, 0},
 {0, 0, 0},
 
 Total: 14
 1: 8 + 3 = 11
 1,1: 7 + 2 = 9
 
 n=4: 4x4 + 3x3 + 2x2 + 1x1
 n=3: 3x3 + 2x2 + 1x1
 n=2: 2x2 + 1x1
 n*n + (n-1)*(n-1)
 */

- (NSUInteger)numberOfSquare:(NSUInteger)n {
    return (n*(n+1)*(2*n+1)) / 6;
}

/*
 0111 -> 0021 -> 0030 -> 0000
 1010 -> 1010 -> 1010 -> 1040 -> 0040
 1000 ->                      -> 2000
 0100 ->                      -> 0100
 
 111->300->000
 111     ->411->600->000
 111          ->111->711
 
 010->000
 111->121->031->040
 010          ->010->050
 
 01110
 01011
 01010
 
 width(x)=3, height(y)=2, a[1][1] = a[x+y*width] = a[4], a[0][2] = a[0+2*3] = a[6]
 0 1 2 -> 0%3=0, 1%3=1, 2%3=2
 3 4 5 -> 3%3=0, 4%3=1, 5%3=2
 6 7 8
 */

- (void)connectedComponentsSetup {
    //  0-1
    //  | |
    //  2-3
    NSArray *matrix = @[@1, @1, @1, @0,
                        @1, @1, @0, @1,
                        @1, @0, @1, @1,
                        @0, @1, @1, @1];
    NSLog(@"Total connected components 1: %ld", [self connectedComponents:matrix]);
    
    //  0-1
    //  2-3
    matrix = @[@1, @1, @0, @0,
               @1, @1, @0, @0,
               @0, @0, @1, @1,
               @0, @0, @0, @1];
    NSLog(@"Total connected components 2: %ld", [self connectedComponents:matrix]);
    
    //  0 1
    //  2 3
    matrix = @[@1, @0, @0, @0,
               @0, @1, @0, @0,
               @0, @0, @1, @0,
               @0, @0, @0, @1];
    NSLog(@"Total connected components 4: %ld", [self connectedComponents:matrix]);
}

- (NSUInteger)connectedComponents:(NSArray *)matrix {
    if (![self isSquare:matrix]) {
        return 0;
    }
    NSUInteger components = 0;
    NSUInteger count = sqrt(matrix.count);
    NSMutableArray *visited = [NSMutableArray arrayWithCapacity:matrix.count];
    for (NSUInteger i=0; i<count; i++) {
        visited[i] = @NO;
    }
    for (NSUInteger vertex=0; vertex<count; vertex++) {
        if ([visited[vertex] isEqualToNumber:@NO]) {
            visited = [self bfs:matrix visited:visited startVertex:vertex];
            components++;
        }
    }
    return components;
}

- (NSMutableArray *)bfs:(NSArray *)matrix visited:(NSMutableArray*)visited startVertex:(NSUInteger)startVertex {
    NSUInteger count = sqrt(matrix.count);
    NSMutableArray *queue = [NSMutableArray arrayWithCapacity:count];
    visited[startVertex] = @YES;
    [queue addObject:@(startVertex)];
    
    while (queue.count > 0) {
        NSUInteger vertex = [(NSNumber *)[queue firstObject] integerValue];
        [queue removeObjectAtIndex:0];
        for (NSUInteger i=0; i<count; i++) {
            if ([matrix[vertex*count+i] isEqualToNumber:@1] && [visited[i] isEqualToNumber:@NO]) {
                visited[i] = @YES;
                [queue addObject:@(i)];
            }
        }
    }
    return visited;
}

- (NSUInteger)numberOfObjectsInBitmap:(NSMutableArray *)bitmap width:(NSUInteger)width height:(NSUInteger)height {
    NSUInteger count = 0;
    
    [bitmap enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToNumber:@1]) {
            if (idx%width < width-1) {
                NSNumber *count = obj[idx];
                if ([count isEqualToNumber:@1]) {
                    // If
                    // If both right and bottom cell are 1, change all the right adjacent 1's and current cell to 0
                    // If right cell is 1 and bottom cell is 0, change current cell to 0
                    // If right cell is 0 and bottom cell is 1, change current cell to 0
                    // Need to check boundary to see if current cell is on the rightmost or bottom of the bitmap
                    if ([bitmap[idx+1] isEqualToNumber:@1] && [bitmap[idx+width] isEqualToNumber:@1]) {
                    }
                    else if ([bitmap[idx+1] isEqualToNumber:@1]) {
                    }
                    else if ([bitmap[idx+width] isEqualToNumber:@1]) {
                    }
                    obj[idx+1] = [NSNumber numberWithInteger:[count integerValue]+1];
                    obj[idx] = @0;
                }
            }
        }
    }];
    return count;
}

/* min heap: min at root, all nodes below are larger
   max heap: max at root, all nodes below are smaller
 
 10,8,7,9,12
 min  max
 8    10
9     7
 */

@end
