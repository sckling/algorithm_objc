//
//  main.m
//  algorithm_objc
//
//  Created by Stephen Ling on 10/10/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"Hello, World!");
        TreeNode *node = [[TreeNode alloc] init];
        NSLog(@"Addition: %ld", [node addNums:1 num2:2]);
    }
    return 0;
}
