//
//  Sudoku.h
//  algorithm_objc
//
//  Created by ling, stephen on 4/2/19.
//  Copyright © 2019 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Sudoku : NSObject

- (void)setup;
- (BOOL)solveSudoku;
- (void)printBoard;

@end

NS_ASSUME_NONNULL_END
