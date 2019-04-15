//
//  Recursion.m
//  algorithm_objc
//
//  Created by Stephen Ling on 4/14/16.
//  Copyright © 2016 sling. All rights reserved.
//

#import "Recursion.h"

@implementation Recursion

/*
application.js
import "ui/password.js"
<body contains code>

password.js
import "ui/textinput.js"
import "ui/string.js"
<body contains code>

textinput.js
import "ui/string.js"
<body contains code>

string.js
<No header, body contains code>

output file:
string.js
textinput.js
password.js
application.js
 */

//main() {
//    
//    NSString *filename = @”application.js”;
//    
//    searchHeaderFile(filename);
//    
//    return;
//    
//}

//- (void)searchHeaderFile:(NSString *)filename {
//    
//    // helper function to read file and separate each line into an array
//    NSArray *lines = readFile(filename);
//    
//    for (NSString *line in lines) {
//        NSArray *words = [line componentsSeparatedByString:@" "];
//        if (words.count > 0) {
//            if ([words[0] isEqualToString:@"import"]) {
//                NSString *filename = extractFilename(words[words.count-1]);
//                [self searchHeaderFile:filename];
//                NSLog(@"filename: %@", filename);
//            }
//        }
//    }
//}

- (void)setup {
    [self coinChangeSetup];
}

- (void)coinChangeSetup {
    int n=4;
    NSArray *coins = @[@1, @2, @3];
    printf("Answer: %d\n", [self coinChange:coins sum:0 n:n]);
}

/*
 Algorithm
 For each coin, loop through the coin array from the beginning
 When the coin size equal to or greater than the value, back track with next element
 1,1,1,1
 1,1,2
 1,2,1 -> repeat
 2,1,1 -> repeat
 1,3
 3,1 -> repeat
 2,2

 */

- (int)coinChange:(NSArray *)coins sum:(int)sum n:(int)n  {
//    if (sum > n) {
//        printf("Sum exceed: %d\n", sum);
//        return 0;
//    }
    if (sum == n) {
        return 1;
    }
    int combo = 0;
    for (int i=0; i<coins.count; i++) {
        sum = sum + [coins[i] intValue];
        if (sum>n) {
            break;
        }
        combo += [self coinChange:coins sum:sum n:n];
        sum = sum - [coins[i] intValue];
    }
    return combo;
}

- (NSSet *)coinChangeHelper:(int)n position:(int)position coins:(NSArray *)coins change:(NSMutableArray *)change set:(NSMutableSet *)set {
    if (position == n) {
        NSLog(@"set: %@", change);
        if (set == nil) {
            set = [NSMutableSet new];
        }
        [set addObject:change];
        return [set copy];
    }
    if (change == nil) {
        change = [NSMutableArray new];
    }
    for (int i=0; i<coins.count; i++) {
        
    }
    return set;
}

@end
