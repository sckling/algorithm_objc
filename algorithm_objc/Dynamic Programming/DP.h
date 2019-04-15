//
//  DP.h
//  algorithm_objc
//
//  Created by ling, stephen on 1/21/19.
//  Copyright © 2019 sling. All rights reserved.
//

/*
 How to solve dp problems:
 1. Break down into repeatable subproblems
 2. Define base cases
 3. Define general cases
 4. Merge results from subproblem and memorize it
 5. Return the result
 6. Careful not to modify the array because too much overhead to re-create arrays.    Pass index instead
 O(unique problems * merges)
 
 */

#import <Foundation/Foundation.h>

@interface DP : NSObject

- (void)setup;

@end
