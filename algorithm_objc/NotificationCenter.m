//
//  NotificationCenter.m
//  algorithm_objc
//
//  Created by ling, stephen on 12/7/18.
//  Copyright © 2018 sling. All rights reserved.
//

#import "NotificationCenter.h"

@interface NotificationCenter()
@property(nonatomic, strong) NSMutableDictionary *observers;
@end

@implementation NotificationCenter

+ (instancetype)defaultCenter {
    static NotificationCenter *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _observers = [NSMutableDictionary new];
    }
    return self;
}

- (void)addObserver:(id)observer selector:(SEL)selector name:(NSString *)name {
    if (self.observers[name]) {
        
    }
}

- (void)removeObserver:(id)observer name:(NSString *)name {
    
}

- (void)postNotification:(NSNotification *)notification {
    
}

@end
