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

@end
