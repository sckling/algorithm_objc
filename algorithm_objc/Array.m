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
@property (nonatomic, strong) NSMutableArray *s1;
@property (nonatomic, copy) NSMutableArray *s2;
@property (assign) NSUInteger enumeratorIdx;
@property (nonatomic, strong) NSMutableArray *enumeratorArray;
@end

@implementation Array

- (void)setup {
    // max subarray = 4, -1, 2, 1 = 6
//    NSArray *array1 = @[@-2, @1, @-3, @4, @-1, @2, @1, @-5, @4];
//    [self passArrayByReference:&array1];
//    NSLog(@"New array after pass by reference: %@", array1);
//    
//    NSLog(@"Maximum sub-array sum: %ld", [array1 maximumSubArraySum]);
//    
//    NSArray *array2 = @[@2, @7, @2, @-2, @5, @-7];
//    [array2 findPairsOfElementsEqualToSum:7];

//    NSArray *array1 = @[@3, @1, @2, @5, @6, @4];
//    NSLog(@"Product array: %@", [self getProductsOfAllIntsExceptAtIndex:array1]);
//    NSLog(@"Product array: %@", [self buildAtIndex:array1]);
    
    NSArray *array2 = @[@3, @1, @2, @4, @5];
    NSLog(@"Highest product of 3 numbers in array: %ld", (long)[self maxProductOfThreeNumbers:array2]);
    
        array2 = @[@1, @10, @-5, @1, @-100];
    NSLog(@"Highest product of 3 numbers in array: %ld", (long)[self maxProductOfThreeNumbers:array2]);
    
    NSMutableArray *a = [NSMutableArray arrayWithArray:@[@1,@2]];
    self.s1 = a;
    self.s2 = a;
    [a addObject:@3];
    NSLog(@"s1: %@, s2:%@", self.s1, self.s2);
    self.s2 = self.s1;
    NSLog(@"s1: %@, s2:%@", self.s1, self.s2);
    [self.s1 addObject:@4];
    NSLog(@"s1: %@, s2:%@", self.s1, self.s2);
    
    NSLog(@"int max: %d", INT_MAX);
    NSLog(@"int max: %d", INT_MIN);
    [self mergeTwoSortedArray1];
    [self mergeTwoSortedArrayNoExtraSpace];
    
    
    NSArray *array3 = @[@2, @4, @10, @7, @10];
    if ([array3 indexOfObject:@10] != NSNotFound) {
        NSLog(@"Index of object: %lu", (unsigned long)[array3 indexOfObject:@10]);
    }

    NSInteger number = 10;
    NSLog(@"Binary search of %ld found: %ld", (long)number, (long)[array3 binarySearch:0 end:array3.count-1 number:number]);
    NSLog(@"Binary search iterative: %ld", [array3 binarySearchIterative:@10]);

//    NSArray *array4 = @[@"b", @"d", @"g", @"k"];
//    NSLog(@"Binary search %@ found: %lu", @"b", (unsigned long)[array4 binarySearch:0 end:array4.count-1 character:@"z"]);
//    
//    NSArray *array5 = @[@3, @0, @-1, @4, @5, @0, @2, @0];
//    [array5 sortArrayZeros:[array5 mutableCopy]];

    self.enumeratorIdx = 0;
    self.enumeratorArray = [NSMutableArray arrayWithArray:@[@"a", @"b", @[@"c", @[@"d"]], @[ @[@"e", @[@"f"]], @"g" ] ]];
    self.enumeratorArray = [self.enumeratorArray mutableCopy];
    
    NSArray *words = @[@"ape", @"peel", @"pale", @"apple", @"appple"];
    // ape+pl = apple, e+pal= ap?le, ????e, ????e
    NSLog(@"Sticker count: %lu", (unsigned long)[words stickerCount]);
    
    NSArray *array = @[@3, @7, @1, @4, @5, @2];
    for (NSNumber *num in array) {
        NSLog(@"Rolling median: %f", [self rollingMedian:num]);
    }
}

// NSEnumerator
- (id)nextObject {
    if (self.enumeratorArray.count > 0) {
        id obj = self.enumeratorArray[0];
        [self.enumeratorArray removeObjectAtIndex:0];
        return [self firstObject:obj];
    }
    return nil;
}

// Takes out the first object and insert it back to the array recursively until the object is a string, then return it
- (id)firstObject:(id)obj {
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }
    else if ([obj isKindOfClass:[NSArray class]]) {
        NSMutableArray *newArray = [obj mutableCopy];
        id firstObj = newArray[0];
        [newArray removeObjectAtIndex:0];

        if (newArray.count > 0) {
            [self.enumeratorArray insertObject:[newArray copy] atIndex:0];
        }
        return [self firstObject:firstObj];
    }
    return nil;
}

- (void)passArrayByReference:(NSArray **)array {
    NSLog(@"Original array: %@", *array);
    NSArray *newArray = @[@1, @2, @3];
    *array = newArray;
}

- (void)blockExecution {
    // We supply the executeBlock method with this inline defined block.
    // executeBlock can execute this block and it'll return an NSString whenever it's executed
    NSLog(@"First run of block");
    [self executeBlock:^NSString *(int a, float b) {
        float c = a + b;
        NSString *string = [NSString stringWithFormat:@"Block result: %lf", c];
        NSLog(@"%@", string);
        return string;
    }];
    
    NSLog(@"Second run of block");
    self.propertyBlock = ^NSString *(int a, float b){return @"property block";};
    [self executeBlock:self.propertyBlock];
    [self executeBlock:^NSString *(int a, float b){return @"inline defined block";}];
    [self executeDispatchBlock:^void{NSLog(@"Inside a dispatch block");}];
}

- (void)executeDispatchBlock:(dispatch_block_t)block {
    // typedef void (^dispatch_block_t)(void);
    block();
}

- (void)executeBlock:(NSString *(^)(int, float))myBlock {
    int a = 10;
    float b = 20;

    // myBlock function already defined, supply it with the required parameters and it'll return the result
    if (myBlock) {
        NSString *result = myBlock(a, b);
        NSLog(@"Execute input myBlock: %@", result);
    }
    
    // Define newBlock
    NSString *(^newBlock)(int, float) = ^NSString *(int a, float b) {
        return @"something";
    };
    
    // Execute new block
    NSLog(@"Execute newBlock created inside a method: %@", newBlock(a, b));
    
    // Local variable
    dispatch_block_t localBlock = ^void{NSLog(@"Execute a localBlock");};
    localBlock();
    
    // Execute typedef block
    newTypeDefBlock anotherBlock = ^NSNumber *(int a, NSNumber *b) {return @(a+[b integerValue]);};
    self.aTypeDefBlock = anotherBlock;
    NSLog(@"Execute a typedef block: %@", self.aTypeDefBlock(1, @2));
    
}

- (void)twoDimenionalArray {
    int num1=3, num2=4;
    NSLog(@"i=3, j=4");
    //scanf("%d %d", &num1, &num2);
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:(num1*num2)];
    // initialize it with 0s
    for(int i=0; i < (num1*num2); i++) [arr addObject:@0];
    
    // replace 0s with something more interesting
    for(int i=0; i < num1; i++) {
        for(int j=0; j < num2; j++) {
            arr[i*num2+j] = @(i+j*2);
        }
    }
    
    // access a value: i*num2+j, where i,j are the indexes for the bidimensional array
    // sam as arr[1][3]
    //    j0 j1 j2 j3
    // i0
    // i1
    // i2
    NSLog(@"arr[1][3]: %@", arr[1*num2+3]);
    NSLog(@"arr[2][1]: %@", arr[2*num2+1]);
    for(int i=0; i < num1; i++) {
        for(int j=0; j < num2; j++) {
           printf("%i ", [arr[i*num2+j] intValue]);
        }
        printf("\n");
    }
}

/*
    calculate an efficient streaming median of numbers.
    eg: set of numbers are- 3, 7, 1, 4, 5, median will be 4
    3, 7, 1, 4 = (3+4)/2 = 3.5
    1,3,4,7 = (3+4)/2 = 3.5
    1,3,4,5,7 = 4
    1,3,4,5,7, next: 2 -> 1,2,3,4,5,7 = (3+4)/2 = 3.5
 */
- (double)rollingMedian:(NSNumber *)number {
    static NSMutableArray *array = nil;
    if (array == nil) {
        array = [NSMutableArray new];
    }
    [array addObject:number];
    [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    //NSLog(@"Sorted array: %@", array);

    // If array size is odd number, return the middle item
    if (array.count%2 == 1) {
        return [array[array.count/2] doubleValue];
    }
    // If array size is even number, return the average of the numbers of the middle two items
    double median1 = [array[array.count/2] doubleValue];
    double median2 = [array[array.count/2-1] doubleValue];
    return (median1+median2)/2;
}

/*
 Binary Heap:
 For kth element in an array
 Left child index = 2*k
 Right child index = 2*k+1
 Parent index = k/2
 
 Start at index=1 for easier calculation: array[1]=min
 Insertion (min heap, root node is the smallest element):
 1. Add object to the end of the array.
 2. Check if input is smaller than it's parent at (size-)/2
 3. If yes, swap parent and current value, repeat 2.
 
 Deletion
 1. Replace the min value with the last object of the array
 2. Compare to it's children, if it's bigger than children (left or right), swap and move down index*2
 */



/*
 Merge two arrays into two sorted arrays
 Input:
 array1 = 1,5,9,10,15,20->1,2,9,10,15,20->1,2,3,10,15,20
 array2 = 2,3,8,13,     ->3,5,8,13      ->9,5,8,13
 
 
 Output:
 array1 = 1,2,3,5,8,9
 array2 = 10,13,15,20
 */

- (void)mergeTwoSortedArray1 {
    NSMutableArray *array2 = [NSMutableArray arrayWithArray:@[@1,@5,@9,@10,@15,@20]];
    NSMutableArray *array1 = [NSMutableArray arrayWithArray:@[@6,@6,@8,@13]];
    NSMutableArray *array3 = [NSMutableArray arrayWithCapacity:array1.count+array2.count];

    NSUInteger idx1 = 0;
    NSUInteger idx2 = 0;
    for (NSUInteger i=0; i<array3.count; i++) {
        
        // if traversal of array2 is complete, continue to add object from array1
        if (idx2 >= array2.count) {
            [array3 addObject:array1[idx1++]];
        }
        // if traversal of array1 is complete, continue to add object from array2
        else if (idx1 >= array1.count) {
            [array3 addObject:array2[idx2++]];
        }
        // if array1 element is greater than array2 element, add array2 element
        else if ([array1[idx1] isGreaterThanOrEqualTo:array2[idx2]]) {
            [array3 addObject:array2[idx2++]];
        }
        // if array2 element is greater than array1 element, add array1 element
        else {
            [array3 addObject:array1[idx1++]];
        }
    }
    NSLog(@"array: %@", array3);
    
}

- (void)mergeTwoSortedArrayNoExtraSpace {
    NSMutableArray *array1 = [NSMutableArray arrayWithArray:@[@1,@5,@9,@10,@15,@20]];
    NSMutableArray *array2 = [NSMutableArray arrayWithArray:@[@6,@7,@8,@13]];
    
    for (NSUInteger idx1=0; idx1<array1.count; idx1++) {
        // If array1 > array2, swap array1 array2, sort array2
        // If array1 < array2, increment array1
        if ([array1[idx1] isGreaterThan:array2[0]]) {
            NSNumber *temp = array1[idx1];
            array1[idx1] = array2[0];
            array2[0] = temp;

            // Use insertion sort to sort the swapped element array[0] in array2
            for (NSUInteger i=1; i<array2.count; i++) {
                if ([temp isGreaterThan:array2[i]]) {
                    array2[i-1] = array2[i];
                    array2[i] = temp;
                }
            }
        }
    }
    NSLog(@"array1: %@", array1);
    NSLog(@"array2: %@", array2);
}

//- (void)mergeTwoSortedArray:(NSMutableArray *)array1 array:(NSMutableArray *)array2 {
// This method contains bugs!!!
- (void)mergeTwoSortedArray {
    NSMutableArray *array1 = [NSMutableArray arrayWithArray:@[@1,@5,@9,@10,@15,@20]];
    NSMutableArray *array2 = [NSMutableArray arrayWithArray:@[@6,@7,@8,@13]];
    NSMutableArray *array3 = [NSMutableArray new];
    NSUInteger idx2 = 0;
    for (NSUInteger idx1=0; idx1<array1.count; idx1++) {
        if (idx2>=array2.count) {
            [array3 addObject:array1[idx1]];
        }
        else if ([array1[idx1] isGreaterThan:array2[idx2]]) {
            [array3 addObject:array2[idx2]];
            [array3 addObject:array1[idx1]];
        }
        else {
            [array3 addObject:array1[idx1]];
            [array3 addObject:array2[idx2]];
        }
        idx2++;
    }
    NSLog(@"array1: %@", array3);
    NSLog(@"array2: %@", array2);
}

/*
 Test case 1: array is empty
 Test case 2: array has 1 element
 Test case 3: array contains 0 element(s)
 Assume we can't use division.
 If we can use division, we can divide the total product by the at index value. However, needs to take care of 0 value element
 */
- (NSArray *)getProductsOfAllIntsExceptAtIndex:(NSArray *)array {
//    [1, 7, 3, 4] -> [7*3*4, 1*3*4, 1*7*4, 1*7*3] -> [84, 12, 28, 21]
    /*
     1: 7*3
     7: 3*4
     3: 4
     4: 1
     */
    NSArray *beforeIndex = [self buildBeforeIndex:array];
    NSArray *afterIndex = [self buildAfterIndex:array];
    NSLog(@"Before: %@", beforeIndex);
    NSLog(@"After: %@", afterIndex);
    NSMutableArray *productArray = [NSMutableArray arrayWithCapacity:array.count];
    for (NSUInteger i=0; i<array.count; i++) {
        NSUInteger product = [beforeIndex[i] integerValue] * [afterIndex[i] integerValue];
        productArray[i] = @(product);
    }
    return productArray;
}

- (NSArray *)buildAtIndex:(NSArray *)array {
    if (array.count <= 1) {
        return array;
    }
    NSMutableArray *before = [NSMutableArray arrayWithCapacity:array.count];
    NSUInteger maxSoFar = 1;
    for (NSUInteger i=0; i<array.count; i++) {
        before[i] = @(maxSoFar);
        maxSoFar *= [array[i] integerValue];
    }
    NSMutableArray *atIndex = [NSMutableArray arrayWithCapacity:array.count];
    for (NSUInteger i=0; i<array.count; i++) {
        atIndex[i] = @0;
    }
    maxSoFar = 1;
    for (NSInteger i=array.count-1; i>=0; i--) {
        NSUInteger atIndexValue = maxSoFar * [before[i] integerValue];
        atIndex[i] = @(atIndexValue);
        maxSoFar *= [array[i] integerValue];
    }
    return [atIndex copy];
}

- (NSArray *)buildBeforeIndex:(NSArray *)array {
    NSMutableArray *before = [NSMutableArray arrayWithCapacity:array.count];
    for (NSUInteger i=0; i<array.count; i++) {
        if (i==0) {
            before[i] = @1;
        }
        else {
            NSInteger cache = [before[i-1] integerValue] * [array[i-1] integerValue];
            before[i] = @(cache);
        }
    }
    return [before copy];
}

- (NSArray *)buildAfterIndex:(NSArray *)array {
    NSMutableArray *after = [NSMutableArray arrayWithCapacity:array.count];
    for (NSUInteger i=0; i<array.count; i++) {
        after[i] = @0;
    }
    NSUInteger productSoFar = 1;
    for (NSInteger i=array.count-1; i>=0; i--) {
        after[i] = @(productSoFar);
        productSoFar *= [array[i] integerValue];
    }
    return [after copy];
}

- (int)maxProductOfThreeNumbers:(NSArray *)array {
    int a[] = {1, 10, -5, 1, -100};
    int maxSoFar = INT_MIN;
    int minSoFar = INT_MAX;
    for (int i=0; i<5; i++) {
        if (a[i] > maxSoFar) {
            maxSoFar = a[i];
        }
    }
    return maxSoFar;
}

//- (int)maxNumberInArray:(NSArray *)array max:(NSInteger)max {
//    NSInteger maxSoFar = INT_MIN;
//    for (int i=0; i<array.count; i++) {
//        if (a[i] > max) {
//            maxSoFar = a[i];
//        }
//    }
//}


//- (NSInteger)maxProductOfThreeNumbers:(NSArray *)array {
//    NSMutableArray *maxSoFar = [NSMutableArray arrayWithArray:@[@0, @0, @0]];
//    NSMutableArray *index = [NSMutableArray arrayWithArray:@[@-1, @-1, @-1]];
//    for (NSUInteger i=0; i<array.count; i++) {
//        if ([array[i] integerValue] > [maxSoFar[0] integerValue]) {
//            maxSoFar[0] = array[i];
//            index[0] = @(i);
//        }
//    }
//    NSLog(@"maxSoFar: %@, %@", maxSoFar[0], index[0]);
//    for (NSUInteger j=0; j<2; j++) {
//        for (NSUInteger i=0; i<array.count; i++) {
//            if ((i != [index[0] integerValue]) && i != [index[1] integerValue] && i != [index[2] integerValue]) {
//                NSInteger product = [array[i] integerValue] * [maxSoFar[j] integerValue];
//                NSLog(@"Product1 %ld, nax: %@", product, maxSoFar[j+1]);
//                if (product > [maxSoFar[j+1] integerValue]) {
//                    maxSoFar[j+1] = @(product);
//                    index[j+1] = @(i);
//                }
//            }
//        }
//        NSLog(@"maxSoFar: %@, %@", maxSoFar[j+1], index[j+1]);
//    }
//    return [maxSoFar[2] integerValue];
//}


@end
