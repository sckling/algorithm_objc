//
//  Interval.h
//  algorithm_objc
//
//  Created by Stephen Ling on 12/14/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Interval : NSObject

@property (nonatomic, assign) NSInteger totalIntervals;

- (void)setup;
- (void)addInterval:(NSInteger)start end:(NSInteger)end;

@end
