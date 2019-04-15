//
//  Set.m
//  algorithm_objc
//
//  Created by ling, stephen on 3/23/19.
//  Copyright © 2019 sling. All rights reserved.
//

#import "Set.h"

@implementation Set

- (void)setup {
	[self printAllSubsetsSetup];
}

- (void)printAllSubsetsSetup {
	NSArray *s = @[@1, @2, @3];
	[self printAllSubsets:s index:0 set:[NSMutableSet new]];
}

	// assumption: each element in set is unique
- (void)printAllSubsets:(NSArray *)s index:(int)i set:(NSMutableSet *)sets {
	if (i >= s.count) {
		NSLog(@"s:%@", sets);
		return;
	}
	[sets addObject:s[i]];
	[self printAllSubsets:s index:i+1 set:sets];
	[sets removeObject:s[i]];
	[self printAllSubsets:s index:i+1 set:sets];
	return;
}

@end
