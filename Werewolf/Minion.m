//
//  Minion.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Minion.h"

@implementation Minion

-(id)initWithGame:(Game*)game
{
    if (self = [super initWithGame:game])
    {
        self.name = @"Minion";
        self.faction = @"Werewolf";
        self.roleID = kMinion;
    }
    
    return self;
}

- (NSString *)getNightZeroInfo
{
    NSString *message = [super getNightZeroInfo];
    
    message = [message stringByAppendingString:[NSString stringWithFormat:@"\n\n%@", [self.game listOfWolves]]];
    
    return message;
}

@end
