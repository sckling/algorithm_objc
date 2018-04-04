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
    // Case 1: Intersect a range
    [self NSRangeIntersection:NSMakeRange(2, 8) range:NSMakeRange(4, 10)];
    // Case 2: Intersect a point
    [self NSRangeIntersection:NSMakeRange(2, 3) range:NSMakeRange(4, 10)];
    // Case 3: Range1 covers the entire range2
    [self NSRangeIntersection:NSMakeRange(2, 10) range:NSMakeRange(3, 5)];
    // Case 4: No intersection
    [self NSRangeIntersection:NSMakeRange(2, 2) range:NSMakeRange(4, 10)];
}

- (Boolean)isRangesIntersected:(NSRange)range1 range:(NSRange)range2 {
    
    return NO;
}

- (void)NSRangeIntersection:(NSRange)range1 range:(NSRange)range2 {
    NSLog(@"a: %@", NSStringFromRange(NSIntersectionRange(range1, range2)));
    NSRange intersection = NSMakeRange(0, 0);

    // Sort out the range by location
    NSRange firstRange = range1.location < range2.location ? range1 : range2;
    NSRange lastRange = range1.location >= range2.location ? range1 : range2;
    
    // Check if there's an intersection by checking the absolute length of range1 > range2.location
    if ((firstRange.location + firstRange.length) > lastRange.location) {
        intersection.location = lastRange.location; // Use the last range location as the intersection location
        NSInteger firstLength = firstRange.location+firstRange.length;
        NSInteger lastLength =  (lastRange.location+lastRange.length);
        
        // Find out the absolute length of first and last range
        // If first < last => indicates intersection ends at first range, range is from last location to first length
        // If first > last => indicates intersection ends at last range, length = last length
        // Case 1: (2,8) (4,10) = (4,6) => length1=10, lenght2=14, length1<length2, length = length1-4=6
        // Case 2: (2,10) (3,5) = length1=12, lenght2=8,length1>lenght2 length = lenght2
        intersection.length =  firstLength < lastLength ? firstLength - lastRange.location : lastRange.length;
    }
    NSLog(@"b: %@", NSStringFromRange(intersection));
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
