//
//  NightActionController.h
//  Werewolf
//
//  Created by Lauren Lee on 5/1/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

@protocol NightActionControllerProtocol <NSObject>

-(void)updateTapLabelWithString:(NSString*)string;

@end

@interface NightActionController : NSObject

@property (weak, nonatomic) Game *game;
@property (unsafe_unretained, nonatomic) id<NightActionControllerProtocol> delegate;

-(NSString *)getRoleInfoForPlayer:(Player *)player;
-(void)startNightAction;
-(void)handleNightActionWithSelectedPlayer:(Player *)player;

@end
