//
//  Priest.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Priest.h"

@implementation Priest

-(id)init
{
    if (self = [super init])
    {
        self.name = @"Priest";
        self.faction = @"Villager";
        self.seerSees = @"Villager";
        self.roleID = kPriest;
    }
    
    return self;
}

@end
