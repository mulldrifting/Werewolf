//
//  Seer.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Seer.h"

@implementation Seer

-(id)init
{
    if (self = [super init])
    {
        self.name = @"Seer";
        self.faction = @"Villager";
        self.seerSees = @"Villager";
        self.roleID = kSeer;
    }
    
    return self;
}

@end
