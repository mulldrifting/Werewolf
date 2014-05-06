//
//  Role.h
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"
#import "Player.h"

@interface Role : NSObject

@property (weak, nonatomic) Game *game;
@property (weak, nonatomic) Player *player;
@property (copy, nonatomic) NSString *name, *faction, *seerSeesAs;
@property (nonatomic) NSInteger roleID;

-(id)initWithGame:(Game*)game;

@end
