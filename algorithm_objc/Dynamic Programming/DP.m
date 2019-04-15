//
//  DP.m
//  algorithm_objc
//
//  Created by ling, stephen on 1/21/19.
//  Copyright © 2019 sling. All rights reserved.
//

#import "DP.h"

@interface DP ()
@property NSArray *a1;
@property NSArray *r1;
@property NSMutableDictionary *dp;
@property NSMutableArray *dpArray;
@end

@implementation DP

- (void)setup {
//    [self totalMatchSetsForArraySetup];
//    [self longestCommonSubsequenceSetup];
//    [self longestCommonSubstringSetup];
//    [self towerHopperSetup];
//    [self knapsackSetup];
//    [self decodeMessageSetup];
    [self staircaseSetup];
}

- (void)printAllSubsetsSetup {
    
}

- (void)printAllSubsets:(NSArray *)a {
    
}

/*
 There exists a staircase with N steps, and you can climb up either 1 or 2 steps at a time. Given N, write a function that returns the number of unique ways you can climb the staircase. The order of the steps matters.
 
 For example, if N is 4, then there are 5 unique ways:
 n=4, total=5: [1, 1, 1, 1], [2, 1, 1], [1, 2, 1], [1, 1, 2], [2, 2]
 n=3, total=3: [1, 1, 1], [2, 1], [1, 2]
 n=2, total=2: [0,1], [0,2]
 n=1, total=1: [0,1]
 General
 */

- (void)staircaseSetup {
    int n=1;
    printf("N=%d, total=1, receive %d\n", n, [self staircase:n]);
    printf("N=%d, total=1, receive %d\n", n, [self staircaseIterative:n]);
    n=2;
    printf("N=%d, total=2, receive %d\n", n, [self staircase:n]);
    printf("N=%d, total=2, receive %d\n", n, [self staircaseIterative:n]);
    n=3;
    printf("N=%d, total=3, receive %d\n", n, [self staircase:n]);
    printf("N=%d, total=3, receive %d\n", n, [self staircaseIterative:n]);
    n=4;
    printf("N=%d, total=5, receive %d\n", n, [self staircase:n]);
    printf("N=%d, total=5, receive %d\n", n, [self staircaseIterative:n]);
}

- (int)staircase:(int)n {
    NSMutableArray *cache = [NSMutableArray new];
    for (int i=0; i<=n; i++) {
        [cache addObject:@-1];
    }
    cache[0] = @1;
    cache[1] = @1;
    return [self staircaseRecursive:n cache:cache];
}

- (int)staircaseRecursive:(int)n cache:(NSMutableArray *)cache {
    if ([cache[n] isGreaterThan:@-1]) {
        return [cache[n] intValue];
    }
    cache[n] = @([self staircase:n-2] + [self staircase:n-1]);
    return [cache[n] intValue];
}

- (int)staircaseIterative:(int)n {
    if (n <= 2) {
        return n;
    }
    int n_2 = 1;
    int n_1 = 1;
    int curr = 0;
    int i = 2;
    while (i<=n) {
        /*
         s[n] = s[n-2] + s[n-1]
         For next iteractive, s[n-2]=s[n-1] and s[n]=s[n-1]
         */
        curr = n_2 + n_1;
        n_2 = n_1;
        n_1 = curr;
        i++;
    }
    return curr;
}

/*
 Given an array of numbers and a target number t. Return the total number of sets which sum of all numbers is equal to t
 Would the array empty? Yes => return 0
 Are there any negative or zeroes or duplicates? No
 Matching number always > 1? Yes
 Array sorted? Doesn't matter and assume yes
 
 2,4,6,10
 [0,0]: [2] 2,4, 2,6, 2,10
 [0,1]: [2,4] 2,4,6, 2,4,10
 [0,2]: [2,4,6] 2,4,6,10
 
 [1,1]: [4], 4,6, 4,10
 [1,2]: [4,6] 4,6,10
 [1,3]: [4,6,10]
 
 [2,2]: 6, 6,10
 [2,3]: [6,10]
 
 [3,3]: 10
 
 a[2,4] = 6
 a[2,4]+6 = 12
 a[2,4,6]+10 16
 Time complexity = total
 */
- (void)totalMatchSetsForArraySetup {
    self.dp = [NSMutableDictionary new];
    self.a1 = @[@2,@4,@6,@10];
    self.r1 = @[@[@6,@10], @[@2,@4,@10]];
    NSLog(@"Expected: %ld, returned: %ld", self.r1.count, [self totalMatchSetsForArray:self.a1 number:16]);
}

- (NSInteger)totalMatchSetsForArray:(NSArray *)a number:(NSInteger)n {
    return [self countSet:a idx:0 total:n];
}

- (NSInteger)countSet:(NSArray *)a idx:(NSInteger)i total:(NSInteger)total {
    NSString *key = [NSString stringWithFormat:@"%ld,%ld", i, total];
    NSInteger result = 0;
    if (self.dp[key]) {
        return [self.dp[key] integerValue];
    }
    // Base case 1: total = 0 => match count and return 1
    else if (total == 0) {
        return 1;
    }
    // Base case 2: total < 0 => current set is not a match and return 0
    else if (total < 0) {
        return 0;
    }
    // Bae case 3: index out of bound and return 0
    else if (i >= a.count) {
        return 0;
    }
    // Case 4: total is greater than current element, search the next subset excluding the current element
    else if ([a[i] integerValue] > total) {
        result = [self countSet:a idx:i+1 total:total];
    }
    // Case 5: total less than or equal to current element, search next subsets including/excluding the current element
    // Return combined count for both
    else {
        result = [self countSet:a idx:i+1 total:total] + [self countSet:a idx:i+1 total:total-[a[i] integerValue]];
    }
    self.dp[key] = @(result);
    return result;
}


/*
 Longest Common Subsequence of Two Strings
 Recursive traverse both string with different indexes
 Base case: if s1 idx or s2 idx out-of-bounds, return 0;
 if s1[i] == s2[j], call recursively with both indexes advances: length = lcs(i+1, j+1) + 1
 else traverse with either one advanced and return the max: max{lcs(i,j+1), lcs(i+1,j)}
 dp is to save length result from various i,j position.
 Can use either hash (key="i,j") or 2d array
 Time complexity = O(m*n), m=s1.length, n=s2.length
 */
- (void)longestCommonSubsequenceSetup {
    NSLog(@"Expected: BAD, returned: %ld", [self longestCommonSubsequence:@"BATD" string:@"ABACD"]);
    NSLog(@"Expected: ADH, returned: %ld", [self longestCommonSubsequence:@"ABCDGH" string:@"AEDFHR"]);
    NSLog(@"Expected: GTAB, returned: %ld", [self longestCommonSubsequence:@"AGGTAB" string:@"GXTXAYB"]);
}

- (NSInteger)longestCommonSubsequence:(NSString *)s1 string:(NSString *)s2 {
    self.dp = [NSMutableDictionary new];
    return [self lcs:s1 idx:0 string:s2 idx:0];
}

- (NSInteger)lcs:(NSString *)s1 idx:(NSInteger)i string:(NSString *)s2 idx:(NSInteger)j {
    if (i >= s1.length || j >= s2.length) {
        return 0;
    }
    NSString *key = [NSString stringWithFormat:@"%ld,%ld", i, j];
    if (self.dp[key]) {
        return [self.dp[key] integerValue];
    }
    NSInteger length = 0;
    if ([s1 characterAtIndex:i] == [s2 characterAtIndex:j]) {
        length = [self lcs:s1 idx:i+1 string:s2 idx:j+1] + 1;
    }
    else {
        length = MAX([self lcs:s1 idx:i string:s2 idx:j+1], [self lcs:s1 idx:i+1 string:s2 idx:j]);
    }
    self.dp[key] = @(length);
    return length;
}

/*
 Longest Common Contigous Substring
 Brute force:
 For each substring of s1, traverse s2 from beginning and found all the matches.
 Runtime = find all the substrings in first string O(m^2) and linear search s2 if there's a match O(n). Final O(n*m^2)
 
 Dynamic Programming:
 Use a 2D array or dictionary to save the length of substring in a matrix
 For any position comparison, if both chars matched, add 1 from previous result and store in the new position
 Else store 0 if using array
 Use dictionary has an advantage as no need to store 0's and hence space complexity could be a lot smaller than array
 
   a b a b c d e
 a 1 0 0 0 0 0 0
 b 0 2 0 1 0 0 0
 c 0 0 0 0 2 0 0
 d 0 0 0 0 0 3 0
 z 0 0 0 0 0 0 0
 
 Time and space complexity is O(m*n)
 */
- (void)longestCommonSubstringSetup {
    NSLog(@"Expected: Geeks, 5, returned: %ld", [self longestCommonSubstring:@"GeeksforGeeks" string:@"GeeksQuiz"]);
    NSLog(@"Expected: abcd, 4, returned: %ld", [self longestCommonSubstring:@"abcdxyz" string:@"xyzabcd"]);
    NSLog(@"Expected: abcdez, 6, returned: %ld", [self longestCommonSubstring:@"zxabcdezy" string:@"yzabcdezx"]);
    NSLog(@"Expected: aaa, 3, returned: %ld", [self longestCommonSubstring:@"aaa" string:@"aaa"]);
}

- (NSInteger)longestCommonSubstring:(NSString *)s1 string:(NSString *)s2 {
    self.dp = [NSMutableDictionary new];
    NSString *key = [NSString new];
    NSInteger max = 0;
    // If use array as memorization, need to avoid first elements -1,-1 and need to take care of 0 indexes.
    // Therefore need to compare previous values and use <=s1.length instead of <s1.length
    // No issue if use dictionary or set
    for (int i=0; i<s1.length; i++) {
        for (int j=0; j<s2.length; j++) {
//            if ((i == 0 || j == 0)) {
//                self.dp[key] = @0;
//            }
            key = [NSString stringWithFormat:@"%d,%d", i, j];
            if ([s1 characterAtIndex:i] == [s2 characterAtIndex:j]) {
                // For initial position, this became -1 and it's ok since we're using dictiobary.
                NSString *prevKey = [NSString stringWithFormat:@"%d,%d", i-1, j-1];
                self.dp[key] = @([self.dp[prevKey] integerValue] + 1);
                max = MAX(max, [self.dp[key] integerValue]);
            }
//            else {
//                self.dp[key] = @0;
//            }
        }
    }
    return max;
}

/*
 Tower hopper problem. Given a array of position numbers, where each number represent the height of a tower
 If h=2, means you can jump up to length of 2 to idx+1 or idx+2. h=0 means can't jump.
 Write a method to determine if the given array can complete be hopper to exit the array.
 For example, [1,2,0] -> yes, [1,0,9] -> no.
 
 Algorithm:
 Goal is to find out if there's any combination of array that can add up to exceed the array length
 Brute force is to for each element, try all the possible hops.
 For example: [3,...] -> try 1,2,3
 
 Can use dp and recursive to solve it:
 idx >= array count means escape all the towers, return YES
 if element == 0, means can't hop to next tower, return NO;
 Breadth search all possible hops and recursively call each route
 [4,2,0,0,2,0]
 [4]->try [2,0,0,2]->[y,n,n,y];
 [2]->[0,0]
 [0]-> return no
 [0]->return no
 [2]->[0], i=6, which is >=tower.count 6, return yes
 Use a set to store visited indexes to avoid repeated visit.
 */

- (void)towerHopperSetup {
    NSArray *array = @[@4,@2,@0,@0,@2,@0];
    self.dp = [NSMutableDictionary new];
    NSLog(@"Can hop tower: YES. Returned: %d", [self towerHopper:array idx:0]);

    array = @[@0,@1];
    self.dp = nil;
    NSLog(@"Can hop tower: NO. Returned: %d", [self towerHopper:array idx:0]);

    array = @[@4,@2,@0,@1,@1,@0];
    self.dp = nil;
    NSLog(@"Can hop tower: NO. Returned: %d", [self towerHopper:array idx:0]);
    
    array = @[@4,@2,@0,@1,@5,@0];
    self.dp = nil;
    NSLog(@"Can hop tower: YES. Returned: %d", [self towerHopper:array idx:0]);
}

- (BOOL)towerHopper:(NSArray *)tower idx:(NSInteger)i {
    if (i>=tower.count) {
        return YES;
    }
    if ([tower[i] isEqualTo:@0]) {
        return NO;
    }
    if (self.dp[@(i)]) {
        return [self.dp[@(i)] boolValue];
    }
    BOOL result = NO;
    for (NSInteger j=i+1; j<=i+[tower[i] integerValue]; j++) {
        if ([self towerHopper:tower idx:j] == YES) {
            return YES;
        }
//        result = result || [self towerHopper:tower idx:j];
    }
    self.dp[@(i)] = [NSNumber numberWithBool:result];
    return NO;
}

/*
 Given a list of values and weights and capacity c, find out the maximum subset of values
 v = [60, 100, 120]
 w = [10, 20, 30]
 c = 50
 Solution = [20+30] = 100+120 = 220
 
 Algorithm:
 For each element, recursive call both include and exclude the current element:
 Include: c = c-current weight, call next index with current value added
 Exclude: c = unchange and value unchange, call next index
 Base cases: idx out-of-bound and current element > c, return current capacity c
 */

- (void)knapsackSetup {
    NSArray *v = @[@60, @100, @120];
    NSArray *w = @[@10, @20, @30];
    NSLog(@"Expected 220, received: %ld", [self knapsackRecursion:v weight:w capacity:50]);
    
    v = @[@1, @4, @5, @7];
    w = @[@1, @3, @4, @5];
    NSLog(@"Expected 9, received: %ld", [self knapsackRecursion:v weight:w capacity:7]);
}

- (NSUInteger)knapsackIteration:(NSArray *)v weight:(NSArray *)w capacity:(NSInteger)c {
    return 0;
}

- (NSInteger)knapsackRecursion:(NSArray *)v weight:(NSArray *)w capacity:(NSInteger)c {
    self.dp = [NSMutableDictionary new];
    return [self knapsack:v weight:w capacity:c idx:0];
}

- (NSInteger)knapsack:(NSArray *)v weight:(NSArray *)w capacity:(NSInteger)c idx:(int)i {
    // Out-of-bound of value and weight or current weight exceed capacity
    if (i >= v.count || [w[i] integerValue] > c) {
        return 0;
    }
    NSString *key = [NSString stringWithFormat:@"%d,%ld", i, c];
    if (self.dp[key]) {
        return [self.dp[key] integerValue];
    }
    self.dp[key] = @(MAX([self knapsack:v weight:w capacity:c-[w[i] integerValue] idx:i+1] + [v[i] integerValue],
                       [self knapsack:v weight:w capacity:c idx:i+1]));
    return [self.dp[key] integerValue];
}

/*
 Given letters a to z are mapped to number 1 to 26. Write a method to decode a given number T and returns total number of possible original messages.
 For example, t=12 => a(1), b(2), l(12) => 3
 t=011 => 0 since 0 doesn't map to ant letter
 t=1234 => 1,2,3,4,12,23 (34 is not a valid number) => 6
 */

- (void)decodeMessageSetup {
    NSString *message = @"1";
    NSLog(@"Given %@, ans=1, received %ld", message, [self decodeIterative:message]);
    message = @"12";
    NSLog(@"Given %@, ans=3, received %ld", message, [self decodeIterative:message]);
    message = @"123";
    NSLog(@"Given %@, ans=5, received %ld", message, [self decodeIterative:message]);
    message = @"111";
    NSLog(@"Given %@, ans=5, received %ld", message, [self decodeIterative:message]);
    message = @"101";
    NSLog(@"Given %@, ans=3, received %ld", message, [self decodeIterative:message]);
    message = @"";
    NSLog(@"Given %@, ans=1, received %ld", message, [self decodeIterative:message]);
}

/*
 1. Simplify problem to 2 digits. 2 scenarios: Check if 1st digit is valid 1<=n<=2 and 1st & 2nd digits are valid
 2. Base case: empty character
 3. Recursive call either curr[i]+[recur[i+1] remaining] or curr[i,i+1]+[recur[i+2] remaining]
 
 */

- (NSInteger)decodeMessage:(NSString *)m {
    self.dp = [NSMutableDictionary new];
    return [self decode:m idx:0];
}

- (NSInteger)decode:(NSString *)m idx:(NSInteger)i {
    if (i >= m.length) {
        return 1;
    }
    NSInteger sum = 0;
    // 1st digit
    NSLog(@"d1: %d", [m characterAtIndex:i]-'0');
    if ([m characterAtIndex:i] >= '1' && [m characterAtIndex:i] <= '9') {
        sum++;
//        NSLog(@"sum1: %ld", sum);
        if (i+1<m.length) {
            int digits = ([m characterAtIndex:i]-'0')*10 + ([m characterAtIndex:i+1]-'0');
            NSLog(@"d3: %d", digits);
            // Combined first 2 digits
            if (digits<=26) {
                sum++;
//                NSLog(@"sum12: %ld", sum);
            }
            sum += [self decode:m idx:i+1];
//            NSLog(@"final: %ld", sum);
        }
    }
    return sum;
}

- (NSInteger)decodeIterative:(NSString *)m {
    int sum = 0;
    if (m.length == 0) {
        return 1;
    }
    for (int i=0; i<m.length; i++) {
        if ([m characterAtIndex:i] >= '1' && [m characterAtIndex:i] <= '9') {
            sum++;
            if (i+1<m.length) {
                int digits = ([m characterAtIndex:i]-'0')*10 + ([m characterAtIndex:i+1]-'0');
                if (digits <= 26) {
                    sum++;
                }
            }
        }
//        Consider 101 -> 1, 10, 1. Should return sum right away when encounter a 0?
//        If only 011 is consider as invalid, should check 0 at the beginning
//        else if ([m characterAtIndex:i] == '0') {
//            return sum;
//        }
    }
    return sum;
}



@end
