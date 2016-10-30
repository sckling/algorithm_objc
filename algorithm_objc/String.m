//
//  String.m
//  algorithm_objc
//
//  Created by Stephen Ling on 2/27/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import "String.h"

@implementation String

- (void)setup {
    NSString *string = @"abc";
//    NSLog(@"%lu", string.length);
//    NSLog(@"%c", [string characterAtIndex:2]);
//    
//    const char *c = [string UTF8String];
//    const char *c1 = [string cStringUsingEncoding:NSUTF16StringEncoding];
//    NSLog(@"char array %c", c[0]);
//    NSLog(@"char array %c", c[1]);
//    NSLog(@"char array %c%c,%c", c1[2], c1[3], c1[4]);
    
//    [self bracketPermutation:5];
//    [self bracketPermutation:6];
//    NSLog(@"String permutation: %@", [self stringPermutation:@"abc"]);
//    [self bracketPermutation:2 array:array];
    
//    [self isBracketsCountCorrectSetUp];
//    [self smallestCharInArraySetup];
    
    [self findCommonArraySetup];

    string =  @"{ac[bb]}";
    NSLog(@"Delimiter %@: %d", string, [self isDelimiterMatched:string stack:nil]);
    string = @"[dklf(df(kl))d]{}";
    NSLog(@"Delimiter %@: %d", string, [self isDelimiterMatched:string stack:nil]);
    string = @"{[[[]]]}";
    NSLog(@"Delimiter %@: %d", string, [self isDelimiterMatched:string stack:nil]);
    string = @"{3234[fd";
    NSLog(@"Delimiter %@: %d", string, [self isDelimiterMatched:string stack:nil]);
    string = @"{df][d}";
    NSLog(@"Delimiter %@: %d", string, [self isDelimiterMatched:string stack:nil]);
    string = @"{}]";
    NSLog(@"Delimiter %@: %d", string, [self isDelimiterMatched:string stack:nil]);
}

- (BOOL)isOpenDelimiter:(NSString *)string {
    if ([string isEqualToString:@"{"] || [string isEqualToString:@"["] || [string isEqualToString:@"("]) {
        return YES;
    }
    return NO;
}

- (BOOL)isCloseDelimiter:(NSString *)string {
    if ([string isEqualToString:@"}"] || [string isEqualToString:@"]"] || [string isEqualToString:@")"]) {
        return YES;
    }
    return NO;
}

- (BOOL)isMatchedDelimiter:(NSString *)openBracket close:(NSString *)closeBracket {
    if ([openBracket isEqualToString:@"{"] && [closeBracket isEqualToString:@"}"]) {
        return YES;
    }
    if ([openBracket isEqualToString:@"["] && [closeBracket isEqualToString:@"]"]) {
        return YES;
    }
    if ([openBracket isEqualToString:@"("] && [closeBracket isEqualToString:@")"]) {
        return YES;
    }
    return NO;
}

/*
 Loop through the string:
 - if the character is an open bracket, push it to stack
 - if the character is a close bracket, pop the stack and check if they matched. Return No if they don't or if stack is empty
 - Bypass non-bracket characters
 - When finished, if stack is not empty, that means there are still open brackets not cleared up. Return No
 
 Edge cases:
 - Empty string
 - A single bracket
 - String with no brackets
 */
- (BOOL)isDelimiterMatched:(NSString *)string stack:(NSMutableArray *)stack {
    if (stack == nil) {
        stack = [NSMutableArray arrayWithCapacity:string.length];
    }
    for (NSUInteger idx=0; idx<string.length; idx++) {
        NSString *character = [NSString stringWithFormat:@"%c", [string characterAtIndex:idx]];
        if ([self isOpenDelimiter:character]) {
            [stack addObject:character];
        }
        else if ([self isCloseDelimiter:character]) {
            // BUG: Stack could be empty!!
            if (stack.count==0) {
                return NO;
            }
            NSString *openBracket = [stack lastObject];
            if ([self isMatchedDelimiter:openBracket close:character]) {
                [stack removeLastObject];
            }
            else {
                return NO;
            }
        }
    }
    if (stack.count > 0) {
        return NO;
    }
    return YES;
}

- (void)smallestCharInArraySetup {
    NSString *string = @"cccffffjpv";
    NSLog(@"Character c->f: %c", [self smallestCharacterInString:string character:'c']);
    NSLog(@"Character f->j: %c", [self smallestCharacterInString:string character:'f']);
    NSLog(@"Character v->c: %c", [self smallestCharacterInString:string character:'v']);
    NSLog(@"Character a->c: %c", [self smallestCharacterInString:string character:'a']);
    NSLog(@"Character d->f: %c", [self smallestCharacterInString:string character:'d']);
    NSLog(@"Character u->v: %c", [self smallestCharacterInString:string character:'u']);
    NSLog(@"Character z->c: %c", [self smallestCharacterInString:string character:'z']);
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
//  1,2,3,4,5,6 <-2
- (unichar)smallestCharacterInString:(NSString *)string character:(unichar)character {
    // Case 1: use binary search and input character found, return the next larger character
    // Case 2: use binary search and input character not found, return the next larger character
    // Case 2 (no need): Use linear traverse of the string and find the next larger character smaller than input character
    // How to handle repeated character? Recursively search for next character that is not the same
    NSInteger idx = [self binarySearch:string character:character];
    //return idx >= string.length-1? [string characterAtIndex:0]: [string characterAtIndex:idx+1];
    return [self nextCharacter:string index:idx];
}

- (unichar)nextCharacter:(NSString *)string index:(NSInteger)index {
    // At the end of the string, no need to check next repeated character, return first character of the string
    if (index == string.length-1) {
        return [string characterAtIndex:0];
    }
    // Next character is same as current character, recursively search for next character
    if ([string characterAtIndex:index] == [string characterAtIndex:index+1]) {
        return [self nextCharacter:string index:index+1];
    }
    // Next character is not the same as current character, return next character
    return [string characterAtIndex:index+1];
}

- (NSInteger)binarySearch:(NSString *)string character:(unichar)character {
    NSInteger low = 0;
    NSInteger high = string.length - 1;
    NSInteger middle = 0;
    while (low <= high) {
        middle = low + (high-low)/2;
        if (character == [string characterAtIndex:middle]) {
            return middle;
        }
        if ([string characterAtIndex:middle] > character) {
            high = middle-1;
        }
        else {
            low = middle+1;
        }
    }
    //NSLog(@"low: %d, mid: %d, high: %d", low, middle, high);
    // Character not found
    // low: position to be inserted. Should return -(low+1) to handle low = 0; since low starts at 0 and we only increment it, it never goes to negative
    // high: next position to be inserted
    return high;
}


- (void)isBracketsCountCorrectSetUp {
    // Case1: (()) stack count 0, YES
    // Case2: ))(( NO
    // Case3: ()(  NO
    // Case4: ))(()) NO
    NSString *brackets = @"(()";
    NSLog(@"bracket count: %d", [self isBracketsCountCorrect:brackets]);
    brackets = @"(())";
    NSLog(@"(()): %d", [self isBracketsCountCorrectNoStack:brackets]);
    brackets = @"))((";
    NSLog(@"))((: %d", [self isBracketsCountCorrectNoStack:brackets]);
    brackets = @"()(";
    NSLog(@"()(: %d", [self isBracketsCountCorrectNoStack:brackets]);
    brackets = @"))(())";
    NSLog(@"))(()): %d", [self isBracketsCountCorrectNoStack:brackets]);
}

// Nest Lab
// Given a string of brackets “((()))()()”, find if it is correct.
// It is correct if for every opening bracket there is a closing bracket and the opening bracket comes before the closing one.
//
// Input format is NSString - does it contain other characters other than ()?
// Particular size of the string?
// Return boolean YES/NO?
//
// Case1: (()) stack count 0, YES
// Case2: ))(( NO
// Case3: ()(  NO
// Case4: (()()) YES

- (BOOL)isBracketsCountCorrect:(NSString *)string {
    NSMutableArray *stack = [NSMutableArray new];
    
    for (NSUInteger idx=0; idx<string.length; idx++) {
        NSString *character = [NSString stringWithFormat:@"%c", [string characterAtIndex:idx]];
        if ([character isEqualToString:@"("]) {
            [stack addObject:character];
        }
        else {
            if (stack.count == 0) {
                return NO;
            }
            if (stack.count > 0) {
                [stack removeObjectAtIndex:0];
            }
        }
    }
    return stack.count == 0? YES : NO;
}

- (BOOL)isBracketsCountCorrectNoStack:(NSString *)string {
    if (string == nil || string.length == 0) {
        return NO;
    }
    NSInteger openBracket = 0;
    
    for (NSUInteger idx=0; idx<string.length; idx++) {
        unichar character = [string characterAtIndex:idx];
        if (character == '(') {
            openBracket++;
        }
        else {
            if (openBracket == 0) {
                return NO;
            }
            openBracket--;
        }
    }
    return openBracket == 0? YES: NO;
}

// Hulu
// 1: [()]
// 2: ["(())", "()()"]
// 3: [((())), (())(), ()(()), (()()), ...]
// Input: positive integer
// Output: NSArray: each element contains a string of () permutations
// Needs to be valid open/close brackets (), invalid: )()(

/* original solution
- (NSArray *)bracketPermutation:(NSUInteger)number array:(NSMutableArray *)array {
    if (number == 0) {
        return array;
    }
    NSString *brackets = nil;
    while (number > 0) {
        NSString *string = nil;
        if (number == 1) {
            string = [self buildPermutatString];
        }
        else {
            string = [NSString stringwithFormat:@"%@, ", [self buildPermutatString]];
        }
        brackets = [brackets stringByAppendingString:string];
    }
    [array addObject:brackets];
    return [self bracketPermutation:number-1 array:array]
}
*/

/*
 ()()->(())
 ()()()->(),()()->( () )()->() () ()->()( () )
 ->(),(())->( () ())->(( () ))->(() () )
 
 Use NSSet instead of NSArray to remove duplicate entries
 Test case 1: odd number brackets
 Test case 2: non-bracket character
 */
- (void)bracketPermutation:(NSUInteger)number {
    if (![self isEvenNumber:number]) {
        return;
    }
    NSMutableString *brackets = [NSMutableString stringWithCapacity:number+1];
    for (NSUInteger i=0; i<number; i++) {
        if ([self isEvenNumber:i]) {
            [brackets insertString:@"(" atIndex:i];
        }
        else {
            [brackets insertString:@")" atIndex:i];
        }
    }
    NSLog(@"Brackets: %@", [self permutateBrackets:brackets]);
}

- (NSSet *)permutateBrackets:(NSString *)brackets {
    if (brackets.length<=2) {
        return [NSSet setWithObject:brackets];
    }
    NSString *firstBrackets = [brackets substringWithRange:NSMakeRange(0, 2)];
    NSString *remainingBrackets = [brackets substringWithRange:NSMakeRange(2, brackets.length-2)];
    NSSet *previousBrackets = [self permutateBrackets:remainingBrackets];
    NSMutableSet *newBrackets = [NSMutableSet new];
    for (NSString *bracketSet in previousBrackets) {
        for (NSUInteger i=0; i<bracketSet.length; i++) {
            NSMutableString *newBracket = [NSMutableString stringWithString:bracketSet];
            [newBracket insertString:firstBrackets atIndex:i];
            [newBrackets addObject:newBracket];
        }
    }
    return newBrackets;
}

- (BOOL)isEvenNumber:(NSUInteger)number {
    return number%2==0? YES : NO;
}

/*
 abc->a,bc->b,c->bc,cd->abc,bac,bca;acd,cad,cda
 
 Test case 1: empty string
 Test case 2: string with 1 element
 Test case 3: stirng with spaces
 Test case 4: string size exceed array size
 
 */
- (NSArray *)stringPermutation:(NSString *)string {
    if (string.length <= 1) {
        return [NSArray arrayWithObject:string];
    }
    NSString *firstChar = [string substringWithRange:NSMakeRange(0, 1)];
    NSString *remainingString = [string substringWithRange:NSMakeRange(1, string.length-1)];
    NSArray *previousStrings = [self stringPermutation:remainingString];
    NSMutableArray *newStrings = [NSMutableArray new];
    for (NSString *pString in previousStrings) {
        for (NSUInteger i=0; i<=pString.length; i++) {
            NSMutableString *newString = [NSMutableString stringWithString:pString];
            [newString insertString:firstChar atIndex:i];
            [newStrings addObject:newString];
        }
    }
    return newStrings;
}

// apple, banana, orange
// Test case 1: empty string
// Test case 2: single word
// Test case 3: no matching word
// Test case 4: words with punctuation before or after
// Test case 5: upper and lower cases

- (void)filterWordSetup {
    NSMutableSet *set = [[NSMutableSet alloc] initWithArray:@[@"apple", @"banana", @"oranage"]];
    [self filterWords:@"#banana this is an Apple!" set:set];
    [self filterWords:@"apple" set:set];
    [self filterWords:@"hello world" set:set];
}

- (void)filterWords:(NSString *)string set:(NSSet *)set {
    NSMutableString *stringBuffer = [NSMutableString new];
    for (NSUInteger idx=0; idx<string.length; idx++) {
        unichar character = [string characterAtIndex:idx];
        if ([self isAlphabet:character]) {
            [stringBuffer appendString:[NSString stringWithFormat:@"%c", character]];
        }
        else {
            [self printWord:stringBuffer set:set];
            printf("%c", character);
            stringBuffer = [NSMutableString new];
        }
    }
    if (stringBuffer.length > 0) {
        [self printWord:stringBuffer set:set];
    }
    printf("\n");
}

- (BOOL)isAlphabet:(unichar)character {
    if ((character >= 'a' && character <= 'z') || (character >= 'A' && character <= 'Z')) {
        return YES;
    }
    return NO;
}

- (void)printWord:(NSString *)string set:(NSSet *)set {
    NSString *lowercaseString = [string lowercaseString];
    if ([set containsObject:lowercaseString]) {
        for (NSUInteger idx=0; idx<string.length; idx++) {
            printf("*");
        }
    }
    else {
        printf("%s", [string UTF8String]);
    }
}

// anagram: today is the best day; yad

/* Amazon 11/16/12
 http://collabedit.com/x7jj5
 
 1. Add first string (assume words are unsorted) into a binary search tree O(n)
 2. Compare each word in the second string to the binary search tree O(n log(n))
 
 Given two strings, return a single list of words common to both strings.
 A fox jumped a blue fox.
 A fox jumped a red fox.
 => a, fox, jumped
 
- (NSArray *)commonWord(NSString *)string1: (NSString *)string2
{
    NSArray *words1 = [string1 componentsSeparatedByString:@" "];
    NSArray *words2 = [string1 componentsSeparatedByString:@" "];
    NSMutableDictionery *wordStacks = [NSMutableDictionery dictionery];
    NSMutableArray *finalOutput = [NSMutableArray array];

    while (NSString *string in words1) {
        [wordStacks setObject:1 forKey:string];
    }

    while (NSString *string in words2) {
        if ([wordStacks objectForKey:string]) {
            [finalOutput addObject:string];
        }
    }
    return (NSArray *)finalOutput;
}

 A hash table has O(1) performance in the best case. The majority of the work in implementing a hash table is ensuring that this best case is also the average case by choosing a good hash function that minimizes collisions. However, it is more informative to say that the average expected performance of a hash table is somewhere between O(1) and O(log N) with a good hash function, and there is a strong bias toward O(1).
 
 The worst case for a hash table is O(N), and there is no way to avoid the worst case using a basic hash table. If guaranteed good performance is required then a more suitable structure should be used, such as a deterministic skip list or balanced binary search tree.

 */

- (NSString *)commonWords:(NSString *)firstString string:(NSString *)secondString {
    // If either string is empty, there won't be common words
    if (firstString.length == 0 || secondString.length == 0) {
        return nil;
    }
    NSArray *words1 = [firstString componentsSeparatedByString:@" "];
    NSArray *words2 = [secondString componentsSeparatedByString:@" "];
    NSMutableSet *wordSet = [NSMutableSet new];
    NSString *finalString = [NSString new];
    
    for (NSString *word in words1) {
        [wordSet addObject:word];
    }
    for (NSString *word in words2) {
        if ([wordSet containsObject:word]){
            finalString = [finalString stringByAppendingFormat:@"%@ ", word];
            // remove word in set to prevent duplicate count
            [wordSet removeObject:word];
            if (wordSet.count == 0) {
                break;
            }
        }
    }
    return finalString;
}

//In our app, we have a special reward for users who are active a lot. We give this reward to any users who have used the app on three different days in the past five days.

// Call this method everything time the app launche from fresh or from background
// Audible, 6/28/16
- (void)checkUserReward {
    // Current time stamp
    // day[0] = 070116
    // day[1] = 070216
    /*
    NSMutableArray *usage = [NSUserDefaults default[@"usage"]];
    NSDate *date = [NSDate today];
    [usage addObject:date];
    [NSUserDefaults save[@"usage": usage]];
    
    // Count=5, check element=4
    NSDate *date1 = [usage popLastElement];
    NSDate *date2 = [usage popLastElement];
    NSDate *date3 = [usage popLastElement];
    // date1 is today so date1 and date can only be less or equal to 3 days apart
    
    NSUInteger firstTwoDatesCount = [date1 dayCountFromDate:date2];
    if (firstTwoDatesCount <= 3) {
        // if 3 days apart, date2-date3 has to be 1
        // if 2 days apart, date2-date3 has to be <=2
        // if 1 days apart, date2-date3 has to be <=3
        if (firstTwoDatesCount == 1) {
            if ([date2 dayCountFromDate:date3] <= 3) }
            [self rewardUser];
        }
    }
     */
}

// Given two sorted arrays, find the common elements
// 1,2,5,6,10
// 2,5,10
// return 2,5
//
// Edge cases:
// Zero or one element
// No common elements
// Identical arrays

- (void)findCommonArraySetup {
    NSArray<NSNumber *> *a1 = @[@1, @5, @10, @20, @40, @80];
    NSArray<NSNumber *> *a2 = @[@6, @7, @20, @80, @100];
    NSLog(@"Common elements: %@", [self findCommonElements:a1 array:a2]);
}

- (NSArray<NSNumber *> *)findCommonElements:(NSArray<NSNumber *> *)a1 array:(NSArray<NSNumber *> *)a2 {
    NSUInteger idx1 = 0;
    NSUInteger idx2 = 0;
    NSMutableArray<NSNumber *> *commons = [NSMutableArray new];
    while (idx1<a1.count && idx2<a2.count) {
        if ([a1[idx1] isEqualToNumber:a2[idx2]]) {
            [commons addObject:a1[idx1]];
            idx1++;
            idx2++;
        }
        else if ([a1[idx1] isGreaterThan:a2[idx2]]) {
            idx2++;
        }
        else {
            idx1++;
        }
    }
    return commons;
}

- (NSUInteger)dayCountFromDate:(NSDate *)date1 {
    // Assume format is ddMMyyyy
    // Convert date to absolute second value and convert it back to number of day
    return 0;
}

// Method that rewards user
- (void)rewardUser {
    
}

//[self formRansomNote:@"a ransom note a" magazineContent:@"a note seems to be a ransom thing"];

- (void)formRansomNote:(NSString *)noteString magazineContent:(NSString *)magazineString
{
    NSMutableDictionary *noteDict = [NSMutableDictionary dictionary];
    NSArray *noteArray = [noteString componentsSeparatedByString:@" "];
    for (NSString *tempString in noteArray) {
        if (![noteDict objectForKey:tempString]) {
            //[noteDict setObject:@"1" forKey:tempString];
            [noteDict setObject:[NSNumber numberWithInt:1] forKey:tempString];
        }
        else {
            NSNumber *count = [noteDict objectForKey:tempString];
            NSLog(@"K: %@ V:%@", tempString, count);
            [noteDict setObject:[NSNumber numberWithInt:[count intValue]+1] forKey:tempString];
        }
    }
    
    NSArray *magazineArray = [magazineString componentsSeparatedByString:@" "];
    for (NSString *tempString in magazineArray) {
        if ([noteDict objectForKey:tempString]) {
            NSNumber *count = [NSNumber numberWithInt:[[noteDict objectForKey:tempString] intValue]-1];
            if ([count integerValue]==0) {
                [noteDict removeObjectForKey:tempString];
            }
            else {
                [noteDict setObject:count forKey:tempString];
            }
        }
    }
    if ([noteDict count]==0) {
        NSLog(@"100 percent matched: %@", noteDict);
    }
    else {
        NSLog(@"Missing: %@", noteDict);
    }
}

@end
