//
//  GameViewController.h
//  Werewolf
//
//  Created by Lauren Lee on 4/25/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "Game.h"

@interface GameViewController : UIViewController

@property (nonatomic, strong) IBOutlet iCarousel *carousel;

@property (strong, nonatomic) Game *game;

@end
