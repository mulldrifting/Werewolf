//
//  NightActionController.m
//  Werewolf
//
//  Created by Lauren Lee on 5/1/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "NightActionController.h"

roleType _roleTypes;

@implementation NightActionController

-(NSString *)getRoleInfoForPlayer:(Player *)player
{
    NSString *message = @"";
    Player *randomPlayer;
    
    switch (player.role.roleID) {
            
        case kVillager:
        case kPriest:
        case kVigilante:
        case kHunter:
            return message;
            
        case kWerewolf:
        case kMinion:
            message = @"The wolves are:\n";
            for (Player *player in _game.players) {
                if ([player.role isKindOfClass:[Werewolf class]]) {
                    message = [message stringByAppendingString:[NSString stringWithFormat:@"%@\n", player.name]];
                }
            }
            return message;
            
        case kSeer:
            randomPlayer = [_game randomNonWerewolf];
            if ([_game.gameSetup.settings objectForKey:@"SEER_PEEKS_NIGHT_ZERO"]) {
                message = [NSString stringWithFormat:@"%@ looks like a %@", randomPlayer.name, randomPlayer.role.faction];
            }
            return message;
            
        case kAssassin:
            player.role.target = [[_game randomVillager] name];
            message = [NSString stringWithFormat:@"Your target is:\n%@", [[_game randomVillager] name]];
            return message;
            
        default:
            return message;
    }
}

@end
