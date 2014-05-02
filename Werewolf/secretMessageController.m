//
//  secretMessageController.m
//  Werewolf
//
//  Created by Lauren Lee on 5/1/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "secretMessageController.h"


@implementation secretMessageController

-(NSString *)createSecretMessageForPlayer:(Player *)player
{
    switch (player.role.roleID) {
        case kWerewolf:
            
            // loop through the player array and find other werewolves
            return @"Werewolves!";
            
        default:
            return @"";
    }
}

@end
