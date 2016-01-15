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
    NSDictionary *dict1 = @{@"John": @{@"age": @18}, @"Ivy": @{@"age": @28}};
    NSDictionary *dict2 = @{@"John": @{@"ssn": @1234, @"sex": @"M"}, @"Betty": @{@"sex": @"F"}};
    NSDictionary *dict3 = [self mergeDictionary:dict1 dictionary:dict2];
    NSLog(@"Merged dict: %@", dict3);
}

- (NSDictionary *)mergeDictionary:(NSDictionary *)dict1 dictionary:(NSDictionary *)dict2 {
    NSMutableDictionary *d1copy = [dict1 mutableCopy];
    NSMutableDictionary *d2copy = [dict2 mutableCopy];
    for (NSString *key in d1copy) {
        if ([d2copy objectForKey:key]) {
            if ([d1copy[key] isKindOfClass:[NSDictionary class]] && [d2copy[key] isKindOfClass:[NSDictionary class]]) {
                d2copy[key] = [self mergeDictionary:d1copy[key] dictionary:d2copy[key]];
            }
        }
    }
    [d1copy addEntriesFromDictionary:d2copy];
    dict1 = d1copy;
    return dict1;
}

@end
