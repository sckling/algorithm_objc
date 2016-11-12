//
//  SocialGraph.h
//  algorithm_objc
//
//  Created by Stephen Ling on 11/10/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Member.h"

@interface SocialGraph : NSObject

- (NSArray *)getRankedCourses:(NSString *)user;
- (void)printSocialGraphSetup;
- (void)printSocialGraphByLevel:(Member *)member level:(NSUInteger)level;

@end
