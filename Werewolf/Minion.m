//
//  Minion.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Minion.h"

@implementation Minion

-(id)init
{
    if (self = [super init])
    {
        self.name = @"Minion";
        self.faction = @"Werewolf";
        self.seerSees = @"Villager";
        self.roleID = kMinion;
    }
    
    return self;
}

@end
