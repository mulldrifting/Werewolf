//
//  secretMessageController.h
//  Werewolf
//
//  Created by Lauren Lee on 5/1/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Game.h"

@interface secretMessageController : NSObject
-(NSString *)createSecretMessageForPlayer:(Player *)player;
@property (nonatomic,weak) Game *game;


@end
