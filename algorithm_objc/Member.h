//
//  Member.h
//  algorithm_objc
//
//  Created by Stephen Ling on 11/9/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSArray *friends;
@property (nonatomic, assign) NSUInteger memberId;

- (instancetype)initWithName:(NSString *)name memberId:(NSUInteger)memberId;
- (instancetype)initWithName:(NSString *)name memberId:(NSUInteger)memberId friends:(NSArray *)friends;

@end
