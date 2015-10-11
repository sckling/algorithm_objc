//
//  TreeNodeTests.m
//  algorithm_objc
//
//  Created by Stephen Ling on 10/10/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TreeNode.h"

@interface TreeNodeTests : XCTestCase

@end

@implementation TreeNodeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    TreeNode *node = [[TreeNode alloc] init];
    NSInteger result = [node addNums:1 num2:2];
    XCTAssertEqual(result, 3, @"Fail Addition");
}


@end
