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
//    NSArray *keys = [dict allKeys];
    for (NSString *key in dict) {
        id value = [dict objectForKey:key];
        [self mergeData:key value:value];
        NSLog(@"Key: %@, Value: %@", key, value);
    }
    return nil;
}

- (void)mergeData:(NSString *)key value:(id)value {
    if ([value isKindOfClass:[NSNumber class]]) {
        if ([self objectForKey:key]) {
            
        }
    }
}

@end
