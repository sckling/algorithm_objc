//
//  EdgeNode.h
//  algorithm_objc
//
//  Created by Stephen Ling on 10/16/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EdgeNode : NSObject

@property (assign) NSUInteger dest;
@property (assign) NSInteger weight;
@property (nonatomic, strong) EdgeNode *next;

@end
