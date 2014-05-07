//
//  NightActionController.m
//  Werewolf
//
//  Created by Lauren Lee on 5/1/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "NightActionController.h"
#import "Role.h"
#import "Player.h"
#import "Werewolf.h"
#import "Villager.h"
#import "Priest.h"
#import "Seer.h"
#import "Vigilante.h"
#import "Hunter.h"
#import "Minion.h"
#import "Assassin.h"

roleType _roleTypes;

@implementation NightActionController

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
            [_game.wolfTargets addObject:player];
            break;
        case kSeer:
            [_game.currentPlayer.seerPeeks addObject:player];
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
    
//    [_delegate createAlertViewOfType:kNightActionConfirm];
}

//- (NSString*)getNightActionConfirmTitle
//{
//    NSString *title = @"";
//    
//    switch (_game.currentPlayer.role.roleID) {
//            
//        case kVillager:
//        case kAssassin:
//        case kHunter:
//        case kMinion:
//            title = @"Your Selection Was Stored";
//            return title;
//            
//        case kPriest:
//            title = @"Your Target Will Be Saved";
//            return title;
//            
//        case kWerewolf:
//        case kVigilante:
//            title = @"You've Chosen A Kill Target";
//            return title;
//
//        case kSeer:
//            title = @"You Take A Peek";
//            return title;
//            
//        default:
//            return title;
//    }
//
//}

- (NSString*)getNightActionConfirmMessageForPlayer:(Player*)player
{
    NSString *message = @"";
    
    switch (_game.currentPlayer.role.roleID) {
            
        case kVillager:
        case kAssassin:
        case kHunter:
        case kMinion:
            message = @"You'll get to see if you're right at the end of the game!";
            return message;
            
        case kPriest:
            message = @"If they were selected by the Werewolves or the Vigilante, they will be saved.";
            return message;
            
        case kWerewolf:
        case kVigilante:
            message = @"Assuming no Priest saves them, your target will be dead by morning.";
            return message;
            
        case kSeer:
            message = [NSString stringWithFormat:@"%@ looks like a %@", player.name, player.role.seerSeesAs];
            return message;
            
        default:
            return message;
    }
}

@end
