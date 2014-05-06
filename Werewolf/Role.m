//
//  Role.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Role.h"


@implementation Role

-(id)initWithGame:(Game *)game
{
    if (self = [super init])
    {
        _game = game;
        _faction = @"Villager";
        _seerSeesAs = @"Non-Werewolf";
    }
    return self;
}

@end
