//
//  Matrix.m
//  algorithm_objc
//
//  Created by Stephen Ling on 2/23/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import "Matrix.h"

@implementation Cell

- (instancetype)initWithPosition:(int)row col:(int)col {
    return [self initWithPosition:row col:col distance:0];
}

- (instancetype)initWithPosition:(int)row col:(int)col distance:(int)dist {
    if (self = [super init]) {
        _row = row;
        _col = col;
        _dist = dist;
    }
    return self;
}

@end

@interface Matrix ()
@property NSArray *a1;
@property NSArray *r1;
@property NSMutableArray<NSMutableArray *> *dp;
@property NSMutableSet *dpSet;
@property NSMutableDictionary *dpDict;
@end

@implementation Matrix



/*
 Map colors or island counts problema and genenral 2D matrix problems
 
 Color map question
 1. Data structure? 2D array
 2. Value in array? UIColor or color enum or int
 3. Dimension? MxN
 4. Blank cell? Yes
 5. Edge cases: no color, size=0, size=1, super large size, or equal amount of color cells, overflow.
 
 Algorithm:
 1. Created a blank visited array that mirror the size of the grid. This is a junior approach and could be red flag. A hash map is better because of time and space complexity. Keys could be string "x,y" or float "x.y". Need to talk about namespace collision.
 2. If modification of original matrix is allowed, can simply change value of visited cell.
 3. Traverse each cell and if it's not been visited, start traversal from it
 4. For a single cell location, initiate a DFS:  pass the x, y, color and count. Iterative vs Recursive; proper count
 Stack overflow from recursion because recursion uses stack space and maybe machine will run out of stack space (let's say 10k stacks). Good to ask how big the grid will be and estimate if it can fit in stack space when using recursion.
 Iteration has no limit on stack space and can use as much as the memory space available on the machine. Use stack or queue to push the cell's 4 neighbors to it and pop when done.
 5. Return count if one of the following conditions met:
 - At grid boundary: 0<=x<=row, 0<=y<=col
 - Color doesn't match previous cell
 - Already visited
 6. Else mark current cell as visit and traverse to all direction: x+1,y; x-1,y; x,y+1; x,y-1
 7. For each return count, compare to the current max value and update if greater then it.
 8. Write a helper method to do bounce check to make the code cleaner
 9. Try to do time and space complexity analysis and trade-offs before coding instead of after.
 */

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
    [self pathInMatrixSetup];
//    [self countObjectsInBitmapSetup];
//    [self connectedCellinGridSetup];
//    [self largestSquareSetup];
//    [self squareCountSetup];
//    [self connectedComponentsSetup];
//    [self isWordExistSetup];
//    [self islandCountSetup];
//    [self minimumDistanceToFindGoldSetup];
//    [self minStepsInMatrixSetup];
//	[self largestRectangleSetup];
}

- (void)initialArray:(NSInteger)row col:(NSInteger)col {
    for (NSInteger r=0; r<row; r++) {
        for (NSInteger c=0; c<col; c++) {
            self.dp[r][c] = @0;
        }
    }
}

- (void)copyArray:(NSArray<NSArray *> *)a {
    self.dp = [NSMutableArray new];
    for (NSInteger r=0; r<a.count; r++) {
        self.dp[r] = [NSMutableArray arrayWithCapacity:a[r].count];
        for (NSInteger c=0; c<a[r].count; c++) {
            self.dp[r][c] = a[r][c];
        }
    }
}

/*
 Given an M by N matrix with 1=wall and 0=path. Find the minimum number of steps from point A to point B.
 If there's no path, return -1. You can go up, down, left, right.
 */
- (void)minStepsInMatrixSetup {
    NSArray<NSArray *> *matrix = @[@[@0,@0,@0,@0],
                                   @[@1,@1,@0,@1],
                                   @[@0,@0,@0,@0],
                                   @[@0,@0,@0,@0]];
    Cell *start = [[Cell alloc] initWithPosition:3 col:0];
    Cell *end = [[Cell alloc] initWithPosition:0 col:0];
    NSLog(@"Expected: 7, received: %d", [self minStepsInMatrix:matrix start:start end:end]);
}

/*
 Algorithm
 1. Create a visited Set to store visited cell
 2. BFS from start and add count for each step. Mark cells visited.
 3. First to reach end return count
 4. If no path to go, return -1.
 5. Check matrix bounds.
 */
- (int)minStepsInMatrix:(NSArray<NSArray *> *)m start:(Cell *)s end:(Cell *)e {
    self.dpSet = [NSMutableSet new];
    NSMutableArray *q = [NSMutableArray new];
    [q addObject:s];
    int count = 0;
    while (q.count > 0) {
        Cell *c = q[0];
        [q removeObjectAtIndex:0];
        NSString *key = [NSString stringWithFormat:@"%d,%d", c.row, c.col];
        if (![self.dpSet containsObject:key]) {
            [self.dpSet addObject:key];
            count++;
            if (c.row == e.row && c.col == e.col) {
                return count;
            }
            // Traverse all valid child cells: up, down, left, right
            // What if validCells return nil?
            NSArray *validCells = [self validCells:m row:c.row col:c.col];
            if (validCells) {
                [q addObjectsFromArray:validCells];
            }
        }
    }
    return -1;
}

- (NSArray *)validCells:(NSArray<NSArray *> *)m row:(int)row col:(int)col {
    NSMutableArray *cells = [NSMutableArray new];
    NSArray *rowNum = @[@1, @-1, @0, @0];
    NSArray *colNum = @[@0, @0, @1, @-1];
    for (int i=0; i<rowNum.count; i++) {
        int x = row+[rowNum[i] intValue];
        int y = col+[colNum[i] intValue];
        if ((x >=0 && x<m.count) && (y>=0 && y<m[i].count)) {
            Cell *cell = [[Cell alloc] initWithPosition:x col:y];
            [cells addObject:cell];
        }
    }
    return [cells copy];
}

- (void)largestRectangleSetup {
	NSArray<NSArray<NSNumber *> *>*matrix = @[@[@0, @1, @1, @1, @0],
											  @[@0, @1, @1, @0, @0],
											  @[@1, @1, @1, @1, @0],
											  @[@0, @1, @0, @0, @1]];
	NSLog(@"Largest square is 6, received: %ld", [self largestRectInMatrix:matrix]);
	NSLog(@"Largest square is 6, received: %ld", [self largestRectInMatrixLinear:matrix]);
	
	matrix = @[@[@0, @1, @1, @1, @0],
			   @[@0, @1, @1, @0, @0],
			   @[@1, @1, @0, @1, @0],
			   @[@0, @1, @0, @0, @1],
			   @[@0, @1, @0, @0, @1]];
	NSLog(@"Largest square is 5, received: %ld", [self largestRectInMatrix:matrix]);
	NSLog(@"Largest square is 5, received: %ld", [self largestRectInMatrixLinear:matrix]);
}

- (NSInteger)largestRectInMatrixLinear:(NSArray<NSArray<NSNumber *> *>*)matrix {
	NSInteger max = 0;
	[self copyArray:matrix];
	for (int row=0; row<matrix.count; row++) {
		for (int col=0; col<matrix[row].count; col++) {
//			 Algorihtm is to build a histogram for each row with previous row counts (except first row).
//			 if m[i][j]>0 =>0; if m[i][j]>0 => m[i-1][j] + m[i][j]. Since this is a binary matrix, m[i][j] is always 0/1
			if (row > 0 && [matrix[row][col] isEqualTo:@1]) {
				self.dp[row][col] = @([self.dp[row-1][col] integerValue] + 1);
			}
		}
		max = MAX(max, [self largestRectInRowAsHistogram:self.dp[row]]);
//		NSLog(@"histogram: %@, %ld", self.dp[row], max);
	}
	return max;
}

- (NSInteger)largestRectInRowAsHistogram:(NSArray<NSNumber *> *)h {
	NSInteger max = 0;
	NSInteger i=0;
	NSMutableArray *stack = [NSMutableArray new];
	while (i < h.count) {
		NSInteger top = [[stack lastObject] integerValue];
		if (stack.count == 0 || [h[i] isGreaterThanOrEqualTo:h[top]]) {
			[stack addObject:@(i++)];
		}
		/*
		 Current bar is lower than previous bar so we won't add
		 For each bar that's lower than previous one, calculate the width from that index to current index as width and multiple by current height.
		 Current height won't add to stack untill all the higher bars are processed.
		 */
		else {
			NSInteger previousHeight = [h[top] integerValue];
			[stack removeLastObject];
			NSInteger width = stack.count == 0 ? i : i-[[stack lastObject] integerValue]-1;
			NSInteger size = previousHeight * width;
			max = MAX(max, size);
		}
	}
	// Process anything left in stack
	while (stack.count > 0) {
		NSNumber *previousHeight = h[[stack[stack.count-1] integerValue]];
		[stack removeLastObject];
		NSInteger width = stack.count == 0 ? i : i-[[stack lastObject] integerValue]-1;
		NSInteger size = [previousHeight integerValue] * width;
		max = MAX(max, size);
	}
	return max;
}

- (NSInteger)largestRectInMatrix:(NSArray<NSArray *>*)matrix {
	if (matrix.count == 0) {
		return 0;
	}
	[self copyArray:matrix];
	NSInteger max = 0;
	for (int row=0; row<matrix.count; row++) {
		for (int col=0; col<matrix[row].count; col++) {
			if ([matrix[row][col] isEqualTo:@1]) {
				max = MAX(max, [self countRect:matrix row:row col:col]);
			}
		}
	}
	return max;
}

- (int)countRect:(NSArray<NSArray *>*)m row:(int)row col:(int)col {
	int maxSize = 0;
	int minWidth = INT_MAX;

	for (int x=row; x<m.count; x++) {
		int width = 0;
		for (int y=col; y<m[row].count; y++) {
			if ([m[x][y] isEqualToNumber:@1]) {
				width++;
			} else {
				break;
			}
		}
		minWidth = MIN(minWidth, width);
		int size = minWidth * (x-row+1);
//		NSLog(@"x=%d, w=%d, min=%d, size=%d", x, width, minWidth, size);
		maxSize = MAX(size, maxSize);
	}
	return maxSize;
}

- (void)squareCountSetup {
    NSLog(@"Square count is 0: %ld", [self totalSquareCount:[NSArray new]]);
    NSLog(@"Square count is 1: %ld", [self totalSquareCount:@[@[@1]]]);
    NSLog(@"Square count is 2: %ld", [self totalSquareCount:@[@[@1, @1]]]);
    NSArray *matrix = @[@[@1, @0, @1],
                        @[@1, @1, @1],
                        @[@1, @1, @1]];
    NSLog(@"Square count is 8+2=10: %ld", [self totalSquareCount:matrix]);
    
    matrix = @[@[@1, @0, @1],
               @[@1, @1, @1],
               @[@1, @1, @0]];
    NSLog(@"Square count is 7+1=8: %ld", [self totalSquareCount:matrix]);

    matrix = @[@[@0, @0, @0],
               @[@0, @0, @0],
               @[@0, @0, @0]];
    NSLog(@"Square count is 0: %ld", [self totalSquareCount:matrix]);

    matrix = @[@[@1, @1, @1],
               @[@1, @1, @1],
               @[@1, @1, @1]];
    NSLog(@"Square count is 14: %ld", [self totalSquareCount:matrix]);
}

/*
 Count total number of squares in a matrix
 */
- (NSInteger)totalSquareCount:(NSArray<NSArray *>*)matrix {
    if (matrix.count == 0) {
        return 0;
    }
    [self copyArray:matrix];
    NSInteger total = 0;
    for (int row=0; row<matrix.count; row++) {
        for (int col=0; col<matrix[row].count; col++) {
            // For the first row and col, size of square is either 0 or 1 and can be added directly without counting
            if (row == 0 || col == 0) {
                total += [matrix[0][col] integerValue];
            }
            else {
                if ([matrix[row][col] isEqualTo:@1]) {
                    total += [self updateSquareCount:row col:col];
                }
            }
        }
    }
    return total;
}

- (void)largestSquareSetup {
	NSArray<NSArray *>*matrix = @[@[@1, @1, @0, @1, @0],
								  @[@0, @1, @1, @1, @0],
								  @[@1, @1, @1, @1, @0],
								  @[@0, @1, @1, @1, @1]];
	NSLog(@"Largest square is 9, received: %ld", [self largestSquare1:matrix]);
	NSLog(@"Largest square is 9, received: %ld", [self largestSquare2:matrix]);
}
/*
 Count the size of the largest square in a matrix
 0 1 1 0
 1 1 1 0
 1 0 1 1
 - Use a new matric to keep accumulated counts for each cell
 - For each cell except first row and col, lookup left, top left and top neighborhood cells
 - Pick the minimum number and add to current cell
 1 1 -> 1 1   0 1 -> 0 1
 1 1    1 2   1 1    1 1
 */
- (NSInteger)largestSquare1:(NSArray<NSArray *>*)matrix {
    if (matrix.count == 0) {
        return 0;
    }
    [self copyArray:matrix];
    NSInteger max = 0;
    for (int row=0; row<matrix.count; row++) {
        for (int col=0; col<matrix[row].count; col++) {
            if (row > 0 && col > 0) {
                if ([matrix[row][col] isEqualTo:@1]) {
                    max = MAX(max, [self updateSquareCount:row col:col]);
                }
            }
        }
    }
    return max*max;
}

// Helper method to update the square count
- (NSInteger)updateSquareCount:(NSInteger)row col:(NSInteger)col {
    NSInteger count = MIN([self.dp[row-1][col-1] integerValue],
                          MIN([self.dp[row-1][col] integerValue], [self.dp[row][col-1] integerValue]));
    count += [self.dp[row][col] integerValue];
    self.dp[row][col] = @(count);
    return count;
}

/*
 My original method for square count
 */
- (NSInteger)largestSquare2:(NSArray<NSArray *>*)matrix {
    if (matrix.count == 0) {
        return 0;
    }
    [self copyArray:matrix];
    NSInteger max = 0;
    for (int row=0; row<matrix.count; row++) {
        for (int col=0; col<matrix[row].count; col++) {
            if ([matrix[row][col] isEqualTo:@1]) {
                NSInteger count = [self countSquare2:matrix row:row col:col size:1 count:1];
                max = MAX(max, count*count);    // Square size = side^2
            }
        }
    }
    return max;
}

- (NSInteger)countSquare2:(NSArray<NSArray *>*)m row:(NSInteger)row col:(NSInteger)col size:(NSInteger)size count:(NSInteger)count {
    if (row+size >= m.count || col >= m[row+size].count) {
        return count;
    }
    for (NSInteger c=col; c<col+size; c++) {
        if ([m[row][c] isEqualTo:@0]) {
            return count;
        }
    }
    for (NSInteger r=row; r<row+size; r++) {
        if ([m[r][col] isEqualTo:@0]) {
            return count;
        }
    }
    return [self countSquare2:m row:row col:col size:size+1 count:count+1];
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
    for (int row = 0; row < map.count; row++) {
        for (int col = 0; col < map[row].count; col++) {
            NSString *location = [NSString stringWithFormat:@"%d,%d", row, col];
            if (![visited containsObject:location] && [map[row][col] isEqualToNumber:@1]) {
                [self traverseMapBFS:map visited:visited row:row col:col];
                count++;
            }
        }
    }
    return count;
}

- (void)traverseMapBFS:(NSArray<NSArray *> *)map visited:(NSMutableSet *)visited row:(int)row col:(int)col {
    NSArray *rowArray = @[@0, @0, @-1, @1];
    NSArray *colArray = @[@-1, @1, @0, @0];
    
    NSString *location = [NSString stringWithFormat:@"%d,%d", row, col];
    NSMutableArray *q = [NSMutableArray new];
    Cell *c = [[Cell alloc] initWithPosition:row col:col];
    [q addObject:c];
    [visited addObject:location];
    
    while (q.count > 0) {
        // dequeue a matrix location
        Cell *c = [q firstObject];
        [q removeObjectAtIndex:0];
        
        // Process all of it's adjacent cells
        for (int i=0; i<rowArray.count; i++) {
            int ro = c.row + [rowArray[i] intValue];
            int co = c.col + [colArray[i] intValue];
            NSString *location = [NSString stringWithFormat:@"%d,%d", ro, co];
            // Only need to process cells that are 1 and valid and not visited
            if ([self isValidCell:map row:ro col:co] && [map[ro][co] isEqualTo:@1] && ![visited containsObject:location]) {
                [visited addObject:location];
                Cell *c = [[Cell alloc] initWithPosition:ro col:co];
                [q addObject:c];
            }
        }
    }
    return;
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
    [self traverseMap:map visited:visited row:row-1 col:col];
    [self traverseMap:map visited:visited row:row col:col+1];
    [self traverseMap:map visited:visited row:row col:col-1];
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

/*
 Given a matrix with 0 = block, 1 = path, 9 = gold. You can move up, down, left, or right at each cell.
 Start from top-left corner, find out the minimum steps to find gold. Return -1 if it can't be reached.
 
 Algorithm:
 - Create a dict with x,y as key to store visited cell.
 - Use BFS to find the destination. The first destination found by BFS is always the shortest.
 - If want to find total number of paths to destination, just remove the visited cell at destination to allow reenter.
 - For each entry, increase count by 1.
 - Time complexity = O(m*n) since each cell is only visited once.
 */

- (void)minimumDistanceToFindGoldSetup {
    NSArray<NSArray *> *array = @[@[@1, @1, @0],
                                  @[@1, @1, @1],
                                  @[@1, @9, @1]];
    NSLog(@"Shortest path = 3, received: %ld", [self minimumDistanceToFindGold:array]);
    NSLog(@"Total path = 3, received: %ld", [self totalPathsToGold:array]);
}

- (NSInteger)totalPathsToGold:(NSArray<NSArray *> *)array {
    self.dpDict = [NSMutableDictionary new];
    return [self findPathsToGold:array row:0 col:0];
}

// Time complexity O(m*n), since each cell is only visited once.
// Use dp to save result (no. of paths) at a particular cell
- (NSInteger)findPathsToGold:(NSArray<NSArray *> *)array row:(NSInteger)row col:(NSInteger)col {
    // Cell out-of-bound or cell = 0 (can't get thru) return 0
    if (![self isValidCell:array row:row col:col] || [array[row][col] isEqualTo:@0]) {
        return 0;
    }
    // Found destination, return count as 1
    if ([array[row][col] isEqualTo:@9]) {
        return 1;
    }
    NSString *key = [NSString stringWithFormat:@"%ld,%ld", row, col];
    // Check if result of current cell already calculated previously
    if (self.dpDict[key]) {
        return [self.dpDict[key] integerValue];
    }
    self.dpDict[key] = @([self findPathsToGold:array row:row+1 col:col] + [self findPathsToGold:array row:row col:col+1]);
    return [self.dpDict[key] integerValue];
}

- (NSInteger)minimumDistanceToFindGold:(NSArray<NSArray *> *)array {
    NSMutableSet *visited = [NSMutableSet new];
    NSMutableArray *q = [NSMutableArray new];
    // Used to traverse top, bottom, left, right cells
    NSArray *row = @[@0, @0, @-1, @1];
    NSArray *col = @[@-1, @1, @0, @0];
    
    Cell *c1 = [Cell new];
    c1.row = 0;
    c1.col = 0;
    c1.dist = 0;
    NSString *key = @"0,0";
    [visited addObject:key];
    [q addObject:c1];
    while (q.count > 0) {
        Cell *c = [q firstObject];
        // If current cell is equal to "gold", return current cell distance (from source at 0,0)
        if ([array[c.row][c.col] isEqualTo:@9]) {
            return c.dist;
        }
        [q removeObjectAtIndex:0];
        
        // Go to each direction. If it's a valid location and not visited and not equal 0, add to q
        for (int i=0; i<4; i++) {
            int ro = c.row + [row[i] intValue];
            int co = c.col + [col[i] intValue];
            key = [NSString stringWithFormat:@"%d,%d", ro, co];
            if ([self isValidCell:array row:ro col:co] && ![array[ro][co] isEqualTo:@0] && ![visited containsObject:key]) {
                Cell *c2 = [Cell new];
                c2.row = ro;
                c2.col = co;
                c2.dist = c.dist + 1;
                [q addObject:c2];
                [visited addObject:key];
            }
        }
    }
    return -1;
}

- (BOOL)isValidCell:(NSArray<NSArray *> *)array row:(NSInteger)row col:(NSInteger)col {
    return (row>=0 && row<array.count && col>=0 && col<array[row].count);
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

- (void)connectedCellinGridSetup {
    NSArray *matrix = @[@1, @1, @0, @0, @0,
                        @0, @1, @1, @0, @1,
                        @0, @0, @1, @0, @1,
                        @1, @0, @0, @0, @1];
    //    NSLog(@"Largest size of connected cell in grid: %d", [self connectedCellinGrid:matrix row:4 col:5]);
}

- (NSUInteger)connectedComponents:(NSArray *)matrix {
    return 0;
}


- (void)pathInMatrixSetup {
	NSArray<NSArray *> *bitmap = @[@[@0,@0,@0],
								   @[@1,@0,@0],
								   @[@0,@0,@0]];
	[self copyArray:bitmap];
//	printf("Path in matrix: %s\n", [self pathInMatrix:self.dp row:0 col:0] ? "Yes" : "No");
	printf("Path in matrix: %s\n", [self pathInMatrixBFS:self.dp] ? "Yes" : "No");

	bitmap = @[@[@0,@0,@0],
			   @[@1,@1,@0],
			   @[@0,@0,@1]];
	[self copyArray:bitmap];
//	printf("Path in matrix: %s\n", [self pathInMatrix:self.dp row:0 col:0] ? "Yes" : "No");
	printf("Path in matrix: %s\n", [self pathInMatrixBFS:self.dp] ? "Yes" : "No");
	
	bitmap = @[@[@0,@1,@0,@0],
			   @[@0,@1,@0,@0],
			   @[@0,@0,@0,@0],
			   @[@0,@0,@1,@0]];
	[self copyArray:bitmap];
//	printf("Path in matrix: %s\n", [self pathInMatrix:self.dp row:0 col:0] ? "Yes" : "No");
	printf("Path in matrix: %s\n", [self pathInMatrixBFS:self.dp] ? "Yes" : "No");
}

- (BOOL)pathInMatrixBFS:(NSMutableArray<NSMutableArray *> *)bitmap {
	NSMutableArray *q = [NSMutableArray new];
	[q addObject:@[@0,@0]];
	while (q.count > 0) {
		NSArray *cell = q[0];
		[q removeObjectAtIndex:0];

		NSArray *rows = @[@1,@-1,@0,@0];
		NSArray *cols = @[@0,@0,@1,@-1];
		for (int i=0; i<4; i++) {
			int r = [cell[0] intValue]+[rows[i] intValue];
			int c = [cell[1] intValue]+[cols[i] intValue];
			
			if (r == bitmap.count-1 && c == bitmap[r].count-1 && [bitmap[r][c] isEqualToValue:@0]) {
				return YES;
			}
			if (r < bitmap.count && c < bitmap[r].count && [bitmap[r][c] isEqualToValue:@0]) {
				bitmap[r][c] = @1;
				[q addObject:@[@(r),@(c)]];
			}
		}
	}
	return NO;
}

- (BOOL)pathInMatrix:(NSMutableArray<NSMutableArray *> *)bitmap row:(int)row col:(int)col {
	if (row >= bitmap.count || col >= bitmap[row].count || [bitmap[row][col] isEqualToValue:@1]) {
		return NO;
	}
	if (row == bitmap.count-1 && col == bitmap[row].count-1 && [bitmap[row][col] isEqualToValue:@0]) {
		return YES;
	}
	bitmap[row][col] = @1;
	NSArray *rows = @[@1,@-1,@0,@0];
	NSArray *cols = @[@0,@0,@1,@-1];
	for (int i=0; i<4; i++) {
		int r = row+[rows[i] intValue];
		int c = col+[cols[i] intValue];
		if ([self pathInMatrix:self.dp row:r col:c]) {
			return YES;
		}
	}
	return NO;
}


- (void)totalNumbersOfuniquePathsSetup {
    int rowSize = 3;
    int colSize = 2;
//    NSLog(@"Unique paths=3: %d", [self uniquePaths:rowSize n:colSize]);
//    rowSize = 7;
//    colSize = 3;
//    NSLog(@"Unique paths=28: %d", [self uniquePaths:rowSize n:colSize]);
}


/*
 Given a rectangle matrix with size n*m, find the longest sequence inside.
 2 3 9 10
 1 7 8 11
 5 4 6 12
 [1,2,3], [4,5], [6], [7,8,9,10,11,12] -> longest sequence count = 6
 */

- (void)longestSequenceSumSetup {
    NSArray<NSArray *> *matrix = @[@[@2, @3, @9, @10],
                                   @[@1, @7, @8, @11],
                                   @[@5, @4, @6, @12]];
    NSLog(@"Longest sequence:6, received: %d", [self longestSequenceInMatric:matrix]);
}

- (int)longestSequenceInMatric:(NSArray<NSArray *> *)matrix {
    self.dpDict = [NSMutableDictionary new];
    int max = 0;
    for (int row=0; row<matrix.count; row++) {
        for (int col=0; col<matrix[row].count; col++) {
            NSString *key = [NSString stringWithFormat:@"%d,%d", row, col];
            if (!self.dpDict[key]) {
                [self findSequence:matrix row:row col:col];
            }
        }
    }
    for (NSNumber *n in self.dpDict.allValues) {
        max = MAX(max, [n intValue]);
    }
    return max;
}

- (void)findSequence:(NSArray<NSArray *> *)matrix row:(int)row col:(int)col {
    NSArray *rowArray = @[@0, @0, @-1, @1];
    NSArray *colArray = @[@-1, @1, @0, @0];
    NSMutableArray *q = [NSMutableArray new];
    Cell *curr = [[Cell alloc] initWithPosition:row col:col];
    [q addObject:curr];
    int count = 1;
    
    while (q.count > 0) {
        Cell *c = [q firstObject];
        [q removeObjectAtIndex:0];
        
        // Go to each direction. If it's a valid location and not visited and not equal 0, add to q
        int next = [matrix[c.row][c.col] intValue] + 1;
        for (int i=0; i<4; i++) {
            int ro = c.row + [rowArray[i] intValue];
            int co = c.col + [colArray[i] intValue];

            // Find the cell that contains the next sequence
            if ([self isValidCell:matrix row:ro col:co] && [matrix[ro][co] isEqualTo:@(next)]) {
                NSString *key = [NSString stringWithFormat:@"%d,%d", ro, co];
                // If the length of this cell has calculated before, just need to merge with current result and no need to continue
                if (self.dpDict[key]) {
                    int previousCount = [self.dpDict[key] intValue];
                    key = [NSString stringWithFormat:@"%d,%d", row, col];
                    self.dpDict[key] = @(count + previousCount);
//                    NSLog(@"m:%d,%d: %d", row, col, count+previousCount);
                    return;
                }
                Cell *c2 = [Cell new];
                c2.row = ro;
                c2.col = co;
                [q addObject:c2];
                self.dpDict[key] = @(count++);
            }
        }
    }
//    NSLog(@"c:%d,%d: %d", curr.row, curr.col, count);
    NSString *key = [NSString stringWithFormat:@"%d,%d", row, col];
    self.dpDict[key] = @(count);
    return;
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
//    NSString *word = @"a";
//    NSLog(@"isWordExist: %@ %hhd", word, [self isWordExist:board word:word]);
//    word = @"abcced";
//    NSLog(@"isWordExist: %@ %hhd", word, [self isWordExist:board word:word]);
//    word = @"see";
//    NSLog(@"isWordExist: %@ %hhd", word, [self isWordExist:board word:word]);
//    word = @"abcb";
//    NSLog(@"isWordExist: %@ %hhd", word, [self isWordExist:board word:word]);
//    NSLog(@"isWordExist: %hhd", [self isWordExist:board word:@""]);
}

@end
