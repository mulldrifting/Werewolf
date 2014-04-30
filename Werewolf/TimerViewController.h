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

@interface TimerViewController : UIViewController

@property (weak, nonatomic) IBOutlet TTCounterLabel *counterLabel;

@property (weak, nonatomic) Game *game;

@end
