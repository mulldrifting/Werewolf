//
//  Villager.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Villager.h"

@implementation Villager

-(id)init
{
    if (self = [super init])
    {
        self.name = @"Villager";
        self.faction = @"Villager";
    }
    
    return self;
}

@end
