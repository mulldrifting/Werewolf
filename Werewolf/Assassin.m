//
//  Assassin.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Assassin.h"

@implementation Assassin

-(id)initWithGame:(Game*)game
{
    if (self = [super initWithGame:game])
    {
        self.name = @"Assassin";
        self.faction = @"Assassin";
        self.roleID = kAssassin;
    }
    
    return self;
}

@end
