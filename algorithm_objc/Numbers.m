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
//    [self isNumberSetup];
//    [self convertStringToNumberSetup];
//    [self parseIntToStringSetup];
//    [self moveZeroesToEndSetup];
    [self setupPrintWordsFromPhoneNumber];
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
        number = (number*10.0) - (int)(number*10.0);
        number = number / 10;
        NSLog(@"%d, %d", digit, number);
    }
    double num = 0.2045;
    while (num != 0) {
        int d = fmod(num*10, 10);
        num = (num*10.0) - d;
        NSLog(@"%d, %.5f", d, num);
    }
    number = 10;
    NSLog(@"f: %.2f", [self getFactor:number]);
    number = 101;
    NSLog(@"f: %.2f", [self getFactor:number]);
    number = 222;
    NSLog(@"f: %.2f", [self getFactor:number]);
    number = 1022340;
    NSLog(@"f: %.2f", [self getFactor:number]);
    
    double digits = [self getFactor:number];
    while (digits > 0) {
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
    if (string == nil || string.length == 0) {
        return 0;
    }
    unichar sign = [string characterAtIndex:0];
    int start = 0;
    if (sign == '+' || sign == '-') {
        start = 1;
    }
    NSInteger number = 0;
    for (int i=start; i<string.length; i++) {
        unichar letter = [string characterAtIndex:i];
        if (letter<'0' || letter>'9') {
            return 0;
        }
        else {
            NSInteger digit = letter - '0';
            // 0*10+1=1
            // 1*10+2=12
            // 12*10+3=123
            number = number * 10 + digit;
        }
    }
    return sign == '-' ? -number : number;
}

- (void)isNumberSetup {
    //Not numbers:
    NSString *number = @"xxu911";
//    printf("%s is number? %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");
//    number = @"3.484393.9384-332";
//    printf("%s is number? %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");
//    //"33,88"
//    number = @"3.14";
//    printf("%s is number? %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");
//    number = @"+99993.14";
//    printf("%s is number? %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");
//    number = @"+";
//    printf("%s is number? %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");
    number = @"1,000,";
    printf("%s is number? %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");
    number = @"100,00";
    printf("%s is number? %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");
    number = @"1,000,000";
    printf("%s is number? %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");
    number = @"10000,0";
    printf("%s is number? %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");
    number = @"1,0";
    printf("%s is number? %s\n", [number UTF8String], [self isNumber:number]? "YES" : "NO");

//    3,14
//    44.00
//    44,00
//Numbers:
//    "383"
//    "-3448"
}

- (BOOL)isNumber:(NSString *)string {
    if (string == nil || string.length == 0) {
        return NO;
    }
    unichar sign = [string characterAtIndex:0];
    int start = 0;
    if (sign == '+' || sign == '-') {
        if (string.length==1) {
            return NO;
        }
        start = 1;
    }
    BOOL decimal = NO;
    BOOL comma = NO;
    int offset = start;
    // If string is only + or -, this will return YES!! So needs to take edge cases
    for (int i=start; i<string.length; i++) {
        unichar letter = [string characterAtIndex:i];
        if (letter == '.') {
            if (decimal == NO) {
                decimal = YES;
            }
            else {
                return NO;
            }
        }
        else if (letter == ',') {
            // first comma
            if (comma == NO) {
                if (i-start>3) {
                    return NO;
                }
                else {
                    comma = YES;
                    offset = i+1;
                }
            }
            else {
                if (i-offset != 3) {
                    return NO;
                }
                else {
                    offset = i+1;
                }
            }
        }
        else if (letter<'0' || letter>'9') {
            return NO;
        }
    }
    // Need to take care of edge cases "100," "1,000,0" etc.
    return YES;
}

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
