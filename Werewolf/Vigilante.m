//
//  Vigilante.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Vigilante.h"

@implementation Vigilante

-(id)init
{
    if (self = [super init])
    {
        self.name = @"Vigilante";
        self.faction = @"Villager";
        self.roleID = kVigilante;
    }
    
    return self;
}

@end
