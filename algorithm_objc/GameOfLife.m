//
//  GameOfLife.m
//  algorithm_objc
//
//  Created by ling, stephen on 3/24/19.
//  Copyright © 2019 sling. All rights reserved.
//

#import "GameOfLife.h"

@interface GameOfLife ()
@property(nonatomic, copy) NSMutableArray<NSMutableArray *> *board;
@end

@implementation GameOfLife

/*
 Should create a Board class with the following properties:
 - Use arrays to hold the board
 - (id)initWithSize:(int)size
 - (int)size;
 - (void)print;
 - (BOOL)isValidCell:(int)row col:(int)col;
 - (NSString *)cell:(int)row col:(int)col;
 - (BOOL)updateCellAt:(int)row col:(int)col;
 */

- (instancetype)initWithSize:(NSInteger)size {
	self = [super self];
	if (self) {
		[self initBoard:size];
	}
	return self;
}

- (void)start:(NSInteger)cycles {
	for (int i=0; i<cycles; i++) {
		system("clear");
		[self printBoard];
		[self next];
		usleep(100);
	}
}

- (void)next {
	for (int row=0; row<self.board.count; row++) {
		for (int col=0; col<self.board[row].count; col++) {
			// The cells are changing one at a time and may not be desirable
			// Consider to use dict to store all the changes and update the board once complete calculation
			self.board[row][col] = [self checkNeighbors:row col:col];
		}
	}
}

- (NSString *)checkNeighbors:(int)row col:(int)col {
	int live = 0;
	NSArray *rows = @[@-1, @-1, @-1,  @0, @0,  @1, @1, @1];
	NSArray *cols = @[@-1,  @0,  @1, @-1, @1, @-1, @0, @1];
	for (int x=0; x<rows.count; x++) {
		int r = row + [rows[x] intValue];
		int c = col + [cols[x] intValue];
		if ([self isValidCell:r col:c] && [self.board[r][c] isEqualToString:@"*"]) {
			live++;
		}
	}
	/*
	 If a cell is ON and has fewer than two neighbors that are ON, it turns OFF
	 If a cell is ON and has either two or three neighbors that are ON, it remains ON.
	 If a cell is ON and has more than three neighbors that are ON, it turns OFF.
	 If a cell is OFF and has exactly three neighbors that are ON, it turns ON.
	 */
	if ([self.board[row][col] isEqualToString:@"*"] && (live < 2 || live > 3)) {
		return @".";
	}
	else if ([self.board[row][col] isEqualToString:@"."] && live ==3) {
		return @"*";
	}
	return self.board[row][col];
}

- (BOOL)isValidCell:(int)row col:(int)col {
	if (row >= 0 && row < self.board.count && col >= 0 && col < self.board[row].count) {
		return true;
	}
	return false;
}

- (void)initBoard:(NSInteger)size {
	_board = [NSMutableArray new];
	for (int row=0; row<size; row++) {
		_board[row] = [NSMutableArray new];
		for (int col=0; col<size; col++) {
			int cell = arc4random_uniform(2);
			if (cell == 0) {
				_board[row][col] = @" ";
			}
			else if (cell == 1) {
				_board[row][col] = @".";
			}
//			else {
//				_board[row][col] = @".";
//			}
		}
	}
	_board[0][3] = @"*";
	_board[0][4] = @".";
	_board[1][3] = @"*";
	_board[1][4] = @"*";
	_board[2][4] = @"*";
}

- (void)printBoard {
	for (int row=0; row<self.board.count; row++) {
		for (int col=0; col<self.board[row].count; col++) {
			printf("%s", [self.board[row][col] UTF8String]);
		}
		printf("\n");
	}
	printf("\n");
}

@end
