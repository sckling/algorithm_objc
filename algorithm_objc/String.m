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
//    NSString *string = @"abc";
//    NSLog(@"%lu", string.length);
//    NSLog(@"%c", [string characterAtIndex:2]);
//    
//    const char *c = [string UTF8String];
//    const char *c1 = [string cStringUsingEncoding:NSUTF16StringEncoding];
//    NSLog(@"char array %c", c[0]);
//    NSLog(@"char array %c", c[1]);
//    NSLog(@"char array %c%c,%c", c1[2], c1[3], c1[4]);
    
//    NSLog(@"P=1, %@", [self permutateBracketsIterative:1]);
//    NSLog(@"P=2, %@", [self permutateBracketsIterative:2]);
//    NSLog(@"P=3, %@", [self permutateBracketsIterative:3]);
    
//    [self permutateString:@"abc"];
//    [self permutateString:@"all"];
    
//    [self bracketPermutation:5];
//    [self bracketPermutation:6];
//    NSLog(@"String permutation: %@", [self stringPermutation:@"abc"]);
//    [self bracketPermutation:2 array:array];
    
//    [self isBracketsCountCorrectSetUp];
    
//    [self smallestCharInArraySetup];
    
//    [self anagramsSetup];
    
//    [self findCommonArraySetup];
    
//    [self delimiterMatchingSetup];
    
//    [self palindromeSetup];
    
//    [self printStringWithValidBracketsSetup];
    
//    [self wordCountSetup];
    
//    [self drawArcFromStringSetup];
    
//    [self longestSubstringWithTwoUniqueCharactersSetup];
    
//    [self longestSubstringWithUniqueCharactersSetup];
    
//    [self removeDuplicateLettersSetup];
    
//    [self minWordsFromSentenceSetup];
    
//    [self findNeedleInHaystackSetup];
    
//    [self regexValidationSetup];
    
//    [self compressStringSetup];
	
//	[self swapRgbSetup];
	
	[self distanceBetweenTwoWordsSetup];
}

- (void)swapRgbSetup {
	NSArray *a = @[@"g", @"b", @"r", @"r", @"b", @"r", @"g"];
	NSLog(@"%@", [self swapRgbOnePass:[a mutableCopy]]);
	
	a = @[@"b", @"b", @"r", @"r", @"b", @"g", @"b"];
	NSLog(@"%@", [self swapRgbOnePass:[a mutableCopy]]);
	
}

- (NSArray *)swapRgbOnePass:(NSMutableArray *)a {
	int low = 0;
	int mid = 0;
	int high = (int)a.count-1;
	
	while (mid<=high) {
		// If r, swap with mid pos (g) and increment both
		if ([a[mid] isEqualTo:@"r"]) {
			[a exchangeObjectAtIndex:mid++ withObjectAtIndex:low++];
		}
		// If g, since it's a mid postion, increment by 1 and no swap
		else if ([a[mid] isEqualTo:@"g"]) {
			mid++;
		}
		// If b, swap it to end. Don't increase mid since need to evaluate in next loop
		else if ([a[mid] isEqualTo:@"b"]) {
			[a exchangeObjectAtIndex:mid withObjectAtIndex:high--];
		}
	}
	return a;
}

- (NSArray *)swapRGB:(NSMutableArray *)a {
	int g = [self findFirstNonR:a];
	int b = [self findFirstNonB:a];

	for (int i=g; i<=b; i++) {
		// Swap r with last g position
		if ([a[i] isEqualTo:@"r"]) {
			if (i > g) {
				[a exchangeObjectAtIndex:i withObjectAtIndex:g++];
			}
		}
		// Swap b to last non b position. Need to keep current position to evalute the swapped char because if could be r or g
		else if ([a[i] isEqualTo:@"b"]) {
			[a exchangeObjectAtIndex:i-- withObjectAtIndex:b--];
		}
	}
	return a;
}

- (int)findFirstNonR:(NSArray *)a {
	int r = 0;
	for (int i=0; i<a.count; i++) {
		if ([a[i] isNotEqualTo:@"r"]) {
			r = i;
			break;
		}
	}
	return r;
}

- (int)findFirstNonB:(NSArray *)a {
	int b = (int)a.count-1;
	for (int i=(int)a.count-1; i>=0; i--) {
		if ([a[i] isNotEqualTo:@"b"]) {
			b = i;
			break;
		}
	}
	return b;
}

- (void)compressStringSetup {
    NSString *s = @"AAAABBBCCDAA";
    NSString *e = @"4A3B2C1D2A";
    NSString *r = [self compressString:s];
    NSLog(@"Expected: %@, receive: %@, result:%d", e, r, [e isEqualToString:r]);
    
    s = @"aaaaa";
    e = @"5a";
    r = [self compressString:s];
    NSLog(@"Expected: %@, receive: %@, result:%d", e, r, [e isEqualToString:r]);
    
    s = @"b";
    e = @"1b";
    r = [self compressString:s];
    NSLog(@"Expected: %@, receive: %@, result:%d", e, r, [e isEqualToString:r]);
    
    s = @"";
    e = @"";
    r = [self compressString:s];
    NSLog(@"Expected: %@, receive: %@, result:%d", e, r, [e isEqualToString:r]);
}

- (NSString *)compressString:(NSString *)s {
    NSString *result = [NSString new];
    // Start with 2nd char and compare to prev char.
    // If same, increase count by 1
    // If not, add count to result string and reset count to 1
    if (!s || s.length == 0) {
        return @"";
    }
    int count = 1;
    for (int i=1; i<s.length; i++) {
        if ([s characterAtIndex:i-1] == [s characterAtIndex:i]) {
            count++;
        }
        else {
            result = [result stringByAppendingString:[NSString stringWithFormat:@"%d%c", count, [s characterAtIndex:i-1]]];
            count = 1;
        }
    }
    return [result stringByAppendingString:[NSString stringWithFormat:@"%d%c", count, [s characterAtIndex:s.length-1]]];
}

/*
Implement regular expression matching with the following special characters:

. (period) which matches any single character
* (asterisk) which matches zero or more of the preceding element
That is, implement a function that takes in a string and a valid regular expression and returns whether or not the string matches the regular expression.

For example, given the regular expression "ra." and the string "ray", your function should return true. The same regular expression on the string "raymond" should return false.

Given the regular expression ".*at" and the string "chat", your function should return true. The same regular expression on the string "chats" should return false.
 */

- (void)regexValidationSetup {
    NSString *s = @"ray";
    NSString *e = @"ra.";
    NSLog(@"%@, %@ = Yes, received: %d", s, e, [self regexValidation:s regex:e]);
    
    s = @"raymond";
    e = @"ra.";
    NSLog(@"%@, %@ = No, received: %d", s, e, [self regexValidation:s regex:e]);
    
    s = @"chat";
    e = @".*at";
    NSLog(@"%@, %@ = Yes, received: %d", s, e, [self regexValidation:s regex:e]);
    
    s = @"chats";
    e = @".*at";
    NSLog(@"%@, %@ = No, received: %d", s, e, [self regexValidation:s regex:e]);
    
    s = @"chats";
    e = @"c*";
    NSLog(@"%@, %@ = Yes, received: %d", s, e, [self regexValidation:s regex:e]);
    
    s = @"c";
    e = @"*c";
    NSLog(@"%@, %@ = Yes, received: %d", s, e, [self regexValidation:s regex:e]);
}

- (BOOL)regexValidation:(NSString *)s regex:(NSString *)e {
    int i=0;
    int j=0;
    while (i<s.length && j<e.length) {
        if ([s characterAtIndex:i] == [e characterAtIndex:j] || [e characterAtIndex:j] == '.') {
            i++;
            j++;
        }
        else if ([e characterAtIndex:j] == '*') {
            // * is the last in expression. Means can matches all the rest of string
            if (j == e.length-1) {
                return YES;
            }
            // Search for match the next char from *: *y, y
            while (i<s.length) {
                if ([s characterAtIndex:i++] == [e characterAtIndex:j+1]) {
                    // Since j+1 already compared, next to move to next char to sync with i
                    j += 2;
                    break;
                }
            }
        }
        // chars not matched
        else {
            return false;
        }
    }
    NSLog(@"i %d, s %ld, j %d, e %ld", i, s.length, j, e.length);
    // Need to make sure both string and expression at the end. Otherwise means one of them is not complete and hence false
    if (i!=s.length || j!=e.length) {
        
        return NO;
    }
    return YES;
}


/*
 function int[] grep(string haystack, string needle)
 haystack = "aaabcdddbbddabcdefghi"
 needle = "abc"
 [2,12]
 
 h = "bbbbb"
 n = "b"
[0,1,2,3,4]
 n = 'bb"
 [0,1,2,3];
 
 O(h.length)
 h = 5, from 0 to 5-2+1 = 4
 if either strings are empty, return empty array
 for each char in haystack till legnth-needl.length
  if char == needle[0]
     findMatch
     if matched, add curr idx to arr
 
 findMatch
   for each char of h from idx and each char of n from 0
     if h[i] != n[j] return false
   return true
 
 Worst case O(h * n)
 aabaabaab
 aaa
 
 aaaaaaaaa
 aaa
 
 i 0 1 2
 j 0 1 2
 l 0 1 2
 
 Set a last match idx and when done matching, start from that instead of next idx
 */

- (void)findNeedleInHaystackSetup {
    NSString *haystack = @"aaabcdddbbddabcdefghi";
    NSString *needle = @"abc";
//    NSLog(@"result: %@", [self findNeedleInHaystack:haystack string:needle]);
    NSLog(@"result: %@", [self findNeedleInHaystack_KMP:haystack string:needle]);
    
    haystack = @"bbbbbbbbbbbbb";
    needle = @"bbb";
//    NSLog(@"result: %@", [self findNeedleInHaystack:haystack string:needle]);
    NSLog(@"result: %@", [self findNeedleInHaystack_KMP:haystack string:needle]);
    
    needle = @"abcdabca";
    NSLog(@"00001231: %@", [self findNeedleInHaystack_KMP:haystack string:needle]);
    
    needle = @"abcaby";
    NSLog(@"000120: %@", [self findNeedleInHaystack_KMP:haystack string:needle]);
    
//    needle = @"";
//    NSLog(@"result: %@", [self findNeedleInHaystack:haystack string:needle]);
}

- (NSArray *)findNeedleInHaystack_KMP:(NSString *)h string:(NSString *)n {
    NSArray *pattern = [self buildSubstringPattern:n];
    NSMutableArray *res = [NSMutableArray new];
    // for t[i] and pat[length]
    // if same, i++ and length++, if length = pattern.length, save i=p.length+1
    // if not the same and if length ==0, i++
    // else compare again with length = pat[kmp[length-1]]
    int length = 0;
    for (int i=0; i<h.length; i++) {
        if ([h characterAtIndex:i] == [n characterAtIndex:length]) {
            length++;
            // If entire pattern matched, save the start index
            if (length == n.length) {
                // Look back to previous element to determin how far it needs to compare the characters
                length = [pattern[length-1] intValue];
                [res addObject:@(i-n.length+1)];
            }
        }
        else {
            if (length > 0) {
                length = [pattern[length-1] intValue];
                i--;
            }
        }
    }
    return res;
}

/*
 abxabc    aaa   abc
 000120    012   000
 */
- (NSArray *)buildSubstringPattern:(NSString *)n {
    if (n.length == 0 || n == nil) {
        return nil;
    }
    NSMutableArray *kmp = [[NSMutableArray alloc] initWithCapacity:n.length];
    [kmp addObject:@0];
    int length = 0;
    int i=1;
    while (i<n.length) {
        if ([n characterAtIndex:i] == [n characterAtIndex:length]) {
            kmp[i] = @(length+1);
            length++;
            i++;
        }
        else {
            if (length > 0) {
                length = [kmp[length-1] intValue];
            }
            else {
                kmp[i] = @0;
                i++;
            }
        }
    }
    return kmp;
}

- (NSArray *)findNeedleInHaystack:(NSString *)h string:(NSString *)n {
    if (h.length == 0 || h == nil || n.length == 0 || h == nil) {
        return @[];
    }
    NSMutableArray *res = [NSMutableArray new];
    int lastMatch = 0;
    for (int i=0; i<=h.length-n.length; i++) {
        for (int j=0; i<n.length; j++) {
            if ([h characterAtIndex:j+i] != [n characterAtIndex:j]) {
                lastMatch = i+j;
            }
            else if ([self matchWords:h idx:i string:n]) {
                [res addObject:@(i)];
            }
        }
    }
    return res;
}

- (BOOL)matchWords:(NSString *)h idx:(int)idx string:(NSString *)n {
    for (int i=0; i<n.length; i++) {
        if ([h characterAtIndex:idx+i] != [n characterAtIndex:i]) {
            return NO;
        }
    }
    return YES;
}

- (void)minWordsFromSentenceSetup {
    NSString *s = @"jumpedoversomething";
    NSSet *set = [NSSet setWithObjects:@"jumped", @"over", @"some", @"thing", @"something", nil];
    [self minWordsFromSentence:set string:s];
    
    s = @"nothing";
    [self minWordsFromSentence:set string:s];
}

- (NSArray *)minWordsFromSentence:(NSSet *)set string:(NSString *)s {
    NSMutableDictionary *res = [NSMutableDictionary new];
    NSMutableArray *idx = [NSMutableArray new];
    NSString *t = [NSString new];
    int start = 0;
    for (int i=0; i<s.length; i++) {
        t = [s substringWithRange:NSMakeRange(start, i-start+1)];
        // jumped, i=5, idx [0], start=6
        // over,  i=9, idx[0,6] -> [0,9], [6,9], start = 10
        // some, i=13, idx[0,6,10] -> [0,13], [6,13], [10,13], start=14
        // thing i=18, idx[0,6,10,14] -> [10,18]
        // res = [0,5], [6,9], [10,13], [10,18]
        if ([set containsObject:t]) {
            [idx addObject:@(start)];
            start = i+1;
            for (NSNumber *n in idx) {
                t = [s substringWithRange:NSMakeRange([n intValue], i-[n intValue]+1)];
                if ([set containsObject:t]) {
                    [res setObject:@(i) forKey:n];
                    break;
                }
            }
        }
    }
    if (res.count == 0) {
        return @[];
    }
    NSMutableArray *words = [NSMutableArray new];
    for (NSNumber *r in res.allKeys) {
        t = [s substringWithRange:NSMakeRange([r intValue], [res[r] intValue]-[r intValue]+1)];
        [words addObject:t];
        NSLog(@"k: %@, v: %@, %@", r, res[r], t);
    }
    return words;
}


- (void)removeDuplicateLettersSetup {
    NSString *string = @"combat";
    NSLog(@"%@ -> %@", string, [self removeDuplicateLetters:string]);
    string = @"hello";
    NSLog(@"%@ -> %@", string, [self removeDuplicateLetters:string]);
    string = @"Mississippi";
    NSLog(@"%@ -> %@", string, [self removeDuplicateLetters:string]);
    string = @"aaaaa";
    NSLog(@"%@ -> %@", string, [self removeDuplicateLetters:string]);
}

/*
 Edge cases: No duplicates, only duplicates, empty string
 combat -> combat
 hello -> helo
 Algorithm:
 1. Create an NSMutableSet to store characters. Alernatively, use an array (a=0, b=1, etc). Make sure to agree on the size and init the value. Otherwise crash.
 2. For each char, check if existing
 3. If not, add to the set and add to the new string
 4. Otherwise, skip to next char
 
 Example: h,e,l,l(exist, skip),o
 M,i,s,s(skp),i(skp),s(skp),s(skp),i(skp),p,p(skp),i(skp)
 Runtime O(n)
 Space: O(26) for the set and O(2n) for 2 strings => O(n)
 */
- (NSString *)removeDuplicateLetters:(NSString *)string {
    NSMutableSet *set = [NSMutableSet new];
    NSString *newString = [NSString new];
    NSString *c = [NSString new];
    for (int i=0; i<string.length; i++) {
        c = [NSString stringWithFormat:@"%c", [string characterAtIndex:i]];
        if (![set containsObject:c]) {
            [set addObject:c];
            newString = [newString stringByAppendingString:c];
        }
    }
    return newString;
}

/*
 Longest Common Substring
 Given two strings ‘X’ and ‘Y’, find the length of the longest common substring.
 
 Input: x = "GeekforGeeks", y = "GeeksQuiz"
 Output : "Geeks", length 5.
 
 Input : X = "abcdxyz", y = "xyzabcd"
 Output : "abcd", length 4.
 
 Input : X = "zxabcdezy", y = "yzabcdezx"
 Output : "abcdez", length 6.
 
 Algorithm:
 Brute force:
 For each substring in X, find every matched char in Y and compare length until unmatched
 eg. g: geeks, e: [eeks], e: eks, k: ks, s...
 Time complexity =  O(m^2*n), m=lenght of x, n=lenght of y; print all substring in X = O(m^2)
 
 Optimal solution:
 Use a matrix to store the length of 
 For each char in X, check if it's in the hash table
 If yes, remove the value from hash and start traverse from the index.
 For each matc
 
 
 */

- (void)longestCommonSubstringSetup {
    NSString *x = @"GeeksforGeeks";
    NSString *y = @"GeeksQuiz";
//    NSLog(@"LCS = %@");
    
    x = @"abcdxyz";
    y = @"xyzabcd";
    
    x = @"zxabcdezy";
    y = @"yzabcdezx";
    
    // No LCS:
    x = @"abcd";
    y = @"xyz";
    
    // Empty string
    x = @"abc";
    y = @"";
}

/*
 Given a string, find the longest substring which contains 2 unique characters.
 For example, "abcbbbbcccbdddadacb" => "bcbbbbcccb"
 
 Clarifications:
 1. Return the longest substring or just the length? The substring
 2. What to return if no substring meets the requirement? Return nil
 
 Algorithm:
 1. Use 2 vars - start and end to record the substring index
 2. Traverse linearly. For each new substring, use NSSet to store the character sets
 3. For each char, check if check if char exists in the set
 4. If yes, continue.
 5. If not, check if set size <=2. Yes->add it to set; No->calculate size of substring and reset start=end and end=start+1, and reset set
 6. Continue until end == string.length. Careful to handle end of string or string with 0 or 1 character
 
 Run time = O(n), Space = O(1)
 
 Edge cases:
 1. Empty string or no substring exists with 2 unique characters:  abcdefg -> returns nil
 2. String with only 1 character: aaaaaaa
 */

- (void)longestSubstringWithTwoUniqueCharactersSetup {
    NSString *string = @"abcbbccbdddadacb";
    NSLog(@"Longest substrings: %@, %@", string, [self longestSubstringWithTwoUniqueCharacters:string]);
    NSLog(@"Longest substrings k=1->3, %d", [self longestSubstringWith_K_uniqueCharacters:string k:1]);
    NSLog(@"Longest substrings k=2->7, %d", [self longestSubstringWith_K_uniqueCharacters:string k:2]);
    NSLog(@"Longest substrings k=3->10, %d", [self longestSubstringWith_K_uniqueCharacters:string k:3]);
    
    string = @"abbbecbbbbcccbdddadacb";
    NSLog(@"Longest substrings: %@, %@", string, [self longestSubstringWithTwoUniqueCharacters:string]);
    
    string = @"aabbb";
    NSLog(@"Longest substrings: %@, %@", string, [self longestSubstringWithTwoUniqueCharacters:string]);
    
    string = @"aaaaaaaaa";
    NSLog(@"Longest substrings: %@, %@", string, [self longestSubstringWithTwoUniqueCharacters:string]);
}

- (int)longestSubstringWith_K_uniqueCharacters:(NSString *)s k:(int)k {
    if (s.length < k || k < 1) {
        return (int)s.length;
    }
    int max = 0;
    int start = 0;
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (int i=0; i<s.length; i++) {
        NSString *c = [NSString stringWithFormat:@"%c", [s characterAtIndex:i]];
        dict[c] = @(i);
        // Substring total numbers of unique char exceed k
        if (dict.count > k) {
            // Sort dict to find the lowest position of unique character
            // Add that postion+1 -> next lowest character
            // Remove the origin char to make room for next one.
            NSArray *array = [dict keysSortedByValueUsingComparator: ^NSComparisonResult(id obj1, id obj2) {
                return obj1 > obj2;
            }];
//            NSLog(@"s:%d, e:%d 0:%@:%@, 1:%@:%@", start, i, array[0], dict[array[0]], array[1], dict[array[1]]);
            start = [dict[array[0]] intValue]+1;
            [dict removeObjectForKey:array[0]];
        }
        // Need to update max for every iteraction instead of only when exceed k
        // This is to handle repeated same character
        max = MAX(max, i-start+1);
    }
    return max;
}

/*
 NSMutableSet *set = [NSMutableSet new];
 int start = 0;
 int next = 0;
 //    NSString *lastChar = [NSString stringWithFormat:@"%c", [s characterAtIndex:0]];
 for (int i=0; i<s.length; i++) {
 NSString *c = [NSString stringWithFormat:@"%c", [s characterAtIndex:i]];
 // Case 1: set < k and c is new: add c to set and next=i
 if (set.count < k && ![set containsObject:c]) {
 [set addObject:c];
 next = i;
 }
 // Case 2: set <= k and c is existing, check if it's a switch of char. If yes, update next
 else if (set.count <= k && [set containsObject:c]) {
 if ([s characterAtIndex:i] != [s characterAtIndex:i-1]) {
 next = i;
 }
 }
 // Case 3: Substring exceed k
 else {
 max = MAX(max, i-start);
 [set removeObject:[NSString stringWithFormat:@"%c", [s characterAtIndex:start]]];
 [set addObject:c];
 start = next;
 next = i;
 }
 }
 */


- (NSString *)longestSubstringWithTwoUniqueCharacters:(NSString *)string {
    if (string.length <= 2) {
        return string;
    }
    NSMutableSet *set = [NSMutableSet new];
    int numberOfUniqueChar = 2;
    int first = 0;
    int second = 0;
    int maxSoFar = 0;
    char prev = [string characterAtIndex:0];
    char curr = 0;
    [set addObject:[NSString stringWithFormat:@"%c", prev]];
    NSString *sub = nil;
    for (int i=1; i<string.length; i++) {
        curr = [string characterAtIndex:i];
        // A bug here if the string is aaaaaaa and it'll return nil. Is this expected?
        // Fixed at the return line.
        if (curr != prev) {
            // Still within 2 or less unique characters or char exists in set
            if ([set containsObject:[NSString stringWithFormat:@"%c", curr]]
                || (![set containsObject:[NSString stringWithFormat:@"%c", curr]] && set.count < numberOfUniqueChar)) {
                [set addObject:[NSString stringWithFormat:@"%c", curr]];
            }
            // End of a substring. Need the third unique character to trigger this statement
            else {
                if (i-first > maxSoFar) {
                    maxSoFar = i-first;
                    sub = [string substringWithRange:NSMakeRange(first, i-first)];
//                    NSLog(@"sub: %d %@", i, sub);
                }
                [set removeAllObjects];
                [set addObject:[NSString stringWithFormat:@"%c", prev]];
                [set addObject:[NSString stringWithFormat:@"%c", curr]];
                // Another bug here that if the next character is unique again, second never got changed. eg: aabbbec
                // Fixed it by update second every time when there's a character change
                first = second;
            }
        }
        second = i;
        prev = curr;
    }
    return sub == nil ? string : sub;
}

- (void)longestSubstringWithUniqueCharactersSetup {
    NSString *string = @"geeksforgeeks";
    NSLog(@"%@=7, actual: %ld", string, [self longestSubstringWithUniqueCharacters:string]);
    string = @"abcabcbb";
    NSLog(@"%@=3, actual: %ld", string, [self longestSubstringWithUniqueCharacters:string]);
    string = @"bbbbb";
    NSLog(@"%@=1, actual: %ld", string, [self longestSubstringWithUniqueCharacters:string]);
    string = @"pwwkew";
    NSLog(@"%@=3, actual: %ld", string, [self longestSubstringWithUniqueCharacters:string]);
    string = @"a";
    NSLog(@"%@=1, actual: %ld", string, [self longestSubstringWithUniqueCharacters:string]);
    string = @"ab";
    NSLog(@"%@=2, actual: %ld", string, [self longestSubstringWithUniqueCharacters:string]);
}

/*
 Algorithm:
 1. Use a start index to store the start of a substring. start=0
 2. Use a dictionary to store character and it's index
 3. For each char, compare to the dict.
 4. If exist, do the following:
    - Check if the existing index is smaller than start index. If yes, it's from previous substring
    - Else calculate the length from start to current index and store to max if length is greater.
    - Replace start with the index+1 of the matched char in dict.
 5. Replace the char with updated index
 
 Runtime = O(n)
 */

- (NSInteger)longestSubstringWithUniqueCharacters:(NSString *)string {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSInteger start = 0;
    NSInteger max = 0;
    
    for (int i=0; i<string.length; i++) {
        NSString *curr = [NSString stringWithFormat:@"%c", [string characterAtIndex:i]];
        if (dict[curr]) {
            // the repeated location could be from previous, so we only need to update if it's after the start
            start = MAX(start, [dict[curr] integerValue]+1);
        }
        dict[curr] = @(i);
        max = MAX(max, i-start+1);
    }
    return max;
}

- (NSInteger)subStringLength:(NSString *)string dict:(NSMutableDictionary *)dict start:(NSInteger)start idx:(NSInteger)idx {
    NSString *curr = [NSString stringWithFormat:@"%c", [string characterAtIndex:idx]];
    // If char is unique
    if (![dict doesContain:curr]) {
        dict[curr] = @(idx);
    }
    else {
        NSInteger prev = [dict[curr] integerValue];
        // If char is still unique
        if (prev < start) {
            dict[curr] = @(idx);
        }
        // If char is not unique
        else {
            start = prev+1;
        }
    }
    return idx-start;
}

// Apple
// Goal: convert hex string into RGB value
// Algorithm
// 1. Validate and Tokenize the string into 3 sets of RGB: ff, ff, ff
// 2. For each set, convert it from hex to RGB (decimal) value: ff->255,
// 3. Store each of the decimal value in the loop
// 4. return UIColor colorWithRed: G B alpha
/*
- (UIColor *)hexColor:(NSString *)hexColor {
    // Assume hexColor is a valid hex string
    NSMutableArray<NSNumber *> *colors = [NSMutableArray new];
    for (NSInteger i=0; i<3; i++) {
        // ffffff
        // 012345
        NSString *hex = [hexColor substringWithRange:NSMakeRange(i*2, 2)];
        // a=10, b=11, c=12, d=13, e=14, f=15
        [colors addObject:[self hexToDecimal:hex]];
    }
    return [UIColor colorWithRed:[colors[0] doubleValue]/255.0
                            blue:[colors[1] doubleValue]/255.0
                           green:[colors[2] doubleValue]/255.0
                           alpha:1.0];
}
         
- (NSNumber *)hexToDecimal:(NSString *)hex {
 // ff=255
 NSInteger dec = 0;
 for (NSInteger i=0; i<hex.length; i++) {
     // af, i=0, charAtIndex:2-0-1=1->f
     dec += [[hex characterAtIndex:hex.length-i-1] doubleValue] * 16^i;
 }
 return @(dec);
}
*/

- (void)drawArcFromStringSetup {
    NSString *string = @"101110";
    NSLog(@"%@, (0,0), (2,4)", string);
    [self drawArcFromString:string];
    
    string = @"101111";
    NSLog(@"%@, (0,0), (2,5)", string);
    [self drawArcFromString:string];
    
    string = @"1";
    NSLog(@"%@, (0,0)", string);
    [self drawArcFromString:string];
    
    string = @"000";
    NSLog(@"%@, (0,0), no drawing", string);
    [self drawArcFromString:string];
}

/*
 Facebook, 4/30/18
 Input: streams of 1's and 0's
 Ignore 0's. When there's a 1, call drawArc
 For consecutive 1's, call drawArc one time from start to end
 For example, 0,0,1,1,1,1 -> drawArc(2,5)
 
 Algorithm:
 Traverse the string and check if char if 1.
 For the start 1, store the index
 If the next character is 1, continue and increase index by 1
 If the next character is 0, call drawArc(start, current)
 */
- (void)drawArcFromString:(NSString *)string {
    int start = -1;
    for (int i=0; i<string.length; i++) {
        // Track start of a 1
        if ([string characterAtIndex:i] == '1' && start == -1) {
            start = i;
        }
        // Track end of a 1
        else if ([string characterAtIndex:i] == '0' && start != -1) {
            NSLog(@"%d, %d", start, i-1);
            start = -1;
        }
    }
    // Did thought about this part during interview. Hence a bug when the last character is 1 that it won't call out
    if (start >=0) {
        NSLog(@"%d, %d", start, (int)string.length-1);
    }
}

- (void)delimiterMatchingSetup {
    NSString *string;
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

// Use a stack to store all the open brackets
// When encounter a close bracket, pop the stack and compare against it
// If it's a matched pair, continue
// If not, return NO
// If starts with close bracket, return no


/*
 Second attempt to complete this question via Hackerrank but there are several bugs:
 1. When there are still open brackets left in the stack, it returns YES
 2. When there are no open brackets but there are close brackets, it returns YES
 3. Need to define when it's an empty string, should return YES or NO
 */

- (void)areBracketsBalanced:(NSString *)string {
    //printf("%s\n", [string UTF8String]);
    NSMutableArray *stack = [NSMutableArray new];
    for (int i=0; i<string.length; i++) {
        unichar c = [string characterAtIndex:i];
        if (c == '{' || c == '[' || c == '(' ) {
            [stack addObject:[NSString stringWithCharacters:&c length:1]];
        }
        else {
            // No open brackets to pop
            if (stack.count == 0) {
                printf("NO\n");
                return;
            }
            unichar openBracket = [[stack lastObject] characterAtIndex:0];
            if (openBracket == '{' && c != '}') {
                printf("NO\n");
                return;
            }
            else if (openBracket == '[' && c != ']') {
                printf("NO\n");
                return;
            }
            else if (openBracket == '(' && c != ')') {
                printf("NO\n");
                return;
            }
            else {
                [stack removeLastObject];
            }
        }
    }
    // If there are still open brackets left in the stack, should return no.
    if (stack.count == 0) {
        printf("YES\n");
    }
    else {
        printf("NO\n");
    }
    return;
}

- (void)smallestCharInArraySetup {
    NSString *string = @"cccffffjpv";  // string lenght = 10, character 0..9
    NSLog(@"Character c->f: %c", [self smallestCharacterInString:string character:'c']);
    NSLog(@"Character f->j: %c", [self smallestCharacterInString:string character:'f']);
    NSLog(@"Character v->c: %c", [self smallestCharacterInString:string character:'v']);
    NSLog(@"Character a->c: %c", [self smallestCharacterInString:string character:'a']);
    NSLog(@"Character d->f: %c", [self smallestCharacterInString:string character:'d']);
    NSLog(@"Character u->v: %c", [self smallestCharacterInString:string character:'u']);
    NSLog(@"Character z->c: %c", [self smallestCharacterInString:string character:'z']);
}

/**
 * LinkedIn
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
    return [self nextCharacter:string character:character index:idx];
}

- (unichar)nextCharacter:(NSString *)string character:(unichar)character index:(NSInteger)index {
    // At the end of the string, no need to check next repeated character, return first character of the string
    if (index > string.length-1) {
        return [string characterAtIndex:0];
    }
    // Next character is same as current character, recursively search for next character
    //if ([string characterAtIndex:index] == [string characterAtIndex:index+1]) {
    if (character == [string characterAtIndex:index]) {
        return [self nextCharacter:string character:character index:index+1];
    }
    // Next character is not the same as current character, return next character
    return [string characterAtIndex:index];
}

// This method can handle array with 0, 1 or 2 elements only
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
    //NSLog(@"low: %ld, mid: %ld, high: %ld", (long)low, (long)middle, (long)high);
    // Character not found
    // low: next position to insert character. Should return -(low+1) to handle low = 0
    // Since low starts at 0 and we only increment it, it never goes to negative but could be out of bound
    // high: replace previous position with this index
    return low;
}

/**
 * LinkedIn, 3/27/18, Curtis
 *
 * This function determines if the braces ('(' and ')') in a string are properly matched.
 * it ignores non-brace characters.
 * Some examples:
 * "()()()()"   -> true
 * "((45+)*a3)" -> true
 * "(((())())"  -> false
 
 Edge cases:
 1. () -> true, )( -> false
 2. String with no brackets -> true
 3. One type of bracket ()
 4. (( -> false
 
 Algorithm:
 1. for-loop to traverse every character of the string
 2. For each character, do something with (), ignore all others
 3. FILO -> stack: For an open bracket, store it in the stack, for a close bracket, check the following:
 a. If counter > 0, remove counter by 1 and continue
 b. If counter <= 0, return false
 */

- (BOOL)matched:(NSString *)string {
    NSInteger counter = 0;
    for (NSInteger i=0; i<string.length; i++) {
        unichar c = [string characterAtIndex:i];
        if (c == '(') {
            counter++;
        }
        else if (c == ')') {
            if (counter <= 0) {
                return NO;
            }
            counter--;
        }
    }
    return (counter == 0);
}

/* This class will be given a list of words (such as might be tokenized
 * from a paragraph of text), and will provide a method that takes two
 * words and returns the shortest distance (in words) between those two
 * words in the provided text.
 * Example:
 *   WordDistanceFinder finder = new WordDistanceFinder(Arrays.asList("the", "quick", "brown", "fox", "quick"));
 *   assert(finder.distance("fox", "the") == 3);
 *   assert(finder.distance("quick", "fox") == 1);
 *
 * "quick" appears twice in the input. There are two possible distance values for "quick" and "fox":
 *     (3 - 1) = 2 and (4 - 3) = 1.
 * Since we have to return the shortest distance between the two words we return 1.
 
 Quesions:
 quick, quick, fox, fox = 3,4,1
 Always matched words? quick, foo = int.max; foo, bar = int.max
 quick, fox, quick, fox, quick = 0
 quick = 0
 
 Algorithm
 1. Use hash to store key (word), value (index) -> array of indices (2, 4)
 2. We'll have two arrays of integers and calculate the min distance
 3. If one or no word found, return int.max
 4. If one word with multiple instances, return 0;
 */
/*
@interface WordDistanceFinder : NSObject

@proprety(nonatomic, strong) NSMutableDictionary *words;
+ (instancetype)wordDistanceFinder:(NSArray *)words;
- (NSInteger)distanceBetweenWordOne:(NSString *)wordOne wordTwo:(NSString *)wordTwo;

@end

@implementation WordDistance

+ (instancetype)wordDistanceFinder:(NSArray<NSString *> *)words {
    // Store entire words in dictionary
    self.words = [NSMutableDictionary new];
    for (NSInteger i=0; i<words.count; i++) {
        // No existing word
        if (!self.words[words[i]]) {
            self.words[words[i]] = @[@i];
        }
        // Existing word
        else {
            NSMutableArray *array = [NSMutableArray arrayWithArray:self.words[words[i]];
            self.words[words[i] = [array addObject:@i];
        }
    }
}
*/

/*
 Repeated words? Yes. "the quick fox the crazy deer", distance: the, fox => 1
 Always matched? No. Return 0 if no match
 word 1 and word 2 are the same? Try it
 
 Algorithm:
 Traverse all words and build two sorted array with possible matches: 1,5 & 3,8  O(n)
 Find the min distance between array1 and array2
 Can be done brute force by trying to match each element in a1 with a2
 
 Keep 2 pointers:
 Keep move p1 when there are new found of words
 When found p2, calculate the distance and update min if needed
 If found new p2 later, no need to recalculate until found a new p1
 Can be done in 1 pass
 
 */
- (void)distanceBetweenTwoWordsSetup {
	NSArray<NSString *> *words = @[@"the", @"the", @"quick", @"brown", @"fox", @"quick", @"the"];
	printf("Value should be 2. Received: %d\n", [self distanceBetweenTwoWords:@"fox" word:@"the" words:words]);
	printf("Value should be 1. Received: %d\n", [self distanceBetweenTwoWords:@"quick" word:@"fox" words:words]);
	printf("Value should be 0. Received: %d\n", [self distanceBetweenTwoWords:@"quick" word:@"some" words:words]);
	printf("Value should be 0. Received: %d\n", [self distanceBetweenTwoWords:@"no" word:@"no" words:words]);
	printf("Value of the same word should be 0. Received: %d\n", [self distanceBetweenTwoWords:@"the" word:@"the" words:words]);
}

- (int)distanceBetweenTwoWords:(NSString *)w1 word:(NSString *)w2 words:(NSArray *)words {
	int distance = INT_MAX;
	int p1 = -1;
	int p2 = -1;
	for (int i=0; i<words.count; i++) {
		if ([words[i] isEqualToString:w1]) {
			p1 = i;
		}
		if ([words[i] isEqualToString:w2]) {
			p2 = i;
		}
		distance = [self minDistance:p1 num:p2 min:distance];
	}
	return (p1 == -1 || p2 == -1) ? 0 : distance;
}

- (int)minDistance:(int)i num:(int)j min:(int)min {
	if (i == -1 || j == -1) {
		return INT_MAX;
	}
	return MIN(min, abs(i-j));
	
}


- (NSInteger)distanceBetweenWordOne:(NSString *)wordOne wordTwo:(NSString *)wordTwo dict:(NSDictionary *)words {
    NSArray *array1 = words[wordOne];
    NSArray *array2 = words[wordTwo];
                
    // Case 1: One word found, return 0;
    if ((!array1 && array2) || (array1 && !array2)) {
        return 0;
    }
    // Case 2: One or no words found, return int.nax
    if (!array1 || !array2) {
        return INTMAX_MAX;
    }
    return [self minDistance:array1 array:array2];
}

-(void)minDistanceSetup {
    NSArray *array1 = @[@2, @5, @9, @20, @25];
    NSArray *array2 = @[@7, @8, @12, @18];
    NSLog(@"Min: %ld", [self minDistance:array1 array:array2]);
    
    array1 = @[@2, @5, @12, @20, @25, @26, @27, @100, @101];
    array2 = @[@7, @12, @99];
    NSLog(@"Min: %ld", [self minDistance:array1 array:array2]);
    
    array1 = @[];
    array2 = @[@7, @8, @12, @18];
    NSLog(@"Min: %ld", [self minDistance:array1 array:array2]);
}

- (NSInteger)minDistance:(NSArray *)array1 array:(NSArray *)array2 {
    // Two for loop, O(n*m); arrays are sorted:
    // 2,5,9,20,25
    // 7,8,12,18
    // i=0,j=0: 2-7=5, min=5
    // i=1,j=0: 5-7=2, min=2
    // i=2,j=0: 9-7=2, min=2
    // i=2,j=1: 9-8=1, min=1
    // i=2,j=2: 9-12=3, min=1
    // i=3,j=2: 20-12=8, min=1
    // i=3,j=3: 20-18=2, min=1
    // Subtract index i-j and compare to min and update it if it's smaller
    // Move the index of the smaller element, since the next element is larger and have the chance to generate a smaller difference
    // Keep doing it until both indices reach the end
    // Set 2:
    // 2,5,9,20,25,26,27,100,101
    // 7,12,99
    if (array1.count == 0 && array2.count == 0) {
        return 0;
    }
    if (array1.count == 0) {
        return [array2[0] integerValue];
    }
    if (array2.count == 0) {
        return [array1[0] integerValue];
    }
    NSInteger minSoFar = INT_MAX;
    NSInteger i=0;
    NSInteger j=0;
    while (i<array1.count && j<array2.count) {
        NSInteger diff = abs([array1[i] intValue] - [array2[j] intValue]);
        minSoFar = diff < minSoFar ? diff : minSoFar;
        if (minSoFar == 0) {
            return 0;
        }
        [array1[i] isLessThan:array2[j]] ? i++ : j++;
    }
    return minSoFar;
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

/* Nest Lab, David Fichou, 3/6/18
 What's retain cycle and give some examples.
 What's difference between NSSet and NSArray and why use one over the other
 How does NSSet implement
 How to make a network call to retreive data?
 How to handle the data in the block after download
 Give me some example of UITableView delegate and datasource methods
 What would happen if UI is running on a background thread?
 How to animate UIKit objects?
 Give me some tool that can handle multi-threading: GCD, NSOperationQueue (what's the difference), atom vs non-atomic, NSThread
 Difference between delegate and NSNotification. When to use which?
 */

// You and your friend have a code language. To encode a message you replace
// every letter with another letter 2 ahead of it in the alphabet.
// The letter “A” becomes the letter “C”, “B” -> “D”...
// E.g. “ENCODED MESSAGE” becomes "GPEQFGF OGUUCIG"
// Write a program that given a string encodes it this way.
// Input: "ENCODED MESSAGE"
// Output: "GPEQFGF OGUUCIG"
/*
 1. What about numeric and non-alphabetic characters?   A1->C1, !A->!C
 2. X->Z, Y->A, Z->B
 2. Upper case only
 3. Length of string
 
 Algorithm:
 1. For loop each character in the string
 2. If it's alphabetic, get the ascII and add 2, if it's y and z, subtract by 24
 3. For non-alphabetic, keep it as is
 4. Write char into a NSMutableString
 */

//NSString *encodeString(NSString *string) {
- (NSString *)encodeString:(NSString *)string {
    if (string == nil || string.length == 0) {
        return nil;
    }
    // Improvement: should use NSString instead
    NSMutableString *newString = [NSMutableString new];
    // String=@"abc", length=3, last index=2
    for (int i=0; i<string.length; i++) {
        unichar c = [string characterAtIndex:i];
        // A=65
        // Z=91
        // Case 1: Between A to Z. Original solution use real ascii number like 65.
        if (c >= 'A' && c <= 'Z') {
            [newString appendFormat:@"%c", c < 'Y' ? c+2 : c-24];
        }
        // Case 2: If char is non-alphabet
        else {
            [newString appendFormat:@"%c", c];
        }
    }
    return [newString copy];
}

/*
 Amazon onsite 12/9/16
 Remove brackets in order to print a string with valid brackets setup
 1. Print a valid string is valid.
 2. Remove each invalid bracket and save each new string into an array
 3. Check whether each of it is valid
 4. If not, repeat step 2 to 4
    (a+b) ) (c) -> remove second ) or third ) will be valid
    If a string is invalid, remove brackets one at a time and save the string
    Check if the string is valid. If not, repeatedly remove one bracket at a time
 */

- (void)printStringWithValidBracketsSetup {
    NSString *string = @"(a,(b+c)";
    NSLog(@"%@, valid: %@", string, [self stringWithValidBrackets:string]);
    // [self printStringWithValidBrackets:string];

    string = @")(";
    NSLog(@"%@, valid: %@", string, [self stringWithValidBrackets:string]);
    // [self printStringWithValidBrackets:string];
    
    string = @"(b+c):a)(end)";
    NSLog(@"%@, valid: %@", string, [self stringWithValidBrackets:string]);
    // [self printStringWithValidBrackets:string];
    
    string = @"()";
    NSLog(@"%@, valid: %@", string, [self stringWithValidBrackets:string]);
    // [self printStringWithValidBrackets:string];
    
    string = @"(())";
    NSLog(@"%@, valid: %@", string, [self stringWithValidBrackets:string]);
    // [self printStringWithValidBrackets:string];
}

/*
 Case 1: a(b))(be) -> a(b)(be)
 Case 2: (a(b) - Need to remove one (
 Algorithm:
 1. Count every (
 2. For every ), check if there's ( in stack. If yes, subtract ( count and add ) to string; if no, skip it.
 3. When first traverse is done, if count==0, return string
 4. If count > 0, traverse the string and remove all the ( till count reaches to zero.
 */
- (NSString *)stringWithValidBrackets:(NSString *)string {
    NSString *valid = [NSMutableString new];
    NSInteger brackets = 0;
    for (NSUInteger i = 0; i < string.length; i++) {
        unichar c = [string characterAtIndex:i];
        if (c == ')' && brackets <= 0) {
            continue;
        }
        if (c == '(') {
            brackets++;
        }
        else if (c == ')') {
            brackets--;
        }
        valid = [valid stringByAppendingString:[NSString stringWithFormat:@"%c", c]];
    }
    NSUInteger i=0;
    while (brackets > 0 && i < valid.length) {
        unichar c = [string characterAtIndex:i];
        if (c == '(') {
            valid = [valid stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@""];
            brackets--;
        }
        i++;
    }
    return valid;
}

- (void)printStringWithValidBrackets:(NSString *)string {
    NSMutableArray *strings = [NSMutableArray new];
    [strings addObject:string];
    NSUInteger idx = 0;
    NSUInteger count = strings.count;
    while (idx < count) {
        NSArray *array = [self correctBracketsStrings:strings[idx]];
        if (array.count == 0) {
            printf("%s\n", [strings[idx] UTF8String]);
        }
        count += array.count;
        [strings addObjectsFromArray:array];
        idx++;
    }
}

- (NSArray *)correctBracketsStrings:(NSString *)string {
    NSMutableArray *openStack = [NSMutableArray new];
    NSMutableArray *closeStack = [NSMutableArray new];
    NSMutableArray *array = [NSMutableArray new];
    if (string == nil || string.length == 0) {
        return NO;
    }
    NSInteger openBracket = 0;
    
    for (NSUInteger idx=0; idx<string.length; idx++) {
        unichar character = [string characterAtIndex:idx];
        if (character == '(') {
            openBracket++;
            [openStack addObject:@(idx)];
        }
        else if (character == ')') {
            if (openBracket == 0) {
                [closeStack addObject:@(idx)];
            }
            else {
                openBracket--;
                [openStack removeLastObject];
            }
        }
    }
    for (NSNumber *index in openStack) {
        NSMutableString *temp = [NSMutableString stringWithString:string];
        [temp deleteCharactersInRange:NSMakeRange([index integerValue], 1)];
        [array addObject:temp];
    }
    for (NSNumber *index in closeStack) {
        NSMutableString *temp = [NSMutableString stringWithString:string];
        [temp deleteCharactersInRange:NSMakeRange([index integerValue], 1)];
        [array addObject:temp];
    }
    return array;
}

// Hulu
// 1: [()]
// 2: ["(())", "()()"]
// 3: [((())), (())(), ()(()), (()()), ...]
// Input: positive integer
// Output: NSArray: each element contains a string of () permutations
// Needs to be valid open/close brackets (), invalid: )()(

/*
 3/2/18: Algorithm
 1. Print n-1 pair of brackets in string: n=3 => ()()
 2. Insert a pair of bracket in the string for each position: 0.()() 1.(())() 2.()()() 3.()(())
 3. For each insertion, save the permutation in the array
 4. Take out the inserted bracket
 */
- (NSSet *)permutateBracketsIterative:(int)n {
    if (n==0) {
        return nil;
    }
    NSString *brackets = [NSString new];
    NSMutableSet *permutations = [NSMutableSet new];
    for (int i=0; i<n-1; i++) {
        brackets = [brackets stringByAppendingString:@"()"];
    }
    NSLog(@"Initial string: %@", brackets);
    for (int i=0; i<n*2-2; i++) {
        NSMutableString *permutate = [NSMutableString stringWithString:brackets];
        [permutate insertString:@"()" atIndex:i];
        NSLog(@"p%d: %@", i, permutate);
        [permutations addObject:permutate];
    }
    return permutations;
}

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
 ABC ->ABC ACB BAC BCA CBA CAB
 Algorithm:
 a->bc, b->ac, c-ab
 ab->c, ac->b, ba->c, bc->a, ca->b, cb->a
 
 i  s1  s2
 0  a   bc
 Time complexity: O(n) to print all string, and O(n!) permutation = O(n*n!)
 4!=4x3x2x1=24
 How to handle duplicate strings?
 1. Use NSSet to store strings but space is n! because there are worst case n! permutation
 2. For each swap, check if there will be duplicate between start char to current char. If yes, don't swap
 3. Time complexity should be O(n*n*n!) because for each swap, we need to check swappable from start to current, with each check smaller
 */
- (void)permutateString:(NSString *)string {
    [self permutate:string start:0];
}

- (void)permutate:(NSString *)string start:(NSUInteger)start {
    if (start == string.length-1) {
        NSLog(@"Final: %@", string);
        return;
    }
    else {
        // Swap  start index and next character
        // Increment start index by 1 and recursive
        // After recursive call, swap back to origin string and ready for next character until end of string
        // a->bc, b->ac, c->ba
        for (NSUInteger i=start; i<string.length; i++) {
            // To create only distinct set, check if same two characters swap already happened. If yes, don't swap and permutate
            if ([self shouldSwapString:string start:start current:i]) {
                string = [self swapString:string start:start end:i];
//                NSLog(@"s1: %@", string);
                [self permutate:string start:start+1];
                string = [self swapString:string start:start end:i];
//                NSLog(@"s2: %@", string);
            }
        }
    }
}
// Check if there is any repeated characters from start to current index. If yes, return NO;
- (BOOL)shouldSwapString:(NSString *)string start:(NSUInteger)start current:(NSUInteger)current {
    for (NSUInteger i=start; i<current; i++) {
        if ([string characterAtIndex:current] == [string characterAtIndex:i]) {
            return NO;
        }
    }
    return YES;
}

- (NSString *)swapString:(NSString *)string start:(NSUInteger)start end:(NSUInteger)end {
    NSString *c1 = [NSString stringWithFormat:@"%c", [string characterAtIndex:start]];
    NSString *c2 = [NSString stringWithFormat:@"%c", [string characterAtIndex:end]];
    string = [string stringByReplacingCharactersInRange:NSMakeRange(start, 1) withString:c2];
    string = [string stringByReplacingCharactersInRange:NSMakeRange(end, 1) withString:c1];
    return string;
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

- (void)palindromeSetup {
    NSString *string = @"abba";
    printf("%s is palindrom? %d\n", [string UTF8String], [self isPalindrome:string]);
    
    string = @"abzba";
    printf("%s is palindrom? %d\n", [string UTF8String], [self isPalindrome:string]);
    
    string = @"a";
    printf("%s is palindrom? %d\n", [string UTF8String], [self isPalindrome:string]);
    
    string = @"";
    printf("%s is palindrom? %d\n", [string UTF8String], [self isPalindrome:string]);
    
    string = @"ab";
    printf("%s is palindrom? %d\n", [string UTF8String], [self isPalindrome:string]);
    
    string = @"11";
    printf("%s is palindrom? %d\n", [string UTF8String], [self isPalindrome:string]);
}

/*
 - Compare from the first and last character of the string
 - When start >= end, stop
 - abba, start=2, end=1, stop
 - abcba, start=2, end=2, stop
 - Is single character a palindrome? Yes
 */

- (BOOL)isPalindrome:(NSString *)string {
    if (string.length == 0) {
        return NO;
    }
    NSUInteger start = 0;
    NSUInteger end = string.length-1;
    while (start < end) {
        if ([string characterAtIndex:start] != [string characterAtIndex:end]) {
            return NO;
        }
        start++;
        end--;
    }
    return YES;
}

/*
 Amazon onsite 12/9/16
 1. Write a method print out the word count for a string
 2. Leverage the previous method, write a method that reads a book from a text file (assume many pages) and print the top k words
 */

- (void)wordCountSetup {
    [self topWords:@"fake filename" rank:3];
}

- (void)topWords:(NSString *)filename rank:(NSUInteger)rank {
    NSArray *pages = [self buildPagesFromFile:filename];
    NSCountedSet *counts = [NSCountedSet new];
    
    // runtime = O(p*w), p=total number of pages, w=number of words counted
    for (NSString *page in pages) {
        NSCountedSet *set = [self wordCount:page];
        [counts unionSet:set];
    }
    
    // sorting = w*log(w)
    NSMutableArray *unsortedCounts = [NSMutableArray new];
    for (NSString *word in counts) {
        NSDictionary *dict = @{@"word": word, @"count": @([counts countForObject:word])};
        [unsortedCounts addObject:dict];
    }
    NSArray *sortedCounts = [unsortedCounts sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"count" ascending:NO]]];
    NSUInteger topK = sortedCounts.count < rank ? counts.count : rank;
    
    // O(k), worst case O(w).
    // Final runtime in worst case = p*w+w*log(w)+w = w*(p+log(w))+w = w*(p+1+log(w)) w*(p+log(w))
    for (NSUInteger i=0; i<topK; i++) {
        NSDictionary *wordCount = sortedCounts[i];
        NSLog(@"%@: %@", wordCount[@"word"], wordCount[@"count"]);
    }
}

- (NSCountedSet *)wordCount:(NSString *)page {
    NSArray *words = [page componentsSeparatedByString:@" "];
    NSCountedSet *counts = [NSCountedSet new];
    for (NSString *word in words) {
        [counts addObject:word];
    }
    return counts;
}

- (NSArray *)buildPagesFromFile:(NSString *)filename {
    NSString *page1 = @"This is page 1";
    NSString *page2 = @"This is page 2 with nothing new";
    NSString *page3 = @"page 3 is kind of same as page 2";
    return @[page1, page2, page3];
}

@end
