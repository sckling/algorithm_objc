//
//  Recursion.h
//  algorithm_objc
//
//  Created by Stephen Ling on 4/14/16.
//  Copyright © 2016 sling. All rights reserved.
//

/*
 Step to solve recursion problem.
 1. Define the base case and return value (usually 0 or null, as the previous caller should already handle it)
 2. Define various conditions and call recursively with updated parameters
 3. If needed, compare/combine all the results from various conditions
 4. Return the updated result
 
 Runtime is O(2^n)
 */

#import <Foundation/Foundation.h>

@interface Recursion : NSObject

- (void)setup;

@end
