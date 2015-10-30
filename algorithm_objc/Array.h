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
- (void)executeBlock:(NSString * (^)(int a, float b))myBlock;
@property (copy) NSString * (^myBlock)(int, float);

@end
