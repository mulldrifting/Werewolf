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
    NSString *message = [Constants listOfRoleDescriptions][player.role.roleID];
    Player *randomPlayer;
    
    switch (player.role.roleID) {
            
        case kVillager:
        case kPriest:
        case kVigilante:
        case kHunter:
            return message;
            
        case kWerewolf:
        case kMinion:
            message = [message stringByAppendingString:@"\n\nThe wolves are:\n"];
            for (Player *player in _game.players) {
                if ([player.role isKindOfClass:[Werewolf class]]) {
                    message = [message stringByAppendingString:[NSString stringWithFormat:@"%@\n", player.name]];
                }
            }
            return message;
            
        case kSeer:
            randomPlayer = [_game randomNonWerewolf];
            if ([_game.gameSetup.settings objectForKey:@"SEER_PEEKS_NIGHT_ZERO"]) {
                message = [message stringByAppendingString:[NSString stringWithFormat:@"\n\n%@ looks like a %@", randomPlayer.name, randomPlayer.role.seerSees]];
            }
            return message;
            
        case kAssassin:
            player.target = [[_game randomVillager] name];
            message = [message stringByAppendingString:[NSString stringWithFormat:@"\n\nYour target is:\n%@", [[_game randomVillager] name]]];
            return message;
            
        default:
            return message;
    }
}

-(void)startNightAction
{
    switch (_game.currentPlayer.role.roleID) {
        case kVillager:
        case kHunter:
        case kAssassin:
            [self.delegate updateTapLabelWithString:@"WHO IS WOLF?"];
            break;
        case kWerewolf:
            [self.delegate updateTapLabelWithString:@"WHO TO KILL?"];
            break;
        case kSeer:
            [self.delegate updateTapLabelWithString:@"WHO TO PEEK?"];
            break;
        case kPriest:
            [self.delegate updateTapLabelWithString:@"WHO TO SAVE?"];
            break;
        case kVigilante:
            [self.delegate updateTapLabelWithString:@"WHO TO KILL?"];
            break;
        case kMinion:
            [self.delegate updateTapLabelWithString:@"WHO SHOULD DIE?"];
            break;
        default:
            break;
    }
}

-(void)handleNightActionWithSelectedPlayer:(Player *)player
{
    switch (_game.currentPlayer.role.roleID) {
        case kVillager:
        case kHunter:
        case kMinion:
        case kAssassin:
            [_game.currentPlayer.nightGuesses addObject:player];
            break;
        case kWerewolf:
            player.isWolfTarget = YES;
            break;
        case kSeer:
            
            break;
        case kPriest:
            player.isPriestTarget = YES;
            break;
        case kVigilante:
            player.isVigilanteTarget = YES;
            break;
            
        default:
            break;
    }
}

@end
