//
//  BinarySearch.m
//  algorithm_objc
//
//  Created by Stephen Ling on 11/2/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import "BinarySearch.h"

@implementation BinarySearch

- (void)setup {
//    [self basicTests];
//    [self binarySearchCharacterSetup];
//    [self smallestCharacterSetup];
    [self findElementInRotationArraySetup];
}

- (void)findElementInRotationArraySetup {
    NSArray *a = @[@4,@5,@6,@7,@0,@1,@2];
    NSLog(@"K=5, expected:1, receieved: %@", [self findElementInRotationArray:a num:@5]);
    
    a = @[@4,@5,@6,@7,@0,@1,@2];
    NSLog(@"K=1, expected:5, receieved: %@", [self findElementInRotationArray:a num:@1]);
    
    a = @[@2,@4,@5,@6];
    NSLog(@"K=6, expected:3, receieved: %@", [self findElementInRotationArray:a num:@6]);
	NSLog(@"K=4, expected:1, receieved: %@", [self findElementInRotationArray:a num:@4]);
    
    a = @[@6,@9,@0,@4,@5];
    NSLog(@"K=9, expected:1, receieved: %@", [self findElementInRotationArray:a num:@9]);
    NSLog(@"K=5, expected:4, receieved: %@", [self findElementInRotationArray:a num:@5]);
    NSLog(@"K=10, expected:-1, receieved: %@", [self findElementInRotationArray:a num:@10]);
	
	a = @[@4,@9,@0,@4,@4];
	NSLog(@"K=9, expected:1, receieved: %@", [self findElementInRotationArray:a num:@4]);
}

- (NSNumber *)findElementInRotationArray:(NSArray *)a num:(NSNumber *)k {
    if (a.count == 0 || !a) {
        return nil;
    }
    int s = 0;
    int e = (int)a.count-1;
    while (s <= e) {
        int m = s + (e-s)/2;
        if ([k isEqual:a[m]]) {
            return @(m);
        }
        // Rotation is on the left
        if ([a[s] isGreaterThan:a[m]]) {
            if ([k isGreaterThan:a[m]] && [k isLessThanOrEqualTo:a[e]]) {
                s = m+1;
            }
            else {
                e = m-1;
            }
        }
        // Rotation is on the right or no rotation (doesn't matter)
		else {
            if ([k isGreaterThan:a[s]] && [k isLessThanOrEqualTo:a[m]]) {
                e = m-1;
            }
            else {
                s = m+1;
            }
        }
    }
    return @-1;
}

- (void)basicTests {
    int array[10] = {2,3,6,8,9,12,15,20,99,100};
    int n = 6;
    int size = sizeof(array)/sizeof(int);
    printf("index of %d = %d\n", n, [self binarySearchIterative:array size:size input:n]);
    n = 2;
    printf("index of %d = %d\n", n, [self binarySearchIterative:array size:size input:n]);
    n = 1;
    printf("index of %d = %d\n", n, [self binarySearchIterative:array size:size input:n]);
    n = 7;
    printf("index of %d = %d\n", n, [self binarySearchIterative:array size:size input:n]);
    n = 100;
    printf("index of %d = %d\n", n, [self binarySearchIterative:array size:size input:n]);
    n = 200;
    printf("index of %d = %d\n", n, [self binarySearchIterative:array size:size input:n]);
    n = 101;
    printf("index of %d = %d\n", n, [self binarySearchIterative:nil size:0 input:n]);
}

- (int)binarySearchIterative:(int *)array size:(int)size input:(int)n {
    if (array == nil) {
        return -(size+1);
    }
    int low = 0;
    int high = size;
    
    // must be low<=high to cover edge cases when searching at both ends
    while (low <= high) {
        // 2+(10-2)/2 = 6
        int mid = low + (high-low)/2;
        if (array[mid] == n) {
            return mid;
        }
        else if (array[mid] > n) {
            high = mid-1;
        }
        else {
            low = mid+1;
        }
    }
    //printf("low: %d high: %d\n", low, high);
    // low is always positive but high could be negative
    // How to handle 0? return -(low+1) and have the caller do (returnValue*-1)-1
    // If return "low", it's the exact postion to insert not found character
    return -(low+1);
}

/**
 * Return the smallest character that is strictly larger than the search character,
 * otherwise return the first character in the string.
 * @param sortedStr : sorted list of letters, sorted in ascending order.
 * @param c : character for which we are searching.
 * Given the following inputs we expect the corresponding output:
 
 * ['c', 'f', 'j', 'p', 'v'], 'a' => 'c'
 * ['c', 'f', 'j', 'p', 'v'], 'c' => 'f'
 * ['c', 'f', 'j', 'p', 'v'], 'k' => 'p'
 * ['c', 'f', 'j', 'p', 'v'], 'z' => 'c' // The wrap around case, any character greater than or equal to v will return c
 * ['c', 'c', 'k'], 'f' => 'k'
 * ['c', 'f', 'k'], 'c' => 'f'
 * ['c', 'f', 'k'], 'd' => 'f'
 */

- (void)smallestCharacterSetup {
    NSString *string = @"cfjpv";
    unichar character = 'a';
    printf("Smallest character larger than %c: %c\n", character, [self smallestCharacter:string input:character]);
    
    character = 'c';
    printf("Smallest character larger than %c: %c\n", character, [self smallestCharacter:string input:character]);
    
    character = 'k';
    printf("Smallest character larger than %c: %c\n", character, [self smallestCharacter:string input:character]);
    
    character = 'z';
    printf("Smallest character larger than %c: %c\n", character, [self smallestCharacter:string input:character]);
    
    string = @"cck";
    character = 'f';
    printf("Smallest character larger than %c: %c\n", character, [self smallestCharacter:string input:character]);
    
    string = @"cfk";
    character = 'c';
    printf("Smallest character larger than %c: %c\n", character, [self smallestCharacter:string input:character]);
    character = 'd';
    printf("Smallest character larger than %c: %c\n", character, [self smallestCharacter:string input:character]);
}

- (unichar)smallestCharacter:(NSString *)string input:(unichar)character {
    if (!string || !character) {
        return -1;
    }
    /*
     // Approach 1: binary search return positive index to indicate character found and negative for not found
    NSInteger index = [[self binarySearchCharacter:string input:character] integerValue];
    printf("Index: %ld\n", index);
    // Character not found, return the index or 0 if index if index is greater than string length
    if (index < 0) {
        index = index * -1 - 1;
        if (index<string.length) {
            return [string characterAtIndex:index];
        }
        else {
            return [string characterAtIndex:0];
        }
    }
    // Case 1: Found the input character, return the next non-repeated character or wrap around to the first character
    else if (index < string.length-1) {
        // Case 1: Return the next non-repeated character
        for (NSUInteger i=index+1; i<string.length-1; i++) {
            if ([string characterAtIndex:i] > [string characterAtIndex:index]) {
                return [string characterAtIndex:i];
            }
        }
    }
    // Case 2: Wrap around to return the first character
     return [string characterAtIndex:0];
     */
    
    // Approach 2: binary search returns either index of the found character or insertion position if not found
    NSInteger index = [[self binarySearchCharacter:string input:character] integerValue];
    printf("Index: %ld: ", index);
    for (NSUInteger i=index; i<string.length; i++) {
        if ([string characterAtIndex:i]>character) {
            return [string characterAtIndex:i];
        }
    }
    return [string characterAtIndex:0];
}

- (NSNumber *)binarySearchCharacter:(NSString *)string input:(unichar)character {
    if (string == nil) {
        return nil;
    }
    NSInteger low = 0;
    NSInteger high = string.length-1;

    while (low <= high) {
        NSInteger mid = low + (high-low)/2;
        if ([string characterAtIndex:mid] == character) {
            return @(mid);
        }
        else if ([string characterAtIndex:mid] > character) {
            high = mid-1;
        }
        else {
            low = mid+1;
        }
    }
    //printf("low: %ld high: %ld: ", low, high);
    // return negative number is to differential found and not found
    //return @(-(low+1));
    // "low" is the exact position to insert the character
    return @(low);
}

- (void)binarySearchCharacterSetup {
    NSString *string = @"cccffffjpv";
    unichar character = 'a';
    printf("Index of %c = %d\n", character, [[self binarySearchCharacter:string input:character] intValue]);
    character = 'z';
    printf("Index of %c = %d\n", character, [[self binarySearchCharacter:string input:character] intValue]);
    character = 'e';
    printf("Index of %c = %d\n", character, [[self binarySearchCharacter:string input:character] intValue]);
    character = 'f';
    printf("Index of %c = %d\n", character, [[self binarySearchCharacter:string input:character] intValue]);
    character = 'c';
    printf("Index of %c = %d\n", character, [[self binarySearchCharacter:string input:character] intValue]);
    character = 'v';
    printf("Index of %c = %d\n", character, [[self binarySearchCharacter:string input:character] intValue]);
}

- (NSInteger)binarySearch:(NSArray *)array number:(NSNumber *)number {
    NSInteger low = 0;
    NSInteger high = array.count - 1;
    NSInteger middle = 0;
    while (low <= high) {
        middle = low + (high-low)/2;
        if ([array[middle] isEqualToNumber:number]) {
            return middle;
        }
        if ([array[middle] isGreaterThan:number]) {
            high = middle-1;
        }
        else {
            low = middle+1;
        }
    }
    //NSLog(@"low: %ld, mid: %ld, high: %ld", (long)low, (long)middle, (long)high);
    // Character not found
    // low: next position to insert character. Should return -(low+1) to handle low = 0
    // Since low starts at 0 and we only increment it, it never goes to negative but could be out of bound
    // high: replace previous position with this index
    return low;
}

@end
