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
//    [self longestSequenceSumSetup];
//    [self uniquePathsSetup];
//    [self pathInMatrixSetup];
//    [self countObjectsInBitmapSetup];
//    [self connectedCellinGridSetup];
//    [self squareCountSetup];
//    [self connectedComponentsSetup];
//    [self isWordExistSetup];
    [self islandCountSetup];
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

- (void)islandCountSetup {
    // Use nested NSArray for 2-dimensional arrays
    NSArray<NSArray *> *map1 = @[@[@1,@1,@0,@0],
                                 @[@0,@0,@1,@0],
                                 @[@1,@0,@1,@1],
                                 @[@0,@0,@0,@1]];
    NSLog(@"Island count should be 3: %ld", [self islandCount:map1]);
    
    NSArray<NSArray *> *map2 = @[@[@1,@1,@0,@0],
                                 @[@0,@0,@1,@0],
                                 @[@0,@1,@0,@1],
                                 @[@1,@1,@0,@1]];
    NSLog(@"Island count should be 4: %ld", [self islandCount:map2]);
    
    NSArray<NSArray *> *map3 = @[@[@0,@1,@0,@0],
                                 @[@0,@1,@1,@0],
                                 @[@1,@1,@0,@1],
                                 @[@1,@1,@0,@1]];
    NSLog(@"Island count should be 2: %ld", [self islandCount:map3]);
}

/*
 Nest Lab, 5/7/18
 */
- (NSInteger)islandCount:(NSArray<NSArray *> *)map {
    NSInteger count = 0;
    NSMutableSet *visited = [NSMutableSet new];
    for (NSInteger row = 0; row < map.count; row++) {
        for (NSInteger col = 0; col < map[row].count; col++) {
            NSString *location = [NSString stringWithFormat:@"%ld,%ld", row, col];
            if (![visited containsObject:location] && [map[row][col] isEqualToNumber:@1]) {
                [self traverseMap:map visited:visited row:row col:col];
                count++;
            }
        }
    }
    return count;
}

/*
 For islands with only rectangular shape, traverse right and down is sufficient
 For islands with any shape except diagonal, need to traverse left and check for visit before traverse to avoid loop
 Didn't clarify the island shape during interview and assume it's always rectangle
 */
- (void)traverseMap:(NSArray<NSArray *> *)map visited:(NSMutableSet *)visited row:(NSInteger)row col:(NSInteger)col {
    // If location is out of bounds from the map, return
    if (row < 0 || row >= map.count || col < 0 || col >= map[row].count) {
        return;
    }
    // If location is ocean, return
    if ([map[row][col] isEqualToNumber:@0]) {
        return;
    }
    // Location is land, but if already visited, return
    NSString *location = [NSString stringWithFormat:@"%ld,%ld", row, col];
    if ([visited containsObject:location]) {
        return;
    }
    [visited addObject:location];
    [self traverseMap:map visited:visited row:row+1 col:col];
    [self traverseMap:map visited:visited row:row col:col+1];
    [self traverseMap:map visited:visited row:row col:col-1];
}

/*
 Algorithm:
 1. Traverse each element in the matrix, if it's 0, call helper methox to start counting
 2. Pass in the start size 1
 */

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


- (BOOL)isSquare:(NSArray *)matrix {
    // Check for matrix size nil & 0
    if (matrix.count == 0) {
        return NO;
    }
    // Check if it's a square
    double size = sqrt(matrix.count);
    return fmod(size, 1.0)==0? YES: NO;
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
            // matrix[current_vertex][traverse other vertex]
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

- (void)numberOfPathsInMatrix:(NSUInteger)matrixSize {
    NSMutableArray *matrix = [NSMutableArray arrayWithCapacity:matrixSize*matrixSize];
    for (NSUInteger i=0; i<matrixSize; i++) {
        for (NSUInteger j=0; j<matrixSize; j++) {
            matrix[i] = @0;
            matrix[i+j*matrixSize] = @0;
        }
    }
    NSLog(@"Total path: %lu", (long int)[self pathCount:[matrix copy] x:0 y:0]);
}

- (NSUInteger)pathCount:(NSArray *)matrix x:(NSUInteger)x y:(NSUInteger)y {
    // Base case: reach the right or bottom of the matrix
    NSUInteger size = (NSUInteger)sqrt(matrix.count);
    if ((x==size)||(y==size)) {
        return 0;
    }
    NSUInteger count = [self pathCount:matrix x:x+1 y:y];
    count += [self pathCount:matrix x:x y:y+1];
    return count;
}

- (void)pathInMatrixSetup {
    int bitmap[3][3]  = {
        {0,0,0},
        {1,0,0},
        {0,0,0}
    };
    NSLog(@"Path in matrix: %d", [self pathInMatrix:bitmap row:0 col:0 rowSize:3 colSize:3]);
    [self allPathInMatrix:bitmap row:0 col:0 rowSize:3 colSize:3 path:@[]];
    
    int bitmap2[3][3]  = {
        {0,0,0},
        {1,1,0},
        {0,0,1}
    };
    NSLog(@"Path in matrix: %d", [self pathInMatrix:bitmap2 row:0 col:0 rowSize:3 colSize:3]);
    [self allPathInMatrix:bitmap2 row:0 col:0 rowSize:3 colSize:3 path:@[]];
    
    int bitmap3[3][3]  = {
        {0,0,0},
        {0,1,0},
        {0,0,0}
    };
    NSLog(@"Path in matrix: %d", [self pathInMatrix:bitmap3 row:0 col:0 rowSize:3 colSize:3]);
    [self allPathInMatrix:bitmap3 row:0 col:0 rowSize:3 colSize:3 path:@[]];
}

- (Boolean)pathInMatrix:(int[][3])matrix row:(int)row col:(int)col rowSize:(int)rowSize colSize:(int)colSize {
    // Hit a wall and can't proceed, return NO
    if (matrix[row][col] == 1) {
        return NO;
    }
    // Current cell is zero (a path)
    // If reached the end corner of the matrix, check whether it's hitting a wall of not
    if (row == rowSize-1 && col == colSize-1) {
        return YES;
    }
    // If hits the end of a row, continues to move on the column
    if (row == rowSize-1) {
        return [self pathInMatrix:matrix row:row col:col+1 rowSize:rowSize colSize:colSize];
    }
    // If hits the end of a column, continue to move on the row
    if (col == colSize-1) {
        return [self pathInMatrix:matrix row:row+1 col:col rowSize:rowSize colSize:colSize];
    }
    // If both row and column paths return NO, there's no path
    if ([self pathInMatrix:matrix row:row+1 col:col rowSize:rowSize colSize:colSize] == NO) {
        if ([self pathInMatrix:matrix row:row col:col+1 rowSize:rowSize colSize:colSize] == NO) {
            return NO;
        }
    }
    return YES;
}

- (void)allPathInMatrix:(int[][3])matrix row:(int)row col:(int)col rowSize:(int)rowSize colSize:(int)colSize path:(NSArray *)path {
    // Hit a wall and can't proceed, return
    if (matrix[row][col] == 1) {
        return;
    }
    // Add the current location to the path
    NSMutableArray *newPath = [NSMutableArray arrayWithArray:path];
    [newPath addObject:[NSString stringWithFormat:@"%d,%d", row, col]];

    // If reached the end corner of the matrix, print the path and return
    if (row == rowSize-1 && col == colSize-1) {
//        NSLog(@"Path: %@", newPath);
        return;
    }
    // If hit the bound of the row, or column is less than bound, move to next column
//    if (row == rowSize-1 || col<colSize) {
    if (col < colSize-1) {
        [self allPathInMatrix:matrix row:row col:col+1 rowSize:rowSize colSize:colSize path:newPath];
    }
    // If hit the bound of the column, or row is less than bound, move to next row
//    if (col == colSize-1 || row <rowSize) {
    if (row < rowSize-1) {
        [self allPathInMatrix:matrix row:row+1 col:col rowSize:rowSize colSize:colSize path:newPath];
    }
    return;
}

- (void)uniquePathsSetup {
    int rowSize = 3;
    int colSize = 2;
    NSLog(@"Unique paths=3: %d", [self uniquePaths:rowSize n:colSize]);
    rowSize = 7;
    colSize = 3;
    NSLog(@"Unique paths=28: %d", [self uniquePaths:rowSize n:colSize]);
}

- (int)uniquePaths:(int)rowSize n:(int)colSize {
    return [self findPath:0 col:0 size:rowSize size:colSize];
}

- (int)findPath:(int)row col:(int)col size:(int)rowSize size:(int)colSize {
    // Reach the lower right corner of the matrix, a path is found
//    NSLog(@"row:%d, col:%d", row, col);
    if (row == rowSize-1 && col == colSize-1) {
        return 1;
    }
    int path = 0;
    // Go to next row if not at the end
    if (row < rowSize-1) {
        path += [self findPath:row+1 col:col size:rowSize size:colSize];
    }
    // Go to next col if not at the end
    if (col < colSize-1) {
        path += [self findPath:row col:col+1 size:rowSize size:colSize];
    }
    return path;
}

/*
 Given a rectangle matrix with size n*m, find the longest sequence inside.
 2 3 9 10
 1 7 8 11
 5 4 6 12
 [1,2,3], [4,5], [6], [7,8,9,10,11,12] -> longest sequence count = 6
 */

- (void)longestSequenceSumSetup {
    int matrix[3][4]  = {
        {2,3,9,10},
        {1,7,8,11},
        {5,4,6,12}
    };
    NSLog(@"Longest: %d", [self longestSequenceSum:matrix]);
}

- (int)longestSequenceSum:(int[][4])matrix {
    int maxSoFar = 0;
    for (int row=0; row<3; row++) {
        for (int col=0; col<4; col++) {
            int count = [self findSequenceSum:matrix row:row col:col size:3 size:4 count:1];
            maxSoFar = count > maxSoFar ? count : maxSoFar;
        }
    }
    return maxSoFar;
}

- (int)findSequenceSum:(int[][4])matrix row:(int)row col:(int)col size:(int)rowSize size:(int)colSize count:(int)count {
//    NSLog(@"%d, count: %d", matrix[row][col], count);
    // Base case when row or col larger than matrix size
    // 0,1,2,4: row size >= 3
    if (row >= rowSize || col >= colSize) {
        return count;
    }
    // Check which direction is the next sequence
    // Both row and col are within size-1, no need to check
    // Or check before recursive call to make one less recursive call
//    if (row < rowSize-1) {
        if (matrix[row+1][col] == matrix[row][col]+1) {
            return [self findSequenceSum:matrix row:row+1 col:col size:rowSize size:colSize count:count+1];
        }
//    }
//    if (row > 0) {
        if (matrix[row-1][col] == matrix[row][col]+1) {
            return [self findSequenceSum:matrix row:row-1 col:col size:rowSize size:colSize count:count+1];
        }
//    }
//    if (col < colSize-1) {
        if (matrix[row][col+1] == matrix[row][col]+1) {
            return [self findSequenceSum:matrix row:row col:col+1 size:rowSize size:colSize count:count+1];
        }
//    }
//    if (col > 0) {
        if (matrix[row][col-1] == matrix[row][col]+1) {
            return [self findSequenceSum:matrix row:row col:col-1 size:rowSize size:colSize count:count+1];
        }
//    }
    return count;
}

/*
 Coding question: Count how many objects in a 2-D bitmap.
 Cells adjacent in horizontal or vertical are counted as same objectm diagonal is not.
 
 000000002
 110000022
 000000002
 300000000
 330040000
 
 Input is binary 0,1
 Answer is 4
 */

- (void)countObjectsInBitmapSetup {
    int bitmap[5][9]  = {
        {0,0,0,0,0,0,0,0,1},
        {1,1,0,0,0,0,0,1,1},
        {0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0},
        {1,1,0,0,1,0,0,0,0}
    };
    int visit[5][9]  = {
        {0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0}
    };
    printf("Total objects: %d\n", [self countObjectsInBitmap:bitmap visit:visit]);
}

- (int)countObjectsInBitmap:(int[][9])bitmap visit:(int[][9])visit {
    int count = 0;
    for (int row=0; row<5; row++) {
        for (int col=0; col<9; col++) {
            if (bitmap[row][col] == 1 && visit[row][col] == 0) {
                [self dfs:bitmap visit:visit row:row col:col];
                count++;
            }
        }
    }
    return count;
}

- (void)dfs:(int[][9])bitmap visit:(int[][9])visit row:(int)row col:(int)col {
    /*
     For each point in matrix, if it's not out of bound and already visited,
     */
    if (row>=0 && row <5 && col>=0 && col<9 && bitmap[row][col] == 1 && visit[row][col] == 0) {
        visit[row][col] = 1;
        [self dfs:bitmap visit:visit row:row+1 col:col];
        [self dfs:bitmap visit:visit row:row-1 col:col];
        [self dfs:bitmap visit:visit row:row col:col+1];
        [self dfs:bitmap visit:visit row:row col:col-1];
    }
}

- (void)connectedCellinGridSetup {
    NSArray *matrix = @[@1, @1, @0, @0, @0,
                        @0, @1, @1, @0, @1,
                        @0, @0, @1, @0, @1,
                        @1, @0, @0, @0, @1];
    NSLog(@"Largest size of connected cell in grid: %d", [self connectedCellinGrid:matrix row:4 col:5]);
}

// Find size of the largest connected cell (horizontal/vertical/diagonal) in a grid.
- (int)connectedCellinGrid:(NSArray *)matrix row:(int)row col:(int)col {
    int maxSoFar = 0;
    NSMutableArray *visit = [self initArray:row col:col];

    for (int x=0; x<col; x++) {
        for (int y=0; y<row; y++) {
            if ([matrix[x+y*col] isEqualToNumber:@1] && [visit[x+y*col] isEqualToNumber:@NO]) {
                int size = [self dfs:matrix visit:&visit row:y col:x sizeRow:row sizeCol:col];
                printf("size: %d\n", size);
                if (size > maxSoFar) {
                    maxSoFar = size;
                }
            }
        }
    }
    return maxSoFar;
}

- (int)dfs:(NSArray *)matrix visit:(NSMutableArray **)visit row:(int)row col:(int)col sizeRow:(int)r sizeCol:(int)c {
    int count = 0;
    if (row>=0 && row<r && col>=0 && col<c
        && [[*visit objectAtIndex:col+row*c] isEqualToNumber:@NO]
        && ([[matrix objectAtIndex:col+row*c] isEqualToNumber:@1])) {
        [*visit setObject:@YES atIndexedSubscript:col+row*c];
        count = 1+[self dfs:matrix visit:visit row:row+1 col:col sizeRow:r sizeCol:c]
        +[self dfs:matrix visit:visit row:row-1 col:col sizeRow:r sizeCol:c]
        +[self dfs:matrix visit:visit row:row col:col+1 sizeRow:r sizeCol:c]
        +[self dfs:matrix visit:visit row:row col:col-1 sizeRow:r sizeCol:c]
        +[self dfs:matrix visit:visit row:row+1 col:col+1 sizeRow:r sizeCol:c]
        +[self dfs:matrix visit:visit row:row+1 col:col-1 sizeRow:r sizeCol:c]
        +[self dfs:matrix visit:visit row:row-1 col:col+1 sizeRow:r sizeCol:c]
        +[self dfs:matrix visit:visit row:row-1 col:col-1 sizeRow:r sizeCol:c];
    }
    return count;
}

- (NSMutableArray *)initArray:(NSUInteger)row col:(NSUInteger)col {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:row*col];
    for (int i=0; i<row*col; i++) {
        array[i] = @NO;
    }
    return array;
}

/*
 Given a 2D board and a word, find if the word exists in the grid.
 
 The word can be constructed from letters of sequentially adjacent cell, where "adjacent" cells are those horizontally or vertically neighboring. The same letter cell may not be used more than once.
 
 For example,
 Given board =
 
 [
 ['A','B','C','E'],
 ['S','F','C','S'],
 ['A','D','E','E']
 ]
 word = "ABCCED", -> returns true,
 word = "SEE", -> returns true,
 word = "ABCB", -> returns false.
 */

- (void)isWordExistSetup {
    char board[3][4] = {
        {'a','b','c','e'},
        {'s','f','c','s'},
        {'a','d','e','e'}
    };
    NSString *word = @"a";
    NSLog(@"isWordExist: %@ %hhd", word, [self isWordExist:board word:word]);
    word = @"abcced";
    NSLog(@"isWordExist: %@ %hhd", word, [self isWordExist:board word:word]);
    word = @"see";
    NSLog(@"isWordExist: %@ %hhd", word, [self isWordExist:board word:word]);
    word = @"abcb";
    NSLog(@"isWordExist: %@ %hhd", word, [self isWordExist:board word:word]);
    NSLog(@"isWordExist: %hhd", [self isWordExist:board word:@""]);
}

- (BOOL)isWordExist:(char[][4])board word:(NSString *)word {
    // 1. Initialize a 'visit' matrix that is same size of the board
    // 2. Extract the first character of the word and find the start position and search for word
    // 3. If can't find it, find the next start position and search
    if (board == nil || word == nil || word.length == 0) {
        return NO;
    }
    int visit[3][4];
    for (int i=0; i<3; i++) {
        for (int j=0; j<4; j++) {
            if (board[i][j] == [word characterAtIndex:0]) {
                // Found the position of the first character, search if word exist from current position
                [self initVisit:visit];
                if ([self findCharacter:board word:word cIndex:0 row:i rowSize:3 col:j colSize:4 visit:visit]) {
                    return YES;
                }
            }
        }
    }
    return NO;
}

- (BOOL)findCharacter:(char[][4])board word:(NSString *)word cIndex:(int)cIndex row:(int)row rowSize:(int)rowSize col:(int)col colSize:(int)colSize visit:(int[][4])visit {
    if (row >= rowSize || col >= colSize || visit[row][col] == 1) {
        return NO;
    }
    if (board[row][col] == [word characterAtIndex:cIndex++]) {
//        NSLog(@"%c, index:%d row: %d, col:%d", board[row][col], cIndex, row, col);
        visit[row][col] = 1;
        if (cIndex == word.length) {
            // Reach the end of the word and all characters matched, word found
            return YES;
        }
        if ([self findCharacter:board word:word cIndex:cIndex row:row+1 rowSize:rowSize col:col colSize:colSize visit:visit]) {
            return YES;
        }
        if ([self findCharacter:board word:word cIndex:cIndex row:row-1 rowSize:rowSize col:col colSize:colSize visit:visit]) {
            return YES;
        }
        if ([self findCharacter:board word:word cIndex:cIndex row:row rowSize:rowSize col:col+1 colSize:colSize visit:visit]) {
            return YES;
        }
        if ([self findCharacter:board word:word cIndex:cIndex row:row rowSize:rowSize col:col-1 colSize:colSize visit:visit]) {
            return YES;
        }
    }
    return NO;
}

- (void)initVisit:(int[][4])visit {
    for (int i=0; i<3; i++) {
        for (int j=0; j<4; j++) {
            visit[i][j] = 0;
        }
    }
}


@end
