//
//  NightActionController.h
//  Werewolf
//
//  Created by Lauren Lee on 5/1/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

@interface NightActionController : NSObject

@property (weak, nonatomic) Game *game;

-(NSString *)getRoleInfoForPlayer:(Player *)player;

@end
