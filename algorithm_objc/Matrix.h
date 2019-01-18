//
//  Matrix.h
//  algorithm_objc
//
//  Created by Stephen Ling on 2/23/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Matrix : NSObject

/*
 For path searching in a matrix, it's best to come up with a formula and then code it
 For example, give a matrix, find the largest sum of path from start to finish
 
 S 2 3
 4 5 1
 7 2 2(end)
 
 At any given point, p[i][j] = p[i]p[j] + max{p[i-1]p[j], p[i]p[j-1]}
 */

- (void)setup;
- (NSUInteger)numberOfObjectsInBitmap:(NSMutableArray *)bitmap width:(NSUInteger)width height:(NSUInteger)height;
- (NSUInteger)numberOfSquare:(NSUInteger)n;
- (void)pathInMatrixSetup;

@end
