//
//  Numbers.m
//  algorithm_objc
//
//  Created by Stephen Ling on 4/18/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import "Numbers.h"

@implementation Numbers

- (void)setup {
    // Case: number = 0, 1
    // Case: n=umber = negative
    // Case: number overflow or divided by 0
//    [self isHappyNumber:5 original:5];
//    int n=10;
//    printf("Fibonacci of %d = %d\n", n, [self fibonacci:n]);

    /*
    int n=10;
    printf("Fibonacci of %d = %d\n", n, [self fibonacciIterative:n]);
    n=0;
    printf("Fibonacci of %d = %d\n", n, [self fibonacciIterative:n]);
    n=1;
    printf("Fibonacci of %d = %d\n", n, [self fibonacciIterative:n]);
    n=2;
    printf("Fibonacci of %d = %d\n", n, [self fibonacciIterative:n]);
     */

//    [self printPhoneNumberWords];
    [self isNumberSetup];
//    [self convertStringToNumberSetup];
//    [self parseIntToStringSetup];
//    [self moveZeroesToEndSetup];
//    [self setupPrintWordsFromPhoneNumber];
//    [self addNumbersSetup];
//    [self extractDigits];
//    [self findElementSetup];
//    [self productOfArraySetup];
//    [self maxValueInSubarraysSetup];
}

/*
 Given an array of integers and a number k, where 1 <= k <= length of the array, compute the maximum values of each subarray of length k.
 For example, given array = [10, 5, 2, 7, 8, 7] and k = 3, we should get: [10, 7, 8, 8], since:
 10 = max(10, 5, 2)
 7 = max(5, 2, 7)
 8 = max(2, 7, 8)
 8 = max(7, 8, 7)
 Do this in O(n) time and O(k) space. You can modify the input array in-place and you do not need to store the results.
 You can simply print them out as you compute them.
 */
- (void)maxValueInSubarraysSetup {
    NSArray *array = @[@10, @5, @2, @7, @8, @7];
    NSLog(@"Expected: 10,7,8,8");
    [self maxValueInSubarrays:array size:3];
    
    array = @[@10, @2, @9, @7, @8, @7];
    NSLog(@"Expected: 10,9,9,8");
    [self maxValueInSubarrays:array size:3];
    
    array = @[@10, @5, @2, @7, @8, @7];
    NSLog(@"Expected: 10,7,8,8");
    [self maxValueInSubarrays:array size:3];
}

- (void)maxValueInSubarrays:(NSArray *)a size:(int)k {
    /*
     Use a queue to store the elements (index) up to k
     Set max in q[0]. If new number > max, replace it and clear existing elements
     Else add to q
     Preprocess first kth elements first
     */
    NSMutableArray *q = [NSMutableArray new];
    for (int i=0; i<k; i++) {
        if (q.count == 0) {
            [q addObject:@(i)];
        }
        else {
            if ([a[i] isGreaterThan:a[[q[0] intValue]]]) {
                [q removeAllObjects];
                q[0] = @(i);
            }
            else {
                // May need to compare each element until the one is larger than it
                int j=(int)q.count-1;
                while ([a[i] isGreaterThan:a[[q[j] intValue]]] ) {
                    [q removeObjectAtIndex:j--];
                }
                [q addObject:@(i)];
            }
        }
    }
    NSLog(@"preQ: %@", q);
    for (int i=k; i<a.count; i++) {
        // Print the max value
        printf("%d, ", [a[[q[0] intValue]] intValue]);
        // k=3, q[0]=0, i=3, i-k+1=1
        if ([q[0] intValue] < i-k+1) {
            [q removeObjectAtIndex:0];
        }
        if ([a[i] isGreaterThan:a[[q[0] intValue]]]) {
            [q removeAllObjects];
            q[0] = @(i);
        }
        else {
            // May need to compare each element until the one is larger than it
            int j=(int)q.count-1;
            while ([a[i] isGreaterThan:a[[q[j] intValue]]] ) {
                [q removeObjectAtIndex:j--];
            }
            [q addObject:@(i)];
        }
    }
    printf("%d\n", [a[[q[0] intValue]] intValue]);
}

// Uber Interview, 1/29/19
// Given an array of sorted integers.. the array might contain duplicates.
// Given another input integer input x, find the number of times x appears in the array.
//

/*
 4: 0,1,4,4,5,6,6,10 -> 2
 1: 1,1,1,1 -> 4
 2: 1,3,5,7 -> -1 (not found)

 Brute force:
 Traverse array from beginning until found x, then start counting. O(n)
 Use binary search and find the number. O(log n), worst case n (all elements are the same
 If not found return -1
 If found, search before and after from the current index
 Sum up both and return.
 */

- (void)findElementSetup {
    NSArray *a = @[@0,@1,@4,@4,@5,@6,@6,@10];
    NSLog(@"Count of 4 is 2, received: %ld", [self findElement:a num:4]);
    a = @[@0,@1,@4,@4,@5,@6,@6,@10];
    NSLog(@"Count of 9 is -1, received: %ld", [self findElement:a num:9]);
    a = @[@0,@0,@0,@0,@0,@0,@0,@0];
    NSLog(@"Count of 0 is 8, received: %ld", [self findElement:a num:0]);
    a = @[];
    NSLog(@"Count of empty is -1, received: %ld", [self findElement:a num:9]);
}

- (NSInteger)findElement:(NSArray *)a num:(int)x {
    NSInteger idx = [self binarySearch:a num:x];
    if (idx == -1) {
        return -1;
    }
    return [self countElements:a num:x start:0 end:idx] + [self countElements:a num:x start:idx+1 end:a.count-1];
}

- (NSInteger)binarySearch:(NSArray *)a num:(int)x {
    NSInteger start = 0;
    NSInteger end = a.count-1;
    
    while (start <= end) {
        NSInteger middle = start + (end-start) / 2;
        NSInteger val = [a[middle] intValue];
        if (x == val) {
            return middle;
        }
        if (x < val) {
            end = middle - 1;
        }
        else {
            start = start + 1;
        }
    }
    return -1;
}

- (NSInteger)countElements:(NSArray *)a num:(NSInteger)x start:(NSInteger)s end:(NSInteger)e {
    NSInteger count = 0;
    for (NSInteger i=s; i<=e; i++) {
        if ([a[i] intValue] == x) {
            count++;
        }
    }
    return count;
}

// Uber Interview, 1/29/19
// Given array of int sorted. Output array of sorted int of square
// 2,2,4,6 => 4,4,16,36
// -2, -1, 1, 3, 4
// [1,4] [1,9,16]
//
//- (NSArray *)returnSortedArray:(NSArray *)a {
//    NSMutableArray *t1 = [NSMArray new];
//    NSMutableArray *t2 = [NSMArray new];
//    // O(a.count)
//    for (NSNumber *n in a) {
//        if (n < 0) {
//            [t1 insertObject:n*n atIndex:0];
//        }
//        else {
//            [t1 addObject:n*n];
//        }
//    }
//    // Merge sort n*log(n) + n = n*(log n + 1) O(n log(n))
//    return [self sortArrays:t1 array:t2];
//}

/*
 Given an array of integers, return a new array such that each element at index i of the new array is the product of all the numbers in the original array except the one at i.
 
 For example, if our input was [1, 2, 3, 4, 5], the expected output would be [120, 60, 40, 30, 24]. If our input was [3, 2, 1], the expected output would be [2, 3, 6].
 
 Follow-up: what if you can't use division?
 */

- (void)productOfArraySetup {
    NSArray *a = @[@1, @2, @3, @4];
    NSLog(@"Expected: 24, 12, 8, 6, get: %@", [self productOfArray:a]);
    
    a = @[@1, @2, @3, @4, @5];
    NSLog(@"Expected: 120, 60, 40, 30 ,24, get: %@", [self productOfArray:a]);
    
    a = @[@3, @2, @1];
    NSLog(@"Expected: 2, 3, 6, get: %@", [self productOfArray:a]);
    
    a = @[];
    NSLog(@"Expected: 0. get: %@", [self productOfArray:a]);
    
    a = @[@9];
    NSLog(@"Expected: 0. get: %@", [self productOfArray:a]);
}

/*
 Naive approach: Traverse all elements once and obtain the product. Traverse again and divide the product by that element
 1x2x3=6 -> 6/3, 6/2, 6/1 -> 2, 3, 6. O(n)
 What if element is 0? Don't divide it
 
 No division approach:
 For each element, traverse all elements except itself to calculate the product. O(n^2)
    5 7 9
  5 1 7 9 -> 63
  7 5 1 9 -> 45
  9 5 7 1 -> 35
 
 1,2,3,4
 for each elements
  product * current
 product without current
 prefx * suffix
 p:0  1  2 6
 s:24 12 4 1
 24, 12, 8, 6
 */

- (NSArray *)productOfArray:(NSArray *)a {
    if (a.count <= 1) {
        return @[@0];
    }
    NSMutableArray *res = [NSMutableArray new];
    [res addObject:@1];
    NSInteger prefix = 1;
    NSInteger suffix = 1;
    for (int i=1; i<a.count; i++) {
        prefix *= [a[i-1] intValue];
//        NSLog(@"prefx: %ld", prefix);
        [res addObject:@(prefix)];
    }
    for (int i=a.count-2; i>=0; i--) {
        suffix *= [a[i+1] intValue];
//        NSLog(@"suffix: %ld", suffix);
        res[i] = @([res[i] intValue] * suffix);
    }
    return res;
}


- (void)addNumbersSetup {
    NSString *n1 = @"101";
    NSString *n2 = @"100";
    NSLog(@"Sume of %@ & %@ = %@", n1, n2, [self addNumbers:n1 number:n2 base:2]);
    
    n1 = @"10111";
    n2 = @"111";
    NSLog(@"Sum of %@ & %@ = %@", n1, n2, [self addNumbers:n1 number:n2 base:2]);
    
    n1 = @"11";
    n2 = @"11";
    NSLog(@"Sum of %@ & %@ = %@", n1, n2, [self addNumbers:n1 number:n2 base:2]);
    
    n1 = @"25";
    n2 = @"1996";
    NSLog(@"Sum of %@ & %@ = %@", n1, n2, [self addNumbers:n1 number:n2 base:10]);
    
    n1 = @"999";
    n2 = @"9999";
    NSLog(@"Sum of %@ & %@ = %@", n1, n2, [self addNumbers:n1 number:n2 base:10]);
}

/*
 1. Numbers could be different length or empty
 2. Starts from right to left to the shorter number, add each digit and store overflow digit
 3. Easy messed up the index of n1 and n2 since they both start different from right
 4. When done, check for overflow digit and add it to the result string
 */
- (NSString *)addNumbers:(NSString *)n1 number:(NSString *)n2 base:(int)base {
    NSString *result = [NSString new];
    int current = 0;
    int overflow = 0;
    int i1 = (int)n1.length-1;
    int i2 = (int)n2.length-1;
    int start = i1 > i2 ? i1 : i2;
    while (start>=0) {
        int d1 = i1 < n1.length ? [n1 characterAtIndex:i1--] - '0' : 0;
        int d2 = i2 < n2.length ? [n2 characterAtIndex:i2--] - '0' : 0;
        // current = (d1+d2+overflow)%base; overflow = (int)((d1+d2+overflow)/base)
        // (8+4)%10 = 2; (int)((8+4)/10) = 1
        current = (d1 + d2 + overflow) % base;
        overflow = (d1 + d2 + overflow) / base;
//        NSLog(@"c:%d, o:%d", current, overflow);
        result = [NSString stringWithFormat:@"%@%@", @(current), result];
        start--;
    }
    if (overflow > 0) {
        result = [NSString stringWithFormat:@"%@%@", @(overflow), result];
    }
    return result;
}

- (BOOL)isHappyNumber:(NSUInteger)number original:(NSUInteger)original {
    
    if (number == 1) {
        NSLog(@"Happy: %lu", (long int)number);
        return YES;
    }
    else {
        NSUInteger sum = 0;
        while (number > 0) {
            NSUInteger lastDigit = number%10;
            sum += lastDigit*lastDigit;
            NSLog(@"%lu, %lu", (long int)lastDigit, (long int)sum);
            number = number/10;
        }
        if (number == original) {
            NSLog(@"Unhappy: %lu", (long int)number);
            return NO;
        }
        else {
            NSLog(@"%lu", (long int)sum);
            [self isHappyNumber:sum original:original];
        }
    }
    return NO;
}

- (int)fibonacci:(int)n {
    int *fib1 = malloc(sizeof(int)*(n+1));

    for (int i=0; i<=n; i++) {
        fib1[i] = 0;
    }
    [self fibArray2:n array:fib1];

    for (int i=0; i<=n; i++) {
        printf("%d ", fib1[i]);
    }
    printf("\n");

    /*
    if (n <= 1) {
        return n;
    }
    int *fib = malloc(sizeof(int)*(n+1));
    for (int i=0; i<=n; i++) {
        fib[i] = -1;
    }
    fib[0] = 0;
    fib[1] = 1;
//    [self fibArray:n array:fib];
    [self fibArrayIterative:n array:fib];
    for (int i=0; i<=n; i++) {
        printf("%d ", fib[i]);
    }
    printf("\n");
    return fib[n];
     */
    return fib1[n];
}

- (int)fibArray:(int)n array:(int *)fib {
    if (fib[n-2] == -1) {
        [self fibArray:n-2 array:fib];
    }
    if (fib[n-1] == -1) {
        [self fibArray:n-1 array:fib];
    }
    fib[n] = fib[n-2]+fib[n-1];
    return fib[n];
}

/* Better code */
- (int)fibArray2:(int)n array:(int *)fib {
    if (n <= 1) {
        return n;
    }
    if (fib[n] == 0) {
        fib[n] = [self fibArray2:n-1 array:fib] + [self fibArray2:n-2 array:fib];
    }
    return fib[n];
}

- (int)fibArrayIterative:(int)n array:(int *)fib {
    for (int i=2; i<=n; i++) {
        fib[i] = fib[i-1] + fib[i-2];
        printf("f%d=%d\n", i, fib[i]);
        if (fib[i-2] == -1) {
            fib[i-2] = fib[i-1];
        }
        if (fib[i-1] == -1) {
            fib[i-1] = fib[i];
        }
    }
    return fib[n];
}

- (int)fibonacciIterative:(int)n {
    if (n <= 1) {
        printf("%d\n", n);
        return n;
    }
    // f(n) = f(n-1) + f(n-2)
    // Shift f(n-1) and f(n-2)
    // f(n-2) = f(n-1)
    // f(n-1) = f(n)
    int f1 = 1;
    int f2 = 0;
    int f = 0;
    printf("%d %d ", f2, f1);
    for (int i=2; i<=n; i++) {
        f = f1 + f2;
        printf("%d ", f);
        f2 = f1;
        f1 = f;
    }
    printf("\n");
    return f;
}

/*
 Generate all possible 10 digit phone numbers and corresponding "words". Words are formed by using any of the letters corresponding to each digit of the phone number.
 
 e.g. The number 2222222222 maps to the word AAAAAAAAAA. It also maps to the word BBBBBBBBBB, ABCAAAABBCA, etc.
 
 Here's what the keypad looks like:
 
 1     2     3
      ABC   DEF
 
 4     5     6
GHI   JKL   MNO
 
 7     8     9
PQRS  TUV   WXYZ
 
       0
 
 Expected output
 
 Your program takes no input and prints a great number of lines. These output of your program would look something like the following (… implies some missing lines.)
 
 111 222 1234 AAA  ADG
 111 222 1234 AAA  AEG
 111 222 1234 AAA  AFG
 ...
 234 555 7777 ADG JJL PPQS
 234 555 7777 BDG KJL PPQS
 ...
 244 666 8888 CGG MMM TUVT
 ...
 888 777 5234 ............
 ....
 ....
 NOTES
 
 Some digits on the keypad do not have letters associated with them. Skip all phone numbers containing such digits—they should not occur in your output.
 You must print an exhaustive list. All printed lines must be unique (no duplicates.) However, the order in which the lines are printed does NOT matter.
 You do not have to print the spaces between the digits or letters as shown in the sample output–I've grouped them into runs of 3 or 4 characters to make it easier for us to read. It's totally OK for if there is no whitespace in the lines you print (e.g. a line like 2345557777ADGJJLPPQS is perfectly acceptable.)
 */

- (void)setupPrintWordsFromPhoneNumber {
    NSSet<NSString *> *expected = [NSSet setWithObjects:@"AA", @"AB", @"BA", @"BB", nil];
    [self generateWordsFromPhoneNumbers:@2];
}

/*
 Algorithm:
 1. Create a dictionary that maps number to characters
 2. For each digit, get all the characters associate with it and traverse the next digit
 3. When reaches the end. returns
 
 */

- (void)generateWordsFromPhoneNumbers:(NSNumber *)digit {
    NSDictionary *word = @{@1: @"", @2:@"ABC", @3: @"DEF", @4: @"GHI", @5: @"JKL", @6: @"MNO", @7: @"PQRS", @8: @"TUV", @9: @"WXYZ", @0: @""};
    
}

- (void)generateWords:(NSNumber *)digit words:(NSDictionary *)words {
    
}

- (void)extractDigits {
    int number = 12345;
    while (number != 0) {
        int digit = fmod(number, 10.0);
//        number = (number*10.0) - (int)(number*10.0);
        number = number / 10;
        NSLog(@"%d, %d", digit, number);
    }
    
//    double num = 0.2045;
//    while (num != 0) {
//        int d = fmod(num*10, 10);
//        num = (num*10.0) - d;
//        NSLog(@"%d, %.5f", d, num);
//    }
    number = 10;
    NSLog(@"f: %.2f", [self getFactor:number]);
    number = 101;
    NSLog(@"f: %.2f", [self getFactor:number]);
    number = 222;
    NSLog(@"f: %.2f", [self getFactor:number]);
    number = 1022340;
    NSLog(@"f: %.2f", [self getFactor:number]);
    
    // Digit = numbers of significant. 1,022,340 = 7
    double digits = [self getFactor:number];
    while (digits > 0) {
//        123 % 10 = 3
//        223 % 100 = 23
        // 10^6 = 1,000,000
        // 567 - 567 % 100 = 567 - 67 = 500 => 500 / 100 = 5
        int d = (number - fmod(number, pow(10, digits-1))) / pow(10, digits-1);
        number = number - pow(10, digits-1) * d;
        NSLog(@"d: %d n: %d, f:%.2f", d, number, digits--);
    }
}

- (double)getFactor:(int)number {
    double digit = 0;
    while (number >= 1) {
        number /= 10;
        digit++;
    }
    return digit;
}

- (void)printPhoneNumberWords {
    NSArray *words = @[@"", @"", @"abc", @"def", @"ghi", @"jkl", @"mno", @"pqrs", @"tuv", @"wxyz"];
    NSString *test = @"001";
    [self depthFirstTraverse:test index:0 words:words result:@""];

    // Generate all combinations of numbers. Can't handle more than 5 digits
    NSArray *numbers = [self createNumbers:0 size:3 number:@"" numbers:[NSArray new]];
    for (NSString *number in numbers) {
        printf("%s\n", [number UTF8String]);
        [self depthFirstTraverse:number index:0 words:words result:@""];
    }
}

- (NSArray *)createNumbers:(NSUInteger)digit size:(NSUInteger)size number:(NSString *)number numbers:(NSArray *)numbers {
    if (digit == size) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:numbers];
        [array addObject:number];
        //printf("%s\n", [number UTF8String]);
        return array;
    }
    for (NSUInteger i=0; i<10; i++) {
        NSString *newNumber = [NSString stringWithFormat:@"%@%ld", number, i];
        numbers = [self createNumbers:digit+1 size:size number:newNumber numbers:numbers];
    }
    return numbers;
}

-(void)depthFirstTraverse:(NSString *)number index:(NSUInteger)index words:(NSArray *)words result:(NSString *)result {
    if (index == number.length) {
        if (result.length>0) {
            printf("%s\n", [result UTF8String]);
        }
        return;
    }
    NSInteger n = [number characterAtIndex:index] - '0';
    NSString *letters = [words objectAtIndex:n];
    if (letters.length>0) {
        for (NSUInteger i=0; i<letters.length-1; i++) {
            NSString *newResult = [NSString stringWithFormat:@"%@%c", result, [letters characterAtIndex:i]];
            [self depthFirstTraverse:number index:index+1 words:words result:newResult];
        }
    }
    else {
        [self depthFirstTraverse:number index:index+1 words:words result:result];
    }
    return;
}

- (void)convertStringToNumberSetup {
    NSString *num = @"-290";
    printf("String %s ->Int %ld\n", [num UTF8String], [self convertStringToNumber:num]);
    num = @"+001";
    printf("String %s ->Int %ld\n", [num UTF8String], [self convertStringToNumber:num]);
    num = @"-0a01";
    printf("String %s ->Int %ld\n", [num UTF8String], [self convertStringToNumber:num]);
    num = @"0a01";
    printf("String %s ->Int %ld\n", [num UTF8String], [self convertStringToNumber:num]);
    num = @"";
    printf("String %s ->Int %ld\n", [num UTF8String], [self convertStringToNumber:num]);
}

- (NSInteger)convertStringToNumber:(NSString *)string {
    // Return 0 for an emopty string
    if (string == nil || string.length == 0) {
        return 0;
    }
    // Extract the first char to look for +/-
    // Assume string can contain non-numeric characters. Return 0 if that's the case
    unichar sign = [string characterAtIndex:0];
    int start = 0;
    NSInteger num = 0;
    if (sign == '-' || sign == '+') {
        start = 1;
    }
    /*
     - Traverse from left to right
     - For each char, num*10+current digit
     12345
     0*1+1=1
     1*10+2=12
     12*10+3=123
     */
    for (int i=start; i<string.length; i++) {
        unichar c = [string characterAtIndex:i];
        if (c < '0' || c > '9') {
            return 0;
        }
        num = num * 10 + (c-'0');
    }
    return sign == '-' ? -num : num;
}


//- (NSInteger)convertStringToNumber:(NSString *)string {
//    if (string == nil || string.length == 0) {
//        return 0;
//    }
//    unichar sign = [string characterAtIndex:0];
//    int start = 0;
//    if (sign == '+' || sign == '-') {
//        start = 1;
//    }
//    NSInteger number = 0;
//    for (int i=start; i<string.length; i++) {
//        unichar letter = [string characterAtIndex:i];
//        if (letter<'0' || letter>'9') {
//            return 0;
//        }
//        else {
//            NSInteger digit = letter - '0';
//            // 0*10+1=1
//            // 1*10+2=12
//            // 12*10+3=123
//            number = number * 10 + digit;
//        }
//    }
//    return sign == '-' ? -number : number;
//}

- (void)isNumberSetup {
    //Not numbers:
	NSString *number = @"3.14";
	printf("%s is number? YES, %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");

    number = @"xxu911";
    printf("%s is number? NO, %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");
	
//    number = @"3.484393.9384-332";
//    printf("%s is number? NO, %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");

    number = @"+99993.14";
    printf("%s is number? YES, %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");
	
    number = @"+";
    printf("%s is number? NO, %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");

//    number = @"1,000,";
//    printf("%s is number? %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");
    number = @"100,00";
    printf("%s is number? NO, %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");
	
    number = @"1,000,000";
    printf("%s is number? YES, %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");
	
    number = @"10000,0";
    printf("%s is number? NO, %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");
	
    number = @"33,88";
    printf("%s is number? NO, %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");
/*
	Not numbers:
	"xxu911"
	"3.484393.9384-332"
    3,14
 	Numbers:
    44.00
    44,00
    "383"
    "-3448"
 */
}

- (BOOL)isNumber:(NSString *)string {
	BOOL hasDot = NO;
	BOOL hasComma = NO;

	/*
	 Starts from rightmost char. Here are rules and conditions:
	 - hasDot must comes before hasCommon: 12.3,000 no, 1,230.000 yes
	 - Can only has 1 dot
	 - If hasComma, needs to be consistent and check every 4th position
	 - Check sign at i=0
	 Only allowed symbols: + - , .
	 */
	for (NSInteger i=0; i<string.length; i++) {
		char c = [string characterAtIndex:string.length-i-1];
//		printf("%c", c);
		if (c == '.') {
			// Can only has 1 dot and comma has to come after dot exists
			if (hasDot || hasComma) {
				return NO;
			}
			hasDot = YES;
		}
		else if (c == ',') {
			if ((i+1)%4 != 0) {
				return NO;
			}
			hasComma = YES;
		}
		else if (i == string.length-1) {
			if (c < '0' || c > '9') {
				if (c == '+' || c == '-') {
					return YES;
				} else {
					return NO;
				}
			}
		}
		else if (c < '0' || c > '9') {
			return NO;
		}
	}
//	printf("\n");
	return YES;
}










//- (BOOL)isNumber:(NSString *)string {
//    if (string == nil || string.length == 0) {
//        return NO;
//    }
//    unichar sign = [string characterAtIndex:0];
//    int start = 0;
//    if (sign == '+' || sign == '-') {
//        if (string.length==1) {
//            return NO;
//        }
//        start = 1;
//    }
//    BOOL decimal = NO;
//    BOOL comma = NO;
//    int offset = start;
//    // If string is only + or -, this will return YES!! So needs to take edge cases
//    for (int i=start; i<string.length; i++) {
//        unichar letter = [string characterAtIndex:i];
//        if (letter == '.') {
//            if (decimal == NO) {
//                decimal = YES;
//            }
//            else {
//                return NO;
//            }
//        }
//        else if (letter == ',') {
//            // first comma
//            if (comma == NO) {
//                if (i-start>3) {
//                    return NO;
//                }
//                else {
//                    comma = YES;
//                    offset = i+1;
//                }
//            }
//            else {
//                if (i-offset != 3) {
//                    return NO;
//                }
//                else {
//                    offset = i+1;
//                }
//            }
//        }
//        else if (letter<'0' || letter>'9') {
//            return NO;
//        }
//    }
//    // Need to take care of edge cases "100," "1,000,0" etc.
//    return YES;
//}

- (void)parseIntToStringSetup {
    float n = 12.2304;
    int intpart = (int)n;
    float dec = fmodf(n*100, 100.0) / 100;
//    printf("int: %d, dec: %f\n", intpart, dec);
//    int number = 103;
//    printf("Int: %d -> %s\n", number, [[self parseIntToString:number] UTF8String]);
//    number = -123;
//    printf("Int: %d -> %s\n", number, [[self parseIntToString:number] UTF8String]);
//    number = 0;
//    printf("Int: %d -> %s\n", number, [[self parseIntToString:number] UTF8String]);
    
    float num = 12.304;
    printf("Float: %f -> %s\n", num, [[self parseFloatToString:num] UTF8String]);
    num = 0.023;
    printf("Float: %f -> %s\n", num, [[self parseFloatToString:num] UTF8String]);
    num = 0;
    printf("Float: %f -> %s\n", num, [[self parseFloatToString:num] UTF8String]);
    num = 99;
    printf("Float: %f -> %s\n", num, [[self parseFloatToString:num] UTF8String]);
}

- (NSString *)parseNumber:(float)number {
    NSString *num1 = [self parseIntToString:(int)number];
    if (number>0) {
        NSString *num2 = [self parseFloatToString:number];
        num1 = [num1 stringByAppendingString:[NSString stringWithFormat:@".%@", num2]];
    }
    return num1;
}

- (NSString *)parseIntToString:(int)number {
    NSString *string = [NSString new];
    BOOL negative = number<0? YES : NO;

    // 123 % 10 = 3, 123/10 = 12.3
    // 12 % 10 = 2, 12/10 = 1.2
    // 1%10 = 1, 1/10 = 0.1
    // Edge case: 0 % 10 = 0, 0/10=0
    //
    // float
    // 12.34-12=0.34
    // 12 % 10 = 2 12/10 = 1.2
    // 1 % 10 = 1 1/10 = 0.1
    // .04*10=0.4, 0.4%10 = 0, 0.4-0 = .4
    // .4*10=4, 4%10=4, 4-(int)(.4*10) = 0
    do {
        int digit = abs(number%10);
        string = [NSString stringWithFormat:@"%d%@", digit, string];
        number = number/10;
    } while (number != 0);

    if (negative) {
        string = [NSString stringWithFormat:@"-%@", string];
    }
    return string;
}

- (NSString *)parseFloatToString:(float)number {
    NSString *string = [NSString new];
    int digit = 0;
    int intpart = (int)number;
    BOOL decimal = NO;
    do {
        if (intpart>0) {
            digit = intpart % 10;
            intpart = intpart / 10;
            string = [NSString stringWithFormat:@"%d%@", digit, string];
        }
        else {
            if (decimal == NO) {
                if (string.length==0) {
                    string = @"0";
                }
                decimal = YES;
                string = [string stringByAppendingString:@"."];
            }
            digit = fmod(number*10, 10.0);
            number = (number*10.0) - (int)(number*10.0);
            string = [string stringByAppendingString:[NSString stringWithFormat:@"%d", digit]];
        }
    } while (number != 0.0);
    return string;
}

/*
 Questions to ask:
 1. Do we need to preserve original order?
 2. Are we allow to use auxillary storage?
 
 */

- (void)moveZeroesToEndSetup {
    NSArray <NSNumber *>*array = @[@1, @2, @0, @3, @0, @1, @2];
    NSLog(@"Counter: %@", [self moveZeroesUseCounter:[array mutableCopy]]);
    NSLog(@"Exchange: %@", [self moveZeroesUseExchange:[array mutableCopy]]);
    
    array = @[@1, @2, @0, @3, @0, @1, @0, @0];
    NSLog(@"Counter: %@", [self moveZeroesUseCounter:[array mutableCopy]]);
    NSLog(@"Exchange: %@", [self moveZeroesUseExchange:[array mutableCopy]]);

    array = @[@0,@0];
    NSLog(@"Counter: %@", [self moveZeroesUseCounter:[array mutableCopy]]);
    NSLog(@"Exchange: %@", [self moveZeroesUseExchange:[array mutableCopy]]);
}

- (NSArray <NSNumber *>*)moveZeroesUseCounter:(NSMutableArray <NSNumber *>*)array {
    NSUInteger zeros = 0;
    NSUInteger end = array.count;
    NSUInteger i=0;
    while (i < end) {
        if ([array[i] isEqualToNumber:@0]) {
            [array removeObjectAtIndex:i];
            end--;
            zeros++;
        }
        i++;
    }
    for (int i=0; i<zeros; i++) {
        [array addObject:@0];
    }
    return [array copy];
}

- (NSArray <NSNumber *>*)moveZeroesUseExchange:(NSMutableArray <NSNumber *>*)array {
    if (array.count <= 1) {
        return [array copy];
    }
    NSInteger end = array.count-1;
    for (NSUInteger i=array.count-1; i>0; i--) {
        if ([array[i] isEqualToNumber:@0]) {
            end--;
        }
        else {
            break;
        }
    }
    NSUInteger idx=0;
    while (idx <= end && end > 0 && idx < array.count) {
        //NSLog(@"%d, %d", idx, end);
        if ([array[idx] isEqualToNumber:@0]) {
            [array exchangeObjectAtIndex:idx withObjectAtIndex:end];
            end--;
        }
        idx++;
    }
    return [array copy];
}

@end
