//
//  Constants.m
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Constants.h"

@implementation Constants

+ (NSArray *)listOfDefinedRoles
{
    static NSArray *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = @[
                 @"Villager",
                 @"Werewolf",
                 @"Seer",
                 @"Priest",
                 @"Vigilante",
                 @"Hunter",
                 @"Minion",
                 @"Assassin"
                 ];
    });
    return inst;
}

+ (NSDictionary *)defaultSettings
{
    static NSDictionary *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = @{@"DAY_KILL_ANNOUNCED": @YES,
                 @"NIGHT_KILL_ANNOUNCED": @NO,
                 @"WOLVES_SEE_ROLE_OF_KILL": @YES,
                 @"PRIEST_CAN_TARGET_SELF": @YES,
                 @"PRIEST_CAN_TARGET_SAME_PERSON_TWICE_IN_A_ROW": @NO,
                 @"SEER_PEEKS_NIGHT_ZERO": @NO,
                 @"SEER_SEES_ROLE":@NO,
                 @"VIGILANTE_KILLS_AT_NIGHT": @NO,
                 @"VIGILANTE_KILLS_ONCE_PER_GAME": @YES
                 
                 };
    });
    return inst;
}

@end
