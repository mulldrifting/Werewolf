//
//  Assassin.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Assassin.h"

@implementation Assassin

-(id)init
{
    if (self = [super init])
    {
        self.name = @"Assassin";
        self.faction = @"Assassin";
        self.roleID = kAssassin;
    }
    
    return self;
}

@end
