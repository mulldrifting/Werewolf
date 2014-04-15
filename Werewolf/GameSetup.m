//
//  GameSetup.m
//  Werewolf
//
//  Created by Lauren Lee on 4/13/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "GameSetup.h"

@implementation GameSetup

-(id)init
{
    if (self = [super init])
    {
        _name = @"9P Classic";
        _roles = @{
                   @"Villager": [NSNumber numberWithInt:5],
                   @"Werewolf": [NSNumber numberWithInt:2],
                   @"Seer": [NSNumber numberWithInt:1],
                   @"Priest": [NSNumber numberWithInt:1],
                   @"Vigilante": [NSNumber numberWithInt:1],
                   @"Minion": [NSNumber numberWithInt:1],
                   @"Hunter": [NSNumber numberWithInt:1],
                   @"Assassin": [NSNumber numberWithInt:1]};
    }
    return self;
}

@end
