//
//  GameViewController.m
//  Werewolf
//
//  Created by Lauren Lee on 4/25/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "GameViewController.h"
#import "Player.h"

#define CONFIRMATION_ALERT_TAG 33700
#define WAIT_ALERT_TAG 33701
#define WRONG_NAME_ALERT_TAG 33702
#define SHOW_ROLE_ALERT_TAG 33703
#define KILL_PLAYER_ALERT_TAG 33704

@interface GameViewController () <iCarouselDataSource, iCarouselDelegate, UIAlertViewDelegate, UITextFieldDelegate, TimerViewControllerProtocol>

@property (weak, nonatomic) IBOutlet UILabel *whereToTapLabel;

@property (strong, nonatomic) UIView *alphaView;
@property (weak, nonatomic) Player *currentPlayer;
@property (nonatomic) NSInteger currentPlayerIndex;
@property (strong, nonatomic) NSString *currentPlayerName;
@property (nonatomic) BOOL isLightSkinMode;

@end

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Game View did Load");
    
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    _isLightSkinMode = YES;
    _currentPlayerIndex = 0;
    
    [self setupCarousel];

//    [self createAlphaView];
    [self showPregameExplanationView];
    [self setupTimerViewController];
}

- (void)moveToNextPlayer
{
    [self dismissAlphaView];

    _currentPlayerIndex++;
    if (_currentPlayerIndex >= _game.numPlayers) {
        
        [self showBeginDayView];
    }
    
    [_carousel scrollToItemAtIndex:_currentPlayerIndex animated:YES];
}

- (void)beginDay
{
    [self dismissAlphaView];
    
    _game.currentRound++;
    _game.isNight = NO;
    
    [self showTimerViewController];
    
}

- (void)beginKillSelection
{
    [self toggleSkin];
    
    _currentPlayerIndex = -1;
    [_carousel scrollToItemAtIndex:_currentPlayerIndex animated:NO];
    
    [self hideTimerViewController];
    
//    [self showKillExplanationView];
    
}

- (void)beginNight
{
    _game.isNight = YES;
}

- (void)toggleSkin
{
    if (_isLightSkinMode) {
        //change view to dark skin
        
        _isLightSkinMode = NO;
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        [self.view setBackgroundColor:[UIColor colorWithWhite:0.098 alpha:1.000]];
    }
    
    else {
        //change view to light skin
        
        _isLightSkinMode = YES;
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    
    [_carousel reloadData];
}

#pragma mark - Timer View Controller Methods

- (void)setupTimerViewController
{
    _timerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"timer"];
    _timerViewController.game = _game;
    _timerViewController.delegate = self;
}

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

#pragma mark - Button Methods

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Subview Methods

- (void)createAlphaView
{
    _alphaView = [[UIView alloc] initWithFrame:self.view.frame];
    [_alphaView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    [self.view addSubview:_alphaView];

}

- (void)showAlphaView
{
    _alphaView = [[UIView alloc] initWithFrame:self.view.frame];
    [_alphaView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.7]];
    [self.view addSubview:_alphaView];
}

-(void)dismissAlphaView
{
    [_alphaView removeFromSuperview];
//    _alphaView.hidden = YES;
}

- (void)showPregameExplanationView
{
    [self showAlphaView];
    
    UIView *explanationView = [[UIView alloc] initWithFrame:CGRectMake(35, 100, 250, 250)];
    [explanationView setBackgroundColor:[UIColor whiteColor]];
    [explanationView setAlpha:1];
    explanationView.layer.cornerRadius = 5;
    explanationView.layer.masksToBounds = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 230, 200)];
    label.text = @"Before we start, one person will be appointed the Moderator. They will be in charge of the timer. Give this to that person.\n\n\nStarting with the Moderator, players will enter their names and get to see their roles.";
    label.font = [label.font fontWithSize:15];
    label.numberOfLines = 20;
    [explanationView addSubview:label];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(180, 210, 50, 30)];
    [button setTitle:@"Got it!" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:0.600 alpha:1.000] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(dismissAlphaView) forControlEvents:UIControlEventTouchUpInside];
    [explanationView addSubview:button];
    
    [_alphaView addSubview:explanationView];
}

- (void)showKillExplanationView
{
//    [self showAlphaView];
    
    UIView *explanationView = [[UIView alloc] initWithFrame:CGRectMake(35, 100, 250, 250)];
    [explanationView setBackgroundColor:[UIColor whiteColor]];
    [explanationView setAlpha:1];
    explanationView.layer.cornerRadius = 5;
    explanationView.layer.masksToBounds = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 230, 200)];
    label.text = @"Presumably the village has come to some sort of decision.\n\nPlease select who to kill.";
    label.font = [label.font fontWithSize:15];
    label.numberOfLines = 10;
    [explanationView addSubview:label];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(180, 210, 50, 30)];
    [button setTitle:@"OK" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:0.600 alpha:1.000] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(dismissAlphaView) forControlEvents:UIControlEventTouchUpInside];
    [explanationView addSubview:button];
    
    UITapGestureRecognizer *tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAlphaView)];
    [_alphaView addGestureRecognizer:tapToDismiss];
    
    [_alphaView addSubview:explanationView];

}

- (void)showPassRightView
{
    [self showAlphaView];
    
    UILabel *passRightLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 280)];
    passRightLabel.text = @"PASS\nRIGHT";
    passRightLabel.textColor = [UIColor whiteColor];
    [passRightLabel setFont:[UIFont boldSystemFontOfSize:90]];
    passRightLabel.numberOfLines = 3;
    
    UILabel *arrowLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 250, 300, 80)];
    arrowLabel.text = @">>>";
    arrowLabel.textColor = [UIColor whiteColor];
    [arrowLabel setFont:[UIFont systemFontOfSize:90]];
    
//    UILabel *clickToDismissLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 420, 300, 50)];
//    clickToDismissLabel.text = @"(touch anywhere to dismiss)";
//    clickToDismissLabel.textColor = [UIColor whiteColor];
//    [clickToDismissLabel setFont:[UIFont systemFontOfSize:15]];

    [_alphaView addSubview:passRightLabel];
    [_alphaView addSubview:arrowLabel];
//    [_alphaView addSubview:clickToDismissLabel];
    
    UITapGestureRecognizer *tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToNextPlayer)];
    [_alphaView addGestureRecognizer:tapToDismiss];

}

- (void)showBeginDayView
{
    [self showAlphaView];
    
    UILabel *beginDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 300, 280)];
    beginDayLabel.text = [NSString stringWithFormat:@"BEGIN\nDAY %d",_game.currentRound+1];
    beginDayLabel.textColor = [UIColor whiteColor];
    [beginDayLabel setFont:[UIFont boldSystemFontOfSize:90]];
    beginDayLabel.numberOfLines = 3;
    
    UILabel *arrowLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 250, 300, 80)];
    arrowLabel.text = @">>>";
    arrowLabel.textColor = [UIColor whiteColor];
    [arrowLabel setFont:[UIFont systemFontOfSize:90]];
    
    [_alphaView addSubview:beginDayLabel];
    [_alphaView addSubview:arrowLabel];
    
    UITapGestureRecognizer *tapToDismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginDay)];
    [_alphaView addGestureRecognizer:tapToDismiss];

}

//http://stackoverflow.com/questions/9711248/cut-transparent-hole-in-uiview
//-(void)addAlphaViewWithHole
//{
//    UIView *transparentView = [[UIView alloc] initWithFrame:CGRectMake(0,0,200,400)];
//    [transparentView setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.75]];
////                                            backgroundColor:[UIColor colorWithWhite:1 alpha:0.75]];
//    [self.view addSubview:backgroundView];
//}


#pragma mark - Alert View Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *textField;
    
    switch (alertView.tag) {
            
        case CONFIRMATION_ALERT_TAG:
            
            // Asks Player "Are you ready to see your role?"
            
            if (buttonIndex == 0) {
                [self showWaitAlertView]; // Not ready yet: Wait!
            }
            else if (buttonIndex == 1) {
                [self showRoleAlertView]; // Yes! Show role
            }
            
            break;
            
        case WAIT_ALERT_TAG:
            
            // Confirms player's name is correct
            
            if (buttonIndex == 0) {
                [self createNameEntryAlertViewWithIndex:_currentPlayerIndex]; // Not correct! Change
            }
            else if (buttonIndex == 1) {
                [self showConfirmationAlertView]; // Correct! Asks Player if they're ready again
            }
            
            break;
            
        case SHOW_ROLE_ALERT_TAG:
            
            // Shows Player their role
            
            if (buttonIndex == 0) {
                [self showPassRightView];
            }
            
            break;
            
        case KILL_PLAYER_ALERT_TAG:
            
            // Selects player to kill
            
            if (buttonIndex == 1) {
                // Kill player
                
                [_game killPlayerAtIndex:_carousel.currentItemIndex];
                [_carousel reloadData];
            }
            
            break;
            
        default:
            
            // Allows player to enter their name
            
            textField = [alertView textFieldAtIndex:0];
            
            if (buttonIndex == 1) {
                
                _currentPlayerName = textField.text;
                [_game.players[alertView.tag] setName:_currentPlayerName];
                
                [_carousel reloadData];
                
                [self showConfirmationAlertView];
            }
            
            else {
                [self dismissAlphaView]; // Cancel out
            }
       
            break;
    }
}

- (void)createNameEntryAlertViewWithIndex:(NSInteger)index
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Enter Your Name" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    alertView.tag = index;
    [[alertView textFieldAtIndex:0] setDelegate:self];
    [[alertView textFieldAtIndex:0] setText:[_game.players[index] name]];
//    [[alertView textFieldAtIndex:0] addTarget:self action:@selector(resignFirstResponder) forControlEvents:UIControlEventEditingDidEndOnExit];


    [alertView show];
}

- (void)showConfirmationAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Hello there, %@!", _currentPlayerName] message:@"Are you ready to see your role?" delegate:self cancelButtonTitle:@"Wait!" otherButtonTitles: @"Yes", nil];
    alertView.tag = CONFIRMATION_ALERT_TAG;
    [alertView show];
}

- (void)showWaitAlertView
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Is %@ your name?", _currentPlayerName] message:@"" delegate:self cancelButtonTitle:@"No" otherButtonTitles: @"Yes", nil];
    alertView.tag = WAIT_ALERT_TAG;
    [alertView show];

}

- (void)showRoleAlertView
{
    Player *currentPlayer = _game.players[_currentPlayerIndex];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Your Role:" message:[NSString stringWithFormat:@"%@", currentPlayer.role.name] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    alertView.tag = SHOW_ROLE_ALERT_TAG;
    [alertView show];
}

- (void)showKillAlertView
{
    Player *currentPlayer = _game.players[_carousel.currentItemIndex];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Kill %@?", currentPlayer.name] message:@"" delegate:self cancelButtonTitle:@"No" otherButtonTitles: @"Yes", nil];
    alertView.tag = KILL_PLAYER_ALERT_TAG;
    [alertView show];
}

#pragma mark - Text Field Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

#pragma mark - iCarousel Methods

-(void)setupCarousel
{
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.type = iCarouselTypeInvertedWheel;
    _carousel.viewpointOffset = CGSizeMake(50, 0);
    _carousel.vertical = YES;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    if (carousel.currentItemIndex == index)
    {
        if (_currentPlayerIndex == -1) {
            
            //voting: players choose who to kill
            [self showKillAlertView];
            
        }
        else if (_currentPlayerIndex == index) {
            
            if (_game.currentRound == 0) {
                
                // pre-game: players enter their names and view roles
                [self createNameEntryAlertViewWithIndex:index];

            }
            else if (_game.isNight) {
                
                // night: players perform specific role actions

                
            }
        }
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return _game.numPlayers;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150.0f, 30.0f)];
        view.contentMode = UIViewContentModeCenter;
//        view.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
        view.backgroundColor = [UIColor clearColor];
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.font = [label.font fontWithSize:20];
        
        Player *currentPlayer = _game.players[index];
        
        if (currentPlayer.isDead) {
            label.textColor = [UIColor colorWithWhite:0.400 alpha:1.000];
        }
        else {
            if (_isLightSkinMode) {
                label.textColor = [UIColor blackColor];
            }
            else {
                label.textColor = [UIColor whiteColor];
            }
        }
        
        
        label.tag = 1;
        label.adjustsFontSizeToFitWidth = YES;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [_game.players[index] name];
    
    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 6;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80.0f, 30.0f)];
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.font = [label.font fontWithSize:20];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = (index == 0)? @"[": @"]";
    
    return view;
}

-(CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return 150;
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 0.9;
        }
        case iCarouselOptionFadeMax:
        {
            if (carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        case iCarouselOptionVisibleItems:
        {
            return 9;
        }
        default:
        {
            return value;
        }
    }
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
