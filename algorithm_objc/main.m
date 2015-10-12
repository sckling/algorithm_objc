//
//  main.m
//  algorithm_objc
//
//  Created by Stephen Ling on 10/10/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Array.h"
#import "Tree.h"
#import "NSArray+Methods.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Array *array = [[Array alloc] init];
        [array setup];
        
        Tree *binarySearchTree = [[Tree alloc] init];
        [binarySearchTree setup];
    }
    return 0;
}
