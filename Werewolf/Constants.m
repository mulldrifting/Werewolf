//
//  Constants.m
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Constants.h"

@implementation Constants

+ (NSArray *)roleArray
{
    static NSArray *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = @[
                 @"Werewolf",
                 @"Seer",
                 @"Priest",
                 @"Vigilante",
                 @"Minion",
                 @"Hunter",
                 @"Assassin",
                 @"Villager"
                 ];
    });
    return inst;
}

@end
