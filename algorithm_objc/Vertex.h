//
//  Vertex.h
//  algorithm_objc
//
//  Created by Stephen Ling on 10/26/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vertex : NSObject

@property (assign) NSUInteger dest;
@property (assign) NSUInteger index;
@property (nonatomic, strong) NSString *name;

- (instancetype)initWithName:(NSString *)name dest:(NSUInteger)dest;

@end
