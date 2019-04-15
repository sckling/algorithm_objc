//
//  Old Code.c
//  algorithm_objc
//
//  Created by ling, stephen on 1/28/19.
//  Copyright © 2019 sling. All rights reserved.
//

#include <stdio.h>

//- (NSUInteger)connectedComponents:(NSArray *)matrix {
//    if (![self isSquare:matrix]) {
//        return 0;
//    }
//    NSUInteger components = 0;
//    NSUInteger count = sqrt(matrix.count);
//    NSMutableArray *visited = [NSMutableArray arrayWithCapacity:matrix.count];
//    for (NSUInteger i=0; i<count; i++) {
//        visited[i] = @NO;
//    }
//    for (NSUInteger vertex=0; vertex<count; vertex++) {
//        if ([visited[vertex] isEqualToNumber:@NO]) {
//            visited = [self bfs:matrix visited:visited startVertex:vertex];
//            components++;
//        }
//    }
//    return components;
//}
//
//- (NSMutableArray *)bfs:(NSArray *)matrix visited:(NSMutableArray*)visited startVertex:(NSUInteger)startVertex {
//    NSUInteger count = sqrt(matrix.count);
//    NSMutableArray *queue = [NSMutableArray arrayWithCapacity:count];
//    visited[startVertex] = @YES;
//    [queue addObject:@(startVertex)];
//
//    while (queue.count > 0) {
//        NSUInteger vertex = [(NSNumber *)[queue firstObject] integerValue];
//        [queue removeObjectAtIndex:0];
//        for (NSUInteger i=0; i<count; i++) {
//            // matrix[current_vertex][traverse other vertex]
//            if ([matrix[vertex*count+i] isEqualToNumber:@1] && [visited[i] isEqualToNumber:@NO]) {
//                visited[i] = @YES;
//                [queue addObject:@(i)];
//            }
//        }
//    }
//    return visited;
//}

//- (void)numberOfPathsInMatrix:(NSUInteger)matrixSize {
//    NSMutableArray *matrix = [NSMutableArray arrayWithCapacity:matrixSize*matrixSize];
//    for (NSUInteger i=0; i<matrixSize; i++) {
//        for (NSUInteger j=0; j<matrixSize; j++) {
//            matrix[i] = @0;
//            matrix[i+j*matrixSize] = @0;
//        }
//    }
//    NSLog(@"Total path: %lu", (long int)[self pathCount:[matrix copy] x:0 y:0]);
//}
//
//- (NSUInteger)pathCount:(NSArray *)matrix x:(NSUInteger)x y:(NSUInteger)y {
//    // Base case: reach the right or bottom of the matrix
//    NSUInteger size = (NSUInteger)sqrt(matrix.count);
//    if ((x==size)||(y==size)) {
//        return 0;
//    }
//    NSUInteger count = [self pathCount:matrix x:x+1 y:y];
//    count += [self pathCount:matrix x:x y:y+1];
//    return count;
//}

//- (Boolean)pathInMatrix:(int[][3])matrix row:(int)row col:(int)col rowSize:(int)rowSize colSize:(int)colSize {
//    // Hit a wall and can't proceed, return NO
//    if (matrix[row][col] == 1) {
//        return NO;
//    }
//    // Current cell is zero (a path)
//    // If reached the end corner of the matrix, check whether it's hitting a wall of not
//    if (row == rowSize-1 && col == colSize-1) {
//        return YES;
//    }
//    // If hits the end of a row, continues to move on the column
//    if (row == rowSize-1) {
//        return [self pathInMatrix:matrix row:row col:col+1 rowSize:rowSize colSize:colSize];
//    }
//    // If hits the end of a column, continue to move on the row
//    if (col == colSize-1) {
//        return [self pathInMatrix:matrix row:row+1 col:col rowSize:rowSize colSize:colSize];
//    }
//    // If both row and column paths return NO, there's no path
//    if ([self pathInMatrix:matrix row:row+1 col:col rowSize:rowSize colSize:colSize] == NO) {
//        if ([self pathInMatrix:matrix row:row col:col+1 rowSize:rowSize colSize:colSize] == NO) {
//            return NO;
//        }
//    }
//    return YES;
//}
//
//- (void)allPathInMatrix:(int[][3])matrix row:(int)row col:(int)col rowSize:(int)rowSize colSize:(int)colSize path:(NSArray *)path {
//    // Hit a wall and can't proceed, return
//    if (matrix[row][col] == 1) {
//        return;
//    }
//    // Add the current location to the path
//    NSMutableArray *newPath = [NSMutableArray arrayWithArray:path];
//    [newPath addObject:[NSString stringWithFormat:@"%d,%d", row, col]];
//
//    // If reached the end corner of the matrix, print the path and return
//    if (row == rowSize-1 && col == colSize-1) {
////        NSLog(@"Path: %@", newPath);
//        return;
//    }
//    // If hit the bound of the row, or column is less than bound, move to next column
////    if (row == rowSize-1 || col<colSize) {
//    if (col < colSize-1) {
//        [self allPathInMatrix:matrix row:row col:col+1 rowSize:rowSize colSize:colSize path:newPath];
//    }
//    // If hit the bound of the column, or row is less than bound, move to next row
////    if (col == colSize-1 || row <rowSize) {
//    if (row < rowSize-1) {
//        [self allPathInMatrix:matrix row:row+1 col:col rowSize:rowSize colSize:colSize path:newPath];
//    }
//    return;
//}

//- (int)uniquePaths:(int)rowSize n:(int)colSize {
//    return [self findPath:0 col:0 size:rowSize size:colSize];
//}
//
//- (int)findPath:(int)row col:(int)col size:(int)rowSize size:(int)colSize {
//    // Reach the lower right corner of the matrix, a path is found
////    NSLog(@"row:%d, col:%d", row, col);
//    if (row == rowSize-1 && col == colSize-1) {
//        return 1;
//    }
//    int path = 0;
//    // Go to next row if not at the end
//    if (row < rowSize-1) {
//        path += [self findPath:row+1 col:col size:rowSize size:colSize];
//    }
//    // Go to next col if not at the end
//    if (col < colSize-1) {
//        path += [self findPath:row col:col+1 size:rowSize size:colSize];
//    }
//    return path;
//}

//- (int)longestSequenceSum:(int[][4])matrix {
//    int maxSoFar = 0;
//    for (int row=0; row<3; row++) {
//        for (int col=0; col<4; col++) {
//            int count = [self findSequenceSum:matrix row:row col:col size:3 size:4 count:1];
//            maxSoFar = count > maxSoFar ? count : maxSoFar;
//        }
//    }
//    return maxSoFar;
//}
//
//- (int)findSequenceSum:(int[][4])matrix row:(int)row col:(int)col size:(int)rowSize size:(int)colSize count:(int)count {
////    NSLog(@"%d, count: %d", matrix[row][col], count);
//    // Base case when row or col larger than matrix size
//    // 0,1,2,4: row size >= 3
//    if (row >= rowSize || col >= colSize) {
//        return count;
//    }
//    // Check which direction is the next sequence
//    // Both row and col are within size-1, no need to check
//    // Or check before recursive call to make one less recursive call
////    if (row < rowSize-1) {
//        if (matrix[row+1][col] == matrix[row][col]+1) {
//            return [self findSequenceSum:matrix row:row+1 col:col size:rowSize size:colSize count:count+1];
//        }
////    }
////    if (row > 0) {
//        if (matrix[row-1][col] == matrix[row][col]+1) {
//            return [self findSequenceSum:matrix row:row-1 col:col size:rowSize size:colSize count:count+1];
//        }
////    }
////    if (col < colSize-1) {
//        if (matrix[row][col+1] == matrix[row][col]+1) {
//            return [self findSequenceSum:matrix row:row col:col+1 size:rowSize size:colSize count:count+1];
//        }
////    }
////    if (col > 0) {
//        if (matrix[row][col-1] == matrix[row][col]+1) {
//            return [self findSequenceSum:matrix row:row col:col-1 size:rowSize size:colSize count:count+1];
//        }
////    }
//    return count;
//}

// Find size of the largest connected cell (horizontal/vertical/diagonal) in a grid.
//- (int)connectedCellinGrid:(NSArray *)matrix row:(int)row col:(int)col {
//    int maxSoFar = 0;
//    NSMutableArray *visit = [self initArray:row col:col];
//
//    for (int x=0; x<col; x++) {
//        for (int y=0; y<row; y++) {
//            if ([matrix[x+y*col] isEqualToNumber:@1] && [visit[x+y*col] isEqualToNumber:@NO]) {
//                int size = [self dfs:matrix visit:&visit row:y col:x sizeRow:row sizeCol:col];
//                printf("size: %d\n", size);
//                if (size > maxSoFar) {
//                    maxSoFar = size;
//                }
//            }
//        }
//    }
//    return maxSoFar;
//}
//
//- (int)dfs:(NSArray *)matrix visit:(NSMutableArray **)visit row:(int)row col:(int)col sizeRow:(int)r sizeCol:(int)c {
//    int count = 0;
//    if (row>=0 && row<r && col>=0 && col<c
//        && [[*visit objectAtIndex:col+row*c] isEqualToNumber:@NO]
//        && ([[matrix objectAtIndex:col+row*c] isEqualToNumber:@1])) {
//        [*visit setObject:@YES atIndexedSubscript:col+row*c];
//        count = 1+[self dfs:matrix visit:visit row:row+1 col:col sizeRow:r sizeCol:c]
//        +[self dfs:matrix visit:visit row:row-1 col:col sizeRow:r sizeCol:c]
//        +[self dfs:matrix visit:visit row:row col:col+1 sizeRow:r sizeCol:c]
//        +[self dfs:matrix visit:visit row:row col:col-1 sizeRow:r sizeCol:c]
//        +[self dfs:matrix visit:visit row:row+1 col:col+1 sizeRow:r sizeCol:c]
//        +[self dfs:matrix visit:visit row:row+1 col:col-1 sizeRow:r sizeCol:c]
//        +[self dfs:matrix visit:visit row:row-1 col:col+1 sizeRow:r sizeCol:c]
//        +[self dfs:matrix visit:visit row:row-1 col:col-1 sizeRow:r sizeCol:c];
//    }
//    return count;
//}
//
//- (NSMutableArray *)initArray:(NSUInteger)row col:(NSUInteger)col {
//    NSMutableArray *array = [NSMutableArray arrayWithCapacity:row*col];
//    for (int i=0; i<row*col; i++) {
//        array[i] = @NO;
//    }
//    return array;
//}

//- (BOOL)isWordExist:(char[][4])board word:(NSString *)word {
//    // 1. Initialize a 'visit' matrix that is same size of the board
//    // 2. Extract the first character of the word and find the start position and search for word
//    // 3. If can't find it, find the next start position and search
//    if (board == nil || word == nil || word.length == 0) {
//        return NO;
//    }
//    int visit[3][4];
//    for (int i=0; i<3; i++) {
//        for (int j=0; j<4; j++) {
//            if (board[i][j] == [word characterAtIndex:0]) {
//                // Found the position of the first character, search if word exist from current position
//                [self initVisit:visit];
//                if ([self findCharacter:board word:word cIndex:0 row:i rowSize:3 col:j colSize:4 visit:visit]) {
//                    return YES;
//                }
//            }
//        }
//    }
//    return NO;
//}
//
//- (BOOL)findCharacter:(char[][4])board word:(NSString *)word cIndex:(int)cIndex row:(int)row rowSize:(int)rowSize col:(int)col colSize:(int)colSize visit:(int[][4])visit {
//    if (row >= rowSize || col >= colSize || visit[row][col] == 1) {
//        return NO;
//    }
//    if (board[row][col] == [word characterAtIndex:cIndex++]) {
////        NSLog(@"%c, index:%d row: %d, col:%d", board[row][col], cIndex, row, col);
//        visit[row][col] = 1;
//        if (cIndex == word.length) {
//            // Reach the end of the word and all characters matched, word found
//            return YES;
//        }
//        if ([self findCharacter:board word:word cIndex:cIndex row:row+1 rowSize:rowSize col:col colSize:colSize visit:visit]) {
//            return YES;
//        }
//        if ([self findCharacter:board word:word cIndex:cIndex row:row-1 rowSize:rowSize col:col colSize:colSize visit:visit]) {
//            return YES;
//        }
//        if ([self findCharacter:board word:word cIndex:cIndex row:row rowSize:rowSize col:col+1 colSize:colSize visit:visit]) {
//            return YES;
//        }
//        if ([self findCharacter:board word:word cIndex:cIndex row:row rowSize:rowSize col:col-1 colSize:colSize visit:visit]) {
//            return YES;
//        }
//    }
//    return NO;
//}
//
//- (void)initVisit:(int[][4])visit {
//    for (int i=0; i<3; i++) {
//        for (int j=0; j<4; j++) {
//            visit[i][j] = 0;
//        }
//    }
//}
