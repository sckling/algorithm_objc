//
//  NTree.h
//  algorithm_objc
//
//  Created by ling, stephen on 3/9/19.
//  Copyright © 2019 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTree : NSObject

@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSMutableArray<NTree *> *nodes;

- (instancetype)initWithValue:(NSString *)value;

@end
