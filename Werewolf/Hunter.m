//
//  Hunter.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Hunter.h"

@implementation Hunter

-(id)init
{
    if (self = [super init])
    {
        self.name = @"Hunter";
        self.faction = @"Villager";
    }
    
    return self;
}
@end
