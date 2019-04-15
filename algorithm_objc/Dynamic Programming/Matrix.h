//
//  Matrix.h
//  algorithm_objc
//
//  Created by Stephen Ling on 2/23/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cell : NSObject
@property int row;
@property int col;
@property int dist;
- (instancetype)initWithPosition:(int)row col:(int)col;
- (instancetype)initWithPosition:(int)row col:(int)col distance:(int)dist;
@end

@interface Matrix : NSObject

/*
 For path searching in a matrix, it's best to come up with a formula and then code it
 For example, give a matrix, find the largest sum of path from start to finish
 
 S 2 3
 4 5 1
 7 2 2(end)
 
 At any given point, p[i][j] = p[i]p[j] + max{p[i-1]p[j], p[i]p[j-1]}
 */
/*
 Must practice matrix questions:
 - Find if there's a path from point A to point B
 - Find the total count of path or print all the paths from top left to bottom right
 - Count the total number of islands in a bitmap
 - Find the largest square/rectangle in a bitmap
 - Count the total number of squares/rectangles in a bitmap
 */

- (void)setup;
//- (NSUInteger)numberOfObjectsInBitmap:(NSMutableArray *)bitmap width:(NSUInteger)width height:(NSUInteger)height;
- (NSUInteger)numberOfSquare:(NSUInteger)n;

@end
