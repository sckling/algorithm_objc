//
//  Array.h
//  algorithm_objc
//
//  Created by Stephen Ling on 10/11/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Array : NSEnumerator

- (void)setup;
- (double)rollingMedian:(NSNumber *)number;

@end
