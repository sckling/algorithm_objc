//
//  Interval.m
//  algorithm_objc
//
//  Created by Stephen Ling on 12/14/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import "Interval.h"

@interface Interval()
@property (nonatomic, strong) NSMutableArray *intervals;
@end

@implementation Interval

- (void)setup {
    [self addInterval:1 end:3];
    printf("%ld\n", self.totalIntervals);
}

/*
 Method to add interval and calculate total interval
 Add  (1,3) -> 3-1=2
 Add (6,10) -> (1,2) (6,10) -> 2+4=6
 Add  (2,4) -> (1,4) (6,10) -> 3+4=7
 Add  (5,8) -> (1,4) (5,10) -> 3+5=8
 Add (0,15) -> (0,15) -> 15
 
 Approach 1: brute force to traverse the array and enter the start and end
 
 2,4 -> 1,3  6,10
 
 Compare start to current start and end
 - if both start and end smaller than current start, insert pair and increment total by (end-start)
 - if both start and end are withing the current start and end, do nothing and return
 - if start is smaller and end is within current start and end, replace with new start and increment total by (current start - start)
 - if start is smaller and end is larger than current end, replace with new start and search for next element where start or end is bigger than this end and increment total by (old start-new start) + (end - new end)
 - if start is within current start and end and end is larger than current end, search for next element where start or end is bigger than this end and increment total by (end - new end)
 - Reaches the end of the array, add it to the end of array and increment total by (end-start)
 
 */
- (void)addInterval:(NSInteger)start end:(NSInteger)end {
    
}

// Approach 1: Traverse the array and calculate the total intervals
- (NSInteger)totalInterval {
    return _totalIntervals;
}

@end
