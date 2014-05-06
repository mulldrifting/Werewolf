//
//  GameViewController.h
//  Werewolf
//
//  Created by Lauren Lee on 4/25/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimerViewController.h"
#import "iCarousel.h"
#import "Game.h"

typedef NS_ENUM(NSInteger, alertViewType) {
    kNameEntry,
    kReadyToSeeRole,
    kKillPlayer,
    kShowRoleAlert,
    kNoKillConfirmation,
    kAreYouX,
    kIsDead,
    kNightAction,
    kSeerPeek,
    kNightActionConfirm
};

typedef NS_ENUM(NSInteger, popupViewType) {
    kPassRight,
    kBeginDay,
    kPassToPlayer,
    kShowRoleView,
    kShowNightInfoView,
    kWolvesDecideKill
};

typedef NS_ENUM(NSInteger, cornerButtonType)
{
    kReadyToStart,
    kNoKillToday,
    kNoKillVigilante,
    kNoKillWerewolf
};

@interface GameViewController : UIViewController

@property (nonatomic, strong) IBOutlet iCarousel *carousel;

@property (strong, nonatomic) TimerViewController *timerViewController;
@property (strong, nonatomic) Game *game;

@end
