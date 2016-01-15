//
//  Dictionary.m
//  algorithm_objc
//
//  Created by Stephen Ling on 1/14/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import "Dictionary.h"
#import "NSDictionary+Methods.h"

@implementation Dictionary

- (void)setup {
    NSDictionary *dict1 = @{@"a": @1, @"b": @{@"b": @2}};
    NSDictionary *dict2 = @{@"a": @3, @"c": @4};
    NSDictionary *dict3 = [dict1 mergeDictionary:dict2];
    NSLog(@"Merged dict: %@", dict3);
}

@end
