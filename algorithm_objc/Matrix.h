//
//  Matrix.h
//  algorithm_objc
//
//  Created by Stephen Ling on 2/23/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Matrix : NSObject

- (void)setup;
- (NSUInteger)numberOfObjectsInBitmap:(NSMutableArray *)bitmap width:(NSUInteger)width height:(NSUInteger)height;
- (NSUInteger)numberOfSquare:(NSUInteger)n;
- (void)pathInMatrixSetup;

@end
