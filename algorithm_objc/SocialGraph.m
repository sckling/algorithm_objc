//
//  SocialGraph.m
//  algorithm_objc
//
//  Created by Stephen Ling on 11/10/15.
//  Copyright © 2015 sling. All rights reserved.
//

#import "SocialGraph.h"

@implementation SocialGraph

/*
 * vector<string> getDirectFriendsForUser(string user)
 * vector<string> getAttendedCoursesForUser(string user)
 *
 * #import <Foundation/Foundation.h>
 * Rewrite the library functions in Objective C:
 * - (NSArray *)getDirectFriendsForUser(NSString *user);
 * - (NSArray *)getAttendedCoursesForUser(NSString *user);
 *
 * Complete the function below.
 */

/* Code below is Objective C
 * Algorithm:
 * Use breadth first search to traverse the graph, starting from the user from input.
 * Keep track of traverse level and stops after level 2.
 * For each user, obtain all of his/her attended courses and store them in a dictionary. Key is the course name, value is the number of attendees.
 * When done, sort the dictionary by values and store the keys (course names) in an array in descending order. Return this array.
 */

/*
 Test for user with no direct friends (getDirectFriendsForUser returns nil).
 Test for empty array returns from getAttendedCoursesForUser.
 Test for cycle/loop in the social graph (a friend from an user contains the user as a friend).
 
 Time complexity is O(V*C+E).
 V is the total number of vertices (users in this case).
 C is the total number of attended course per user (vertex).
 E is the total number of edges.
 */

- (NSArray *)getRankedCourses:(NSString *)user {
    NSMutableArray *currentQueue = [NSMutableArray new];
    NSMutableArray *nextQueue = [NSMutableArray new];
    NSMutableDictionary *coursesDict = [NSMutableDictionary new];
    
    // Original solution did not add the code to ignore courses that the user has attended
    // The solution is to add the courses attended by the user into an NSSet and compare every course to it
    // to determine whether to add it to the recommendation list or not
    NSSet *userAttendedCourses = [self excludeAttendedCoursesFromUser:user];
    NSUInteger friendLevel = 0;
    [currentQueue addObject:user];
    
    while (currentQueue.count > 0) {
        // Dequeue first object from currentQueue
        NSString *currentUser = [currentQueue objectAtIndex:0];
        [currentQueue removeObjectAtIndex:0];
        
        // Process the attended courses from current user and update the dictionary
        coursesDict = [self processAttendedCourses:currentUser dictionary:coursesDict attendedCourses:userAttendedCourses];
        
        // Loop through all the direct friends and put them in nexyQueue. This is used to keep track of friendLevel.
        NSArray *directFriends = [self getDirectFriendsForUser:currentUser];
        for (NSString *friend in directFriends) {
            [nextQueue addObject:friend];
        }
        
        // Check if current level is completed. If yes, update the queues and friendLevel.
        if (currentQueue.count == 0) {
            friendLevel++;
            currentQueue = [nextQueue mutableCopy];
            [nextQueue removeAllObjects];
        }
        
        // If friendLevel is greater than 2, break the cycle as friends from now on won't count.
        if (friendLevel > 2) {
            break;
        }
    }
    
    // Social graph traversal completed. Sort the courses by popularity (higher number of attendees = more popular)
    // At the end, the array orderedKey will contain keys (attended course names)sorted from high to low based on value (number of attendees)
    NSLog(@"courses dict: %@", coursesDict);
    NSArray *orderedKey = [coursesDict keysSortedByValueUsingComparator: ^NSComparisonResult(id obj1, id obj2) {
        return [obj2 compare:obj1];
    }];
    NSLog(@"courses array sorted: %@", orderedKey);
    return orderedKey;
}

- (NSSet *)excludeAttendedCoursesFromUser:(NSString *)user {
    NSMutableSet *coursesSet = [NSMutableSet new];
    NSArray *courses = [self getAttendedCoursesForUser:user];
    for (NSString *course in courses) {
        [coursesSet addObject:course];
    }
    return [coursesSet copy];
}

- (NSMutableDictionary *)processAttendedCourses:(NSString *)user dictionary:(NSMutableDictionary *)coursesDict attendedCourses:(NSSet *)userAttendedCourses {
    NSArray *attendedCourses = [self getAttendedCoursesForUser:user];
    for (NSString *course in attendedCourses) {
        
        // Check if user has attended this course. If not, add to the dictionary for ranking
        if (![userAttendedCourses containsObject:course]) {
            NSNumber *value = [coursesDict objectForKey:course];
            // If value exists for the key, increment the value by 1
            if (value) {
                NSUInteger newValue = [value integerValue] + 1;
                [coursesDict setObject:@(newValue) forKey:course];
            }
            // If value doesn't exist, add it to the key
            else {
                [coursesDict setObject:@1 forKey:course];
            }
        }
    }
    return coursesDict;
}

- (NSArray *)getDirectFriendsForUser:(NSString *)user {
    if ([user isEqualToString:@"Joe"]) {
        return @[@"Sue", @"Amy"];
    }
    if ([user isEqualToString:@"Sue"]) {
        return @[@"Eric", @"Tom", @"Sam"];
    }
    if ([user isEqualToString:@"Amy"]) {
        return @[@"John", @"Mary"];
    }
    if ([user isEqualToString:@"Mary"]) {
        return @[@"Adam", @"Kim"];
    }
    return nil;
}

- (NSArray *)getAttendedCoursesForUser:(NSString *)user {
    if ([user isEqualToString:@"Joe"]) {
        return @[@"CS101", @"ME102"];
    }
    if ([user isEqualToString:@"Sue"]) {
        return @[@"CS101", @"EC102"];
    }
    if ([user isEqualToString:@"Amy"]) {
        return @[@"CS101", @"EE102"];
    }
    if ([user isEqualToString:@"Eric"]) {
        return @[@"AA101", @"CS101"];
    }
    if ([user isEqualToString:@"Tom"]) {
        return @[@"CS101", @"ME102"];
    }
    if ([user isEqualToString:@"John"]) {
        return @[@"CS101", @"ME102"];
    }
    if ([user isEqualToString:@"Mary"]) {
        return @[@"CS101", @"EE102"];
    }
    if ([user isEqualToString:@"Adam"]) {
        return @[@"CS101", @"EE102"];
    }
    if ([user isEqualToString:@"Kim"]) {
        return @[@"CS101", @"EE102"];
    }
    if ([user isEqualToString:@"Sam"]) {
        return @[@"ME102"];
    }
    return nil;
}

/*
 Question #1:
 Setup:
 Assume a primitive social network. This social network has Members.
 
 class Member {
 String name;
 String email;
 List<Member> friends;
 }
 
 Question #2:
 Code printSocialGraph(Member m). Direct friends of m are Level 1 friends. Friends of friends are level 2 friends.....and so on
 Print level 1 friends first. Then print level 2 friends....and so on.  Please state any assumptions that you're making when solving this problem.
 
 void printSocialGraph (Member m){
 //Your code here
 }
 
 */

- (void)printSocialGraphSetup {
    Member *member1 = [[Member alloc] initWithName:@"Sam" memberId:1];
    Member *member2 = [[Member alloc] initWithName:@"John" memberId:2];
    Member *member3 = [[Member alloc] initWithName:@"Kelly" memberId:3];
    Member *member4 = [[Member alloc] initWithName:@"Linda" memberId:4];
    Member *member5 = [[Member alloc] initWithName:@"May" memberId:5];
    Member *member6 = [[Member alloc] initWithName:@"Lone Wolf" memberId:6];
    
    member1.friends = @[member2, member5];
    member2.friends = @[member1, member3, member5];
    member3.friends = @[member2, member4];
    member4.friends = @[member4];
    member5.friends = @[member1, member2];
    
    [self printSocialGraphByLevel:member1 level:2];
    [self printSocialGraphByLevel:member5 level:99];
    [self printSocialGraphByLevel:member6 level:2];
    [self printSocialGraphDfs:nil visited:nil];
    
    /*  _______
       /       \
     May-Sam--John
      |         |
    Linda     Kelly
     
     Sam's friends:
     L0: Sam
     L1: John, May
     L2: Kelly
     L3: Linda
     */
}

- (void)printSocialGraphDfs:(Member *)member visited:(NSMutableSet *)visited {
    if (member == nil) {
        return;
    }
    if (visited == nil) {
        visited = [NSMutableSet new];
    }
    // For each memeber, travser each of his friend/node and go dfs one by one until exhausted
    [visited addObject:member];
    printf("%s, ", [member.name UTF8String]);
    for (int i=0; i<member.friends.count; i++) {
        Member *friend = member.friends[i];
        if ([visited containsObject:friend] == NO) {
            [self printSocialGraphDfs:friend visited:visited];
        }
    }
}

- (void)printSocialGraphByLevel:(Member *)member level:(NSUInteger)level {
    if (member == nil) {
        return;
    }
    NSMutableArray *queue = [NSMutableArray new];
    [queue addObject:member];
    NSMutableSet *visited = [NSMutableSet new];
    [visited addObject:member];
    NSUInteger currentLevel = 0;

    while (queue.count > 0 && currentLevel <= level) {
        NSUInteger levelQueue = queue.count;
        printf("level %ld count: %ld: ", currentLevel++, queue.count);

        while (levelQueue > 0) {
            Member *member = [queue firstObject];
            [queue removeObjectAtIndex:0];
            levelQueue--;
            // This node already visited, now process it
            printf("%s ", [member.name UTF8String]);
            for (NSUInteger i=0; i<member.friends.count; i++) {
                Member *friend = member.friends[i];
                if ([visited containsObject:friend] == NO) {
                    [visited addObject:friend];
                    [queue addObject:friend];
                }
            }
        }
        printf("\n");
    }
}

@end
