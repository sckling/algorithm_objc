//
//  Vertex.m
//  algorithm_objc
//
//  Created by Stephen Ling on 10/26/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import "Vertex.h"

@implementation Vertex

- (instancetype)initWithName:(NSString *)name dest:(NSUInteger)dest {
    self = [super init];
    if (self != nil) {
        _name = name;
        _dest = dest;
    }
    return self;
}

@end
