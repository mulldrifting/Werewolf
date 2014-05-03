//
//  AlertViewDelegate.m
//  Werewolf
//
//  Created by Lauren Lee on 5/2/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "AlertViewDelegate.h"
#import "Player.h"

@implementation AlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *textField;
    
    Player *currentSelectedPlayer = _game.players[_carousel.currentItemIndex];
    
    switch (alertView.tag) {
            
        case ALERT_VIEW_TAG + kNameEntry:
            
            // Allows moderator to enter a player name
            
            textField = [alertView textFieldAtIndex:0];
            
            if (buttonIndex == 1) {
                [currentSelectedPlayer setName:textField.text];
                [_carousel reloadData];
                if (_game.isNight) {
                    [self createAlertViewOfType:kConfirmation];
                }
            }
            break;
            
        case ALERT_VIEW_TAG + kConfirmation:
            
            // Asks Player "Are you ready to see your role?"
            
            if (buttonIndex == 0) {
                [self showViewOfType:kPassToPlayer]; // Wrong person!
            }
            else if (buttonIndex == 1) {
                [self createAlertViewOfType:kShowRoleAlert]; // Yes! Show role
            }
            else if (buttonIndex == 2) {
                [self createAlertViewOfType:kNameEntry]; // Name incorrect! Change
            }
            
            break;
            
        case ALERT_VIEW_TAG + kShowRoleAlert:
            
            // Shows Player their role and role information
            
            if (buttonIndex == 0) {
                [self showViewOfType:kPassRight];
            }
            
            break;
            
        case ALERT_VIEW_TAG + kKillPlayer:
            
            // Selects player to kill
            
            if (buttonIndex == 1) {
                // Kill player
                
                [_game killPlayerAtIndex:_carousel.currentItemIndex];
                [self beginNight];
                
                [_carousel reloadData];
            }
            
            break;
            
        case ALERT_VIEW_TAG + kNoKillConfirmation:
            
            if (buttonIndex == 1) {
                [self beginNight];
            }
            
            break;
            
        case ALERT_VIEW_TAG + kAreYouX:
            
            if (buttonIndex == 1) {
                
            }
            else {
                [self showViewOfType:kPassToPlayer];
            }
            
            break;
            
        default:
            
            break;
    }
}


@end
