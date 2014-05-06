//
//  NightActionController.h
//  Werewolf
//
//  Created by Lauren Lee on 5/1/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameViewController.h"
#import "Game.h"

@protocol NightActionControllerProtocol <NSObject>

-(void)updateTapLabelWithString:(NSString*)string;
- (void)createAlertViewOfType:(NSInteger)type;
- (void)showNoKillCornerButton;

@end

@interface NightActionController : NSObject

@property (weak, nonatomic) Game *game;
@property (unsafe_unretained, nonatomic) id<NightActionControllerProtocol> delegate;

-(void)startNightActionWithPlayer:(Player *)player;
-(void)handleNightActionWithSelectedPlayer:(Player *)player;
- (NSString*)getNightActionConfirmMessageForPlayer:(Player*)player;

@end
