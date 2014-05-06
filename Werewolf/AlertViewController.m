////
////  AlertViewController.m
////  Werewolf
////
////  Created by Lauren Lee on 5/5/14.
////  Copyright (c) 2014 Lauren Lee. All rights reserved.
////
//
//#import "AlertViewController.h"
//
//@implementation AlertViewController
//
//-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    if (alertView.tag == ALERT_VIEW_TAG + kNameEntry) {
//        
//        Player *currentSelectedPlayer = _game.players[_carousel.currentItemIndex];
//        UITextField *textField = [alertView textFieldAtIndex:0];
//        
//        if (buttonIndex == 1) {
//            if ([_game isDuplicateName:textField.text]) {
//                [alertView setMessage:@"That's the same name as someone else. Pick another."];
//            }
//            else {
//                [currentSelectedPlayer setName:textField.text];
//                [_carousel reloadData];
//                if (_game.isNight) {
//                    [self createAlertViewOfType:kReadyToSeeRole];
//                }
//            }
//        }
//    }
//}
//
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    UITextField *textField;
//    
//    Player *currentSelectedPlayer = _game.players[_carousel.currentItemIndex];
//    
//    switch (alertView.tag) {
//            
//        case ALERT_VIEW_TAG + kNameEntry:
//            
//            // Allows moderator to enter a player name
//            
//            textField = [alertView textFieldAtIndex:0];
//            
//            if (buttonIndex == 1) {
//                
//                [currentSelectedPlayer setName:textField.text];
//                [_carousel reloadData];
//                if (_game.isNight) {
//                    [self createAlertViewOfType:kReadyToSeeRole];
//                }
//            }
//            break;
//            
//        case ALERT_VIEW_TAG + kReadyToSeeRole:
//            
//            // Asks Player "Are you ready to see your role?"
//            
//            if (buttonIndex == 0) {
//                [self showViewOfType:kPassToPlayer]; // Wrong person!
//            }
//            else if (buttonIndex == 1) {
//                [self createAlertViewOfType:kShowRoleAlert]; // Yes! Show role
//            }
//            else if (buttonIndex == 2) {
//                [self createAlertViewOfType:kNameEntry]; // Name incorrect! Change
//            }
//            
//            break;
//            
//        case ALERT_VIEW_TAG + kShowRoleAlert:
//            
//            // Shows Player their role and role information
//            
//            if (buttonIndex == 0) {
//                [self showViewOfType:kPassRight];
//                [self moveToNextPlayer];
//            }
//            
//            break;
//            
//        case ALERT_VIEW_TAG + kKillPlayer:
//            
//            // Selects player to kill
//            
//            if (buttonIndex == 1) {
//                // Kill player
//                
//                [_game killPlayerAtIndex:_carousel.currentItemIndex];
//                [self beginNight];
//                
//                [_carousel reloadData];
//            }
//            
//            break;
//            
//        case ALERT_VIEW_TAG + kNoKillConfirmation:
//            
//            if (buttonIndex == 1) {
//                [self beginNight];
//            }
//            
//            break;
//            
//        case ALERT_VIEW_TAG + kAreYouX:
//            
//            if (buttonIndex == 1) {
//                [_nightActionController startNightActionWithPlayer:_game.currentPlayer];
//            }
//            else {
//                [self showViewOfType:kPassToPlayer];
//            }
//            
//            break;
//            
//            
//        case ALERT_VIEW_TAG + kNightAction:
//            
//            if (buttonIndex == 1) {
//                [_nightActionController handleNightActionWithSelectedPlayer:currentSelectedPlayer];
//                if (![_game.currentPlayer.role isKindOfClass:[Seer class]]) {
//                    [self showViewOfType:kPassRight];
//                    [self moveToNextPlayer];
//                    
//                }
//            }
//            
//            break;
//            
//        case ALERT_VIEW_TAG + kSeerPeek:
//            
//            if (buttonIndex == 0) {
//                [self showViewOfType:kPassRight];
//                [self moveToNextPlayer];
//                
//            }
//            break;
//            
//        default:
//            
//            break;
//    }
//}
//
//- (void)createNameEntryAlertView
//{
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Enter Name Of Player"
//                                            message:@""
//                                           delegate:self
//                                  cancelButtonTitle:@"Cancel"
//                                  otherButtonTitles:@"Submit", nil];
//}
//
//- (void)createAlertViewOfType:(NSInteger)type
//{
//    Player *currentSelectedPlayer = _game.players[_carousel.currentItemIndex];
//    
//    switch (type) {
//            
//        {case kNameEntry:
//            
//            _alertView = [[UIAlertView alloc] initWithTitle:@"Enter Name Of Player"
//                                                    message:@""
//                                                   delegate:self
//                                          cancelButtonTitle:@"Cancel"
//                                          otherButtonTitles:@"Submit", nil];
//            
//            
//            
//            //            switch (_game.currentPlayerIndex) {
//            //                case 0:
//            //                    _alertView = [[UIAlertView alloc] initWithTitle:@"Hello Moderator!" message:@"Please enter everyone's names, starting with yours" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//            //                    break;
//            //                case 1:
//            //                    _alertView = [[UIAlertView alloc] initWithTitle:@"Enter The Name Of The Player To Your Right" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//            //                    break;
//            //                default:
//            //                    _alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Enter The Name Of The Player To The Right Of %@", _game.previousPlayer.name] message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//            //                    break;
//            //            }
//            
//            _alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
//            _alertView.tag = ALERT_VIEW_TAG + kNameEntry;
//            [[_alertView textFieldAtIndex:0] setDelegate:self];
//            [[_alertView textFieldAtIndex:0] setText:[currentSelectedPlayer name]];
//            [[_alertView textFieldAtIndex:0] setClearButtonMode:UITextFieldViewModeWhileEditing];
//            
//            break;
//        }
//            
//        {case kReadyToSeeRole:
//            
//            
//            _alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Hello %@", _game.currentPlayer.name]
//                                                    message:@"Ready to see your role?"
//                                                   delegate:self
//                                          cancelButtonTitle:[NSString stringWithFormat:@"I'm not %@!", _game.currentPlayer.name]
//                                          otherButtonTitles: @"Yes, show me my role!", @"Yes, but let me fix my name", nil];
//            _alertView.tag = ALERT_VIEW_TAG + kReadyToSeeRole;
//            break;
//        }
//            
//        {case kKillPlayer:
//            
//            _alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Kill %@?", currentSelectedPlayer.name]
//                                                    message:@""
//                                                   delegate:self
//                                          cancelButtonTitle:@"No"
//                                          otherButtonTitles: @"Yes", nil];
//            _alertView.tag = ALERT_VIEW_TAG + kKillPlayer;
//            break;}
//            
//        case kShowRoleAlert:
//            
//            _alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Your Role: %@", [_game.currentPlayer.role name]]
//                                                    message:[_nightActionController getRoleInfoForPlayer:_game.currentPlayer]
//                                                   delegate:self
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles: nil];
//            _alertView.tag = ALERT_VIEW_TAG + kShowRoleAlert;
//            break;
//            
//        case kNoKillConfirmation:
//            
//            _alertView = [[UIAlertView alloc] initWithTitle:@"Are You Sure?"
//                                                    message:@"Not killing is usually inadvisable for the village"
//                                                   delegate:self
//                                          cancelButtonTitle:@"Cancel"
//                                          otherButtonTitles:@"We're sure", nil];
//            _alertView.tag = ALERT_VIEW_TAG + kNoKillConfirmation;
//            break;
//            
//        case kAreYouX:
//            
//            _alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Are You %@?", [_game.currentPlayer name]]
//                                                    message:@""
//                                                   delegate:self
//                                          cancelButtonTitle:@"No"
//                                          otherButtonTitles:@"Yes", nil];
//            _alertView.tag = ALERT_VIEW_TAG + kAreYouX;
//            break;
//            
//        case kNightAction:
//            
//            _alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"You've selected %@", [currentSelectedPlayer name]]
//                                                    message:@"Final answer?"
//                                                   delegate:self
//                                          cancelButtonTitle:@"No"
//                                          otherButtonTitles:@"Yes", nil];
//            _alertView.tag = ALERT_VIEW_TAG + kNightAction;
//            break;
//            
//        case kSeerPeek:
//            
//            _alertView = [[UIAlertView alloc] initWithTitle:@"You Take A Peek"
//                                                    message:[NSString stringWithFormat:@"%@ looks like a %@", currentSelectedPlayer.name, currentSelectedPlayer.role.seerSeesAs]
//                                                   delegate:self
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//            _alertView.tag = ALERT_VIEW_TAG + kSeerPeek;
//            break;
//            
//        default:
//            NSLog(@"unknown alert type: %d", type);
//            break;
//    }
//    
//    _alertView.transform = CGAffineTransformTranslate(_alertView.transform, 0, -100.0);
//    [_alertView show];
//}
//
//
//- (void)showPassToAlertView
//{
//    Player *currentPlayer = _game.players[_carousel.currentItemIndex];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Pass the device to %@", currentPlayer.name] message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    //    alertView.tag = PASS_TO_ALERT_TAG;
//    [alertView show];
//    
//}
//
//- (void)showRoleAlertView
//{
//    Player *currentPlayer = _game.players[_game.currentPlayerIndex];
//    NSString *additionalMessage = @"";
//    //    additionalMessage = [_nightActionController createSecretMessageForPlayer:currentPlayer];
//    
//    
//    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Your Role: %@", currentPlayer.role.name]
//                                                        message:additionalMessage
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles: nil];
//    //    alertView.tag = SHOW_ROLE_ALERT_TAG;
//    [alertView show];
//}
//
//-(BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
//{
//    if (alertView.tag == ALERT_VIEW_TAG + kNameEntry) {
//        UITextField *textfield = [alertView textFieldAtIndex:0];
//        
//        if ([textfield.text length] > 0) {
//            if ([_game isDuplicateName:textfield.text]) {
//                [alertView setMessage:@"Same or duplicate name! Please change to something different."];
//                return NO;
//            }
//            else
//            {
//                [alertView setMessage:@""];
//                return YES;
//            }
//        }
//        return NO;
//    }
//    
//    return YES;
//}
//
//@end
