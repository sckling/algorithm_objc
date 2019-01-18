//
//  NotificationCenter.h
//  algorithm_objc
//
//  Created by ling, stephen on 12/7/18.
//  Copyright © 2018 sling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationCenter : NSObject

+ (instancetype)defaultCenter;

- (void)addObserver:(id)observer selector:(SEL)selector name:(NSString *)name;

- (void)removeObserver:(id)observer name:(NSString *)name;

- (void)postNotification:(NSNotification *)notification;

@end
