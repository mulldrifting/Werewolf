//
//  Vigilante.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Vigilante.h"

@implementation Vigilante

-(id)initWithGame:(Game*)game
{
    if (self = [super initWithGame:game])
    {
        self.name = @"Vigilante";
        self.roleID = kVigilante;
    }
    
    return self;
}

@end
