//
//  GameViewController.m
//  Werewolf
//
//  Created by Lauren Lee on 4/25/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "GameViewController.h"
#import "NightActionController.h"
#import "CarouselController.h"
#import "Player.h"
#import "AlphaView.h"


#define ALERT_VIEW_TAG 33700


@interface GameViewController () <UIAlertViewDelegate, UITextFieldDelegate, TimerViewControllerProtocol, CarouselControllerProtocol, NightActionControllerProtocol>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *whereToTapLabel;
@property (weak, nonatomic) IBOutlet UIButton *cornerButton;

@property (strong, nonatomic) NightActionController *nightActionController;
@property (strong, nonatomic) CarouselController *carouselController;

@property (strong, nonatomic) UIAlertView *alertView;
@property (strong, nonatomic) AlphaView *alphaView;
@property (strong, nonatomic) UIView *boxView;

@property (nonatomic) BOOL firstAppearance;

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Game View did Load");
    
    [self setupGameControllers];
    
    _boxView = [[UIView alloc] initWithFrame:CGRectMake(20, 233, 160, 40)];
    [_boxView.layer setBorderWidth:1];
    [_boxView.layer setCornerRadius:5];
    _boxView.layer.masksToBounds = YES;
    [self.view addSubview:_boxView];
    
    [self turnLight];
    [self setupCarousel];
    [self setupButton];
    
    [self.view sendSubviewToBack:_boxView];

    [self updateTapLabelWithString:@"Hello Moderator!\nSelect a player to update their name."];
    
//    [self createAlphaView];
//    [self showPregameExplanationView];
    
    _alphaView = [[AlphaView alloc] initWithFrame:self.view.frame];
    _firstAppearance = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (_firstAppearance) {
        [self beginNameEntry];
//        [_carousel scrollByNumberOfItems:_game.numPlayers duration:1];
        _firstAppearance = NO;
    }
}

- (void)setupGameControllers
{
    _timerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"timer"];
    _timerViewController.game = _game;
    _timerViewController.delegate = self;
    
    _nightActionController = [NightActionController new];
    _nightActionController.game = _game;
    _nightActionController.delegate = self;
    
    _carouselController = [CarouselController new];
    _carouselController.game = _game;
    _carouselController.delegate = self;
}

#pragma mark - Timer View Controller Methods

- (void)showTimerViewController
{
    [self addChildViewController:_timerViewController];
    [self.view addSubview:_timerViewController.view];
    [_timerViewController didMoveToParentViewController:self];
}

- (void)hideTimerViewController
{
    [_timerViewController.view removeFromSuperview];
    [_timerViewController removeFromParentViewController];
}

#pragma mark - Game Mode Methods

- (void)beginNameEntry
{
//    [self createAlertViewOfType:kNameEntry];
}

- (void)getNextNameEntry
{
    [self moveToNextPlayer];
    if (_game.didWrap) {
        NSLog(@"Game did wrap");
        [self showViewOfType:kBeginDay];
    }
    else {
        [self createAlertViewOfType:kNameEntry];
    }

}

- (void)showRoleToNextPlayer
{
    [self moveToNextPlayer];
    if (_game.didWrap) {
        NSLog(@"Game did wrap");
        [self showViewOfType:kBeginDay];
    }
    else {
        [self createAlertViewOfType:kReadyToSeeRole];
    }
}

- (void)moveToNextNightAction
{
    [self moveToNextPlayer];
    
}

// Passing the phone to the next player at night
- (void)moveToNextPlayer
{
    [self dismissAlphaView];
    _game.currentPlayerIndex = [_game nextAlivePlayer:_game.currentPlayerIndex];
    NSLog(@"Move to %@", [_game.currentPlayer name]);
    [_carousel scrollToItemAtIndex:_game.currentPlayerIndex animated:YES];
}

- (void)passedToPlayer
{
    [self dismissAlphaView];
    if (_game.currentRound == 0) {
        [self createAlertViewOfType:kReadyToSeeRole];
    }
    else {
        [self createAlertViewOfType:kNightAction];
    }

}

// Pop open Timer View
- (void)beginDay
{
    [self dismissAlphaView];
    
    _game.currentRound++;
    _game.isNight = NO;
    
    [self showTimerViewController];
    
}

// Let players select person to kill
- (void)beginKillSelection
{
    [self turnLight];
    [_titleLabel setText:@"Who To Kill?"];
    [_cornerButton setTitle:@"No Kill Today" forState:UIControlStateNormal];
    [_cornerButton addTarget:self action:@selector(noKillPressed) forControlEvents:UIControlEventTouchUpInside];
    [_cornerButton setHidden:NO];
    [self resetCarousel];
    
    [self hideTimerViewController];
    
//    [self showKillExplanationView];
    
}

- (void)beginNight
{
    [_cornerButton setHidden:YES];
    [_cornerButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    _titleLabel.text = [NSString stringWithFormat:@"Night %d", _game.currentRound];
    [self turnDark];
    [self resetCarousel];
    _game.isNight = YES;
    if (_game.currentRound == 0) {
        [self createAlertViewOfType:kReadyToSeeRole];
    }
    else
    {
        [self createAlertViewOfType:kAreYouX];
    }
}

- (void)noKillPressed
{
    [self createAlertViewOfType:kNoKillConfirmation];
}

#pragma mark - Changing Skin Methods

- (void)turnDark
{

    //change view to dark skin
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.098 alpha:1.000]];
    [_boxView.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [_carousel reloadData];
}

- (void)turnLight
{
    //change view to light skin
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [_boxView.layer setBorderColor:[UIColor blackColor].CGColor];
    
    [_carousel reloadData];
}

#pragma mark - Button Methods

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupButton
{
    [_cornerButton setTitle:@"Ready To Start" forState:UIControlStateNormal];
    _cornerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_cornerButton addTarget:self action:@selector(beginNight) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Subview Methods

- (void)showAlphaView
{
    [self.view addSubview:_alphaView];
}

-(void)dismissAlphaView
{
    [_alphaView removeFromSuperview];
    [_alphaView reset];
}

- (void)showViewOfType:(NSInteger)type
{
    UITapGestureRecognizer *tapToDismiss;
    
    switch (type) {
            
        case kPassRight:
            
            [_alphaView addBigText:@"PASS\nRIGHT"];
            if (_game.currentRound == 0) {
                tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRoleToNextPlayer)];
            }
            else {
                tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToNextNightAction)];
            }
            [_alphaView addGestureRecognizer:tapToDismiss];
            break;
            
        case kBeginDay:
            
            [_alphaView addBigText:[NSString stringWithFormat:@"BEGIN\nDAY %d",_game.currentRound+1]];
            tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginDay)];
            [_alphaView addGestureRecognizer:tapToDismiss];
            break;
            
        case kPassToPlayer:
            
            [_alphaView addBigText:@"PASS\nTO"];
            [_alphaView addBoxView];
            tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(passedToPlayer)];
            [_alphaView addGestureRecognizer:tapToDismiss];
            break;
            
//        case kShowRoleView:
//            
//
//            break;
//            
//        case kShowNightInfoView:
//            
//            break;
            
        default:
            break;
    }
    
    [self showAlphaView];
}


#pragma mark - Alert View Methods

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
                    [self createAlertViewOfType:kReadyToSeeRole];
                }
            }
            break;
            
        case ALERT_VIEW_TAG + kReadyToSeeRole:
            
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
                [_nightActionController startNightAction];
            }
            else {
                [self showViewOfType:kPassToPlayer];
            }
            
            break;
            
            
        case ALERT_VIEW_TAG + kNightAction:
            
            if (buttonIndex == 1) {
                [_nightActionController handleNightActionWithSelectedPlayer:_game.players[_carousel.currentItemIndex]];
                if (![_game.currentPlayer isKindOfClass:[Seer class]]) {
                    [self moveToNextNightAction];
                }
            }
            
            break;
            
        case ALERT_VIEW_TAG + kSeerPeek:
            
            if (buttonIndex == 0) {
                [self moveToNextNightAction];
            }
            break;
            
        default:
            
            break;
    }
}

- (void)createAlertViewOfType:(NSInteger)type
{
    Player *currentSelectedPlayer = _game.players[_carousel.currentItemIndex];
    
    switch (type) {
            
        {case kNameEntry:
            
        
            _alertView = [[UIAlertView alloc] initWithTitle:@"Enter Name Of Player"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];
            
//            switch (_game.currentPlayerIndex) {
//                case 0:
//                    _alertView = [[UIAlertView alloc] initWithTitle:@"Hello Moderator!" message:@"Please enter everyone's names, starting with yours" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//                    break;
//                case 1:
//                    _alertView = [[UIAlertView alloc] initWithTitle:@"Enter The Name Of The Player To Your Right" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//                    break;
//                default:
//                    _alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Enter The Name Of The Player To The Right Of %@", _game.previousPlayer.name] message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//                    break;
//            }
            
            _alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            _alertView.tag = ALERT_VIEW_TAG + kNameEntry;
            [[_alertView textFieldAtIndex:0] setDelegate:self];
            [[_alertView textFieldAtIndex:0] setText:[currentSelectedPlayer name]];
            [[_alertView textFieldAtIndex:0] setClearButtonMode:UITextFieldViewModeWhileEditing];
            
            break;
        }
            
        {case kReadyToSeeRole:
            
          
            _alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Hello %@", _game.currentPlayer.name]
                                                    message:@"Ready to see your role?"
                                                   delegate:self
                                          cancelButtonTitle:[NSString stringWithFormat:@"I'm not %@!", _game.currentPlayer.name]
                                          otherButtonTitles: @"Yes, show me my role!", @"Yes, but let me fix my name", nil];
            _alertView.tag = ALERT_VIEW_TAG + kReadyToSeeRole;
            break;
        }
            
        {case kKillPlayer:
            
            _alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Kill %@?", currentSelectedPlayer.name]
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles: @"Yes", nil];
            _alertView.tag = ALERT_VIEW_TAG + kKillPlayer;
            break;}
            
        case kShowRoleAlert:
            
            _alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Your Role: %@", [_game.currentPlayer.role name]]
                                                    message:[_nightActionController getRoleInfoForPlayer:_game.currentPlayer]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
            _alertView.tag = ALERT_VIEW_TAG + kShowRoleAlert;
            break;
            
        case kNoKillConfirmation:
            
            _alertView = [[UIAlertView alloc] initWithTitle:@"Are You Sure?"
                                                    message:@"Not killing is usually inadvisable for the village"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"We're sure", nil];
            _alertView.tag = ALERT_VIEW_TAG + kNoKillConfirmation;
            break;
            
        case kAreYouX:
            
            _alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Are You %@?", [_game.currentPlayer name]]
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
            _alertView.tag = ALERT_VIEW_TAG + kAreYouX;
            break;
            
        case kNightAction:
            
            _alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"You've selected %@", [currentSelectedPlayer name]]
                                                    message:@"Final answer?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
            _alertView.tag = ALERT_VIEW_TAG + kNightAction;
            break;
            
        case kSeerPeek:
            
            _alertView = [[UIAlertView alloc] initWithTitle:@"You Take A Peek"
                                                    message:[NSString stringWithFormat:@"%@ looks like a %@", currentSelectedPlayer.name, currentSelectedPlayer.role.seerSees]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
            _alertView.tag = ALERT_VIEW_TAG + kSeerPeek;
            break;
            
        default:
            NSLog(@"unknown alert type: %d", type);
            break;
    }
    
    _alertView.transform = CGAffineTransformTranslate(_alertView.transform, 0, -100.0);
    [_alertView show];
}


- (void)showPassToAlertView
{
    Player *currentPlayer = _game.players[_carousel.currentItemIndex];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Pass the device to %@", currentPlayer.name] message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    alertView.tag = PASS_TO_ALERT_TAG;
    [alertView show];

}

- (void)showRoleAlertView
{
    Player *currentPlayer = _game.players[_game.currentPlayerIndex];
    NSString *additionalMessage = @"";
//    additionalMessage = [_nightActionController createSecretMessageForPlayer:currentPlayer];
    
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Your Role: %@", currentPlayer.role.name]
                                                        message:additionalMessage
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
//    alertView.tag = SHOW_ROLE_ALERT_TAG;
    [alertView show];
}

#pragma mark - iCarousel Methods

-(void)setupCarousel
{
    _carousel.delegate = _carouselController;
    _carousel.dataSource = _carouselController;
    _carousel.type = iCarouselTypeInvertedWheel;
    _carousel.viewpointOffset = CGSizeMake(50, 0);
    _carousel.vertical = YES;
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    if (_carousel.autoscroll > 0) {
//        _carousel.autoscroll = 0;
//        [_carousel scrollToItemAtIndex:0 animated:YES];
//    }
//}

- (void)resetCarousel
{
    _game.currentPlayerIndex = [_game nextAlivePlayer:-1];
    [_carousel scrollToItemAtIndex:0 animated:YES];
    _game.didWrap = NO;
}

#pragma mark - Tap Label Methods

-(void)updateTapLabelWithString:(NSString *)string
{
    [_whereToTapLabel setText:string];
}

-(void)resetTapLabel
{
    [_whereToTapLabel setText:@"TAP TO SELECT:"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
