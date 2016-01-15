//
//  ArrayTests.m
//  algorithm_objc
//
//  Created by Stephen Ling on 12/19/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Array.h"
#import "NSArray+Methods.h"

@interface ArrayTests : XCTestCase

@end

@implementation ArrayTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testStickerCount {
    NSUInteger count = 0;

    // Given case: sticker count = 4 since there are 4 e's and it can construct 4 "apple" stickers
    NSArray *words = @[@"ape", @"peel", @"pale"];
    count = [words stickerCount];
    XCTAssertEqual(count, 4);

    // Case 2: Count = 2: appl+e, pp
    NSArray *words2 = @[@"appl", @"pp", @"e"];
    count = [words2 stickerCount];
    XCTAssertEqual(count, 2);
    
    // Case 3: Count = 1: apple
    NSArray *words3 = @[@"apple"];
    count = [words3 stickerCount];
    XCTAssertEqual(count, 1);
    
    // Case 4: Count = 2: apple, p
    NSArray *words4 = @[@"appple"];
    count = [words4 stickerCount];
    XCTAssertEqual(count, 2);
    
    // Case 5: Count = 0 for empty array
    NSArray *words5 = [NSArray new];
    count = [words5 stickerCount];
    XCTAssertEqual(count, 0);
}

@end
