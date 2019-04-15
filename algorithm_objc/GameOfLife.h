//
//  GameOfLife.h
//  algorithm_objc
//
//  Created by ling, stephen on 3/24/19.
//  Copyright © 2019 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameOfLife : NSObject

- (instancetype)initWithSize:(NSInteger)size;
- (void)printBoard;
- (void)start:(NSInteger)cycles;

@end

NS_ASSUME_NONNULL_END
