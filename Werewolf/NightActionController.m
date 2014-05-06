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

-(void)startNightActionWithPlayer:(Player *)player
{
    NSString *message = @"";
    BOOL isFirstObject = YES;
    
    switch (_game.currentPlayer.role.roleID) {
        case kVillager:
            [self.delegate updateTapLabelWithString:@"Villager, guess who you think the Werewolf is!"];
            break;
        case kHunter:
            [self.delegate updateTapLabelWithString:@"Hunter, guess who you think the Werewolf is!"];
            break;
        case kAssassin:
            [self.delegate updateTapLabelWithString:[NSString stringWithFormat:@"Assassin, your target is %@. Guess who you think the Werewolf is!", player.target]];
            break;
            
        case kWerewolf:

            [self.delegate updateTapLabelWithString:[NSString stringWithFormat:@"%@. Who do you want to kill?", [_game listOfWolves]]];
            
            [self.delegate showNoKillCornerButton];
            
            break;
            
        case kSeer:
            
//            for (Player *aPlayer in player.seerPeeks) {
//                if (isFirstObject) {
//                    message = [message stringByAppendingString:[NSString stringWithFormat:@"%@ (%@)", aPlayer.name, aPlayer.role.seerSeesAs]];
//                    isFirstObject = NO;
//                }
//                else {
//                    message = [message stringByAppendingString:[NSString stringWithFormat:@", %@ (%@)", aPlayer.name, aPlayer.role.seerSeesAs]];
//                }
//
//            }
            
            [self.delegate updateTapLabelWithString:@"Seer, who do you want to peek?"];
            break;
            
        case kPriest:
            [self.delegate updateTapLabelWithString:@"Priest, who do you want to save?"];
            break;
        case kVigilante:
            [self.delegate updateTapLabelWithString:@"Vigilante, Do you want to kill someone tonight? If so, select a Player. If not, select No Kill."];
            [self.delegate showNoKillCornerButton];
            break;
            
        case kMinion:
            
            [self.delegate updateTapLabelWithString:[NSString stringWithFormat:@"%@. Who do you think they should kill tonight?", [_game listOfWolves]]];
            
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
