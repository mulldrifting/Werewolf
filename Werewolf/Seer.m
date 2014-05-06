//
//  Seer.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Seer.h"

@implementation Seer

-(id)initWithGame:(Game*)game
{
    if (self = [super initWithGame:game])
    {
        self.name = @"Seer";
        self.roleID = kSeer;
    }
    
    return self;
}

@end
