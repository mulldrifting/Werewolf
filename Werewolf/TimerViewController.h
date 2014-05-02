//
//  TimerViewController.h
//  Werewolf
//
//  Created by Lauren Lee on 4/28/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTCounterLabel.h"
#import "Game.h"

@protocol TimerViewControllerProtocol <NSObject>

- (void)hideTimerViewController;
- (void)beginKillSelection;

@end

@interface TimerViewController : UIViewController

@property (weak, nonatomic) IBOutlet TTCounterLabel *counterLabel;

@property (unsafe_unretained, nonatomic) id<TimerViewControllerProtocol> delegate;
@property (weak, nonatomic) Game *game;

@end
