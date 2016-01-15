//
//  NSDictionary+Methods.m
//  algorithm_objc
//
//  Created by Stephen Ling on 1/14/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import "NSDictionary+Methods.h"

@implementation NSDictionary (Methods)

- (NSDictionary *)mergeDictionary:(NSDictionary *)dict {
    for (NSString *key in dict) {
        if ([self objectForKey:key]) {
            // Found matched key
            // Case 1: dict1 and dict2 values are both dictionary. Need to 
            id value = [dict objectForKey:key];
            [self mergeData:key value:value];
            NSLog(@"Key: %@, Value: %@", key, value);
        }
    }
    return nil;
}

- (void)mergeData:(NSString *)key value:(id)value {
    if ([value isKindOfClass:[NSDictionary class]]) {
        if ([self objectForKey:key]) {
            
        }
    }
    // Reach the bottom of the dictionary
    else {
        
    }
}

@end
