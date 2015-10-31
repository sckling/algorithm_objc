//
//  Array.m
//  algorithm_objc
//
//  Created by Stephen Ling on 10/11/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import "Array.h"
#import "NSArray+Methods.h"

@interface Array()
@property (assign) NSUInteger enumeratorIdx;
@property (nonatomic, strong) NSMutableArray *enumeratorArray;
@end


@implementation Array

- (void)setup {
    // max subarray = 4, -1, 2, 1 = 6
    NSArray *array1 = @[@-2, @1, @-3, @4, @-1, @2, @1, @-5, @4];
    [self passArrayByReference:&array1];
    NSLog(@"New array after pass by reference: %@", array1);
    
    NSLog(@"Maximum sub-array sum: %ld", [array1 maximumSubArraySum]);
    
    NSArray *array2 = @[@2, @7, @2, @-2, @5, @-7];
    [array2 findPairsOfElementsEqualToSum:7];
    NSArray *array3 = @[@2, @4, @7, @10];
    NSInteger number = 10;
    NSLog(@"Binary search of %ld found: %ld", (long)number, (long)[array3 binarySearch:0 end:array3.count-1 number:number]);
    
    NSArray *array4 = @[@"b", @"d", @"g", @"k"];
    NSLog(@"Binary search %@ found: %lu", @"b", (unsigned long)[array4 binarySearch:0 end:array4.count-1 character:@"z"]);
    
    NSArray *array5 = @[@3, @0, @-1, @4, @5, @0, @2, @0];
    [array5 sortArrayZeros:[array5 mutableCopy]];
    
    self.enumeratorIdx = 0;
    self.enumeratorArray = [NSMutableArray arrayWithArray:@[@"a", @"b", @[@"c", @[@"d"]], @"e"]];
    self.enumeratorArray = [self.enumeratorArray mutableCopy];
}

// NSEnumerator
- (id)nextObject {
    if (self.enumeratorIdx < self.enumeratorArray.count) {
        id obj = self.enumeratorArray[self.enumeratorIdx];
        if ([obj isKindOfClass:[NSString class]]) {
            self.enumeratorIdx++;
            return obj;
        }
        return [self popFirstElement:obj];
    }
    return nil;
}

- (id)popFirstElement:(NSArray *)array {
    id obj = array[0];
    if ([obj isKindOfClass:[NSString class]]) {
        self.enumeratorIdx++;
        return obj;
    }
    return [self popFirstElement:obj];
}

- (void)passArrayByReference:(NSArray **)array {
    NSLog(@"Original array: %@", *array);
    NSArray *newArray = @[@1, @2, @3];
    *array = newArray;
}

- (void)executeBlock:(NSString *(^)(int, float))myBlock {
    int a = 10;
    float b = 20;
    // myBlock function already defined, calling it to execute
    NSString *result = myBlock(a, b);
    NSLog(@"Result: %@", result);
    
    // Define newBlock
    NSString *(^newBlock)(int, float) = ^NSString *(int a, float b) {
        return @"something";
    };
    
    // execute new block
    result = newBlock(a, b);
    NSLog(@"Result: %@", result);
    
    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = [NSURLResponse new];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSLog(@"data: %@\nresponse: %@", data, response);
    //NSLog(@"Data: %@, Response: %@, Error: %@", data1,  response, error);
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"Response: %@, Data: %@, Error: %@", response, data, connectionError);
    }];
}

@end
