//
//  Member.h
//  algorithm_objc
//
//  Created by Stephen Ling on 11/9/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (assign) NSUInteger memberId;
@property (nonatomic, strong) NSArray *friends;

@end
