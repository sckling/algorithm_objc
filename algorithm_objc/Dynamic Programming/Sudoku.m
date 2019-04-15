//
//  Sudoku.m
//  algorithm_objc
//
//  Created by ling, stephen on 4/2/19.
//  Copyright © 2019 sling. All rights reserved.
//

#import "Sudoku.h"

@interface Sudoku ()
@property (nonatomic, strong) NSMutableArray<NSMutableArray<NSNumber *> *> *board;
@end

@implementation Sudoku

//- (instancetype)init {
//	self = [super self];
//	if (self) {
//		_board = [[NSMutableArray alloc] initWithCapacity:10];
//		for (int x=0; x<9; x++) {
//			_board[x] = [[NSMutableArray alloc] initWithCapacity:10];
//			for (int y=0; y<9; y++) {
//				_board[x][y] = @0;
//			}
//		}
//	}
//	return self;
//}

- (void)setBoard:(NSMutableArray<NSMutableArray<NSNumber *> *> *)board {
	if (!_board) {
		_board = [[NSMutableArray alloc] initWithCapacity:10];
	}
	for (int x=0; x<9; x++) {
		_board[x] =	[[NSMutableArray alloc] initWithCapacity:10];
		for (int y=0; y<9; y++) {
			self.board[x][y] = board[x][y];
		}
	}
}

- (void)setup {
	/*
	 Solution:
	 3 1 6 5 7 8 4 9 2
	 5 2 9 1 3 4 7 6 8
	 4 8 7 6 2 9 5 3 1
	 2 6 3 4 1 5 9 8 7
	 9 7 4 8 6 3 1 2 5
	 8 5 1 7 9 2 6 4 3
	 1 3 8 9 4 7 2 5 6
	 6 9 2 3 5 1 8 7 4
	 7 4 5 2 8 6 3 1 9
	 */
	NSArray *board = @[@[@3, @0, @6, @5, @0, @8, @4, @0, @0],
					   @[@5, @2, @0, @0, @0, @0, @0, @0, @0],
					   @[@0, @8, @7, @0, @0, @0, @0, @3, @1],
					   @[@0, @0, @3, @0, @1, @0, @0, @8, @0],
					   @[@9, @0, @0, @8, @6, @3, @0, @0, @5],
					   @[@0, @5, @0, @0, @9, @0, @6, @0, @0],
					   @[@1, @3, @0, @0, @0, @0, @2, @5, @0],
					   @[@0, @0, @0, @0, @0, @0, @0, @7, @4],
					   @[@0, @0, @5, @2, @0, @6, @3, @0, @0]];
	self.board = [board mutableCopy];
}

- (BOOL)solveSudoku {
	/*
	 Use backtracking, for each empty cell, fill in a number and check if it's a valid partial solution
	 If not valid, try another number
	 If valid, update the board and make a recursive call to solve the next step
	 If all the future solutions work, problem solved
	 If return false from next solutions, remove current solution and try next one
	 If no more empty cell, indicate process is complete and return yes
	 */
	NSArray *cell = [self findEmptyCell];
	if (!cell) {
		return YES;
	}
	int x = [cell[0] intValue];
	int y = [cell[1] intValue];

	for (int i=1; i<=9; i++) {
		if ([self isValidPartialSolution:x y:y num:@(i)]) {
			self.board[x][y] = @(i);
			if ([self solveSudoku]) {
				return YES;
			}
			self.board[x][y] = @0;
		}
	}
	return NO;
}

- (NSArray *)findEmptyCell {
	for (int x=0; x<9; x++) {
		for (int y=0; y<9; y++) {
			if ([self.board[x][y] isLessThanOrEqualTo:@0] || !self.board[x][y]) {
				return @[@(x), @(y)];
			}
		}
	}
	return nil;
}

- (BOOL)isValidPartialSolution:(int)x y:(int)y num:(NSNumber *)n {
	return ([self validRow:x num:n] && [self validCol:y num:n] && [self validBox:x-x%3 col:y-y%3 num:n]);
}

- (BOOL)validRow:(int)row num:(NSNumber *)n {
	for (int col=0; col<9; col++) {
		if ([self.board[row][col] isEqualToNumber:n]) {
			return NO;
		}
	}
	return YES;
}

- (BOOL)validCol:(int)col num:(NSNumber *)n {
	for (int row=0; row<9; row++) {
		if ([self.board[row][col] isEqualToNumber:n]) {
			return NO;
		}
	}
	return YES;
}

- (BOOL)validBox:(int)startX col:(int)startY num:(NSNumber *)n {
	for (int row=startX; row<startX+3; row++) {
		for (int col=startY; col<startY+3; col++) {
			if ([self.board[row][col] isEqualToNumber:n]) {
				return NO;
			}
		}
	}
	return YES;
}

- (BOOL)isBoardFilled {
	for (int x=0; x<9; x++) {
		for (int y=0; y<9; y++) {
			if ([self.board[x][y] isLessThanOrEqualTo:@0] || !self.board[x][y]) {
				return NO;
			}
		}
	}
	return YES;
}

- (void)printBoard {
	for (int x=0; x<9; x++) {
		for (int y=0; y<9; y++) {
			printf("%d ", [self.board[x][y] intValue]);
			if (y == 2 || y == 5) {
				printf("| ");
			}
		}
		if (x == 2 || x == 5) {
			printf("\n---------------------");
		}
		printf("\n");
	}
	printf("\n");
}

@end
