//
//  Player.h
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

@class Role;

@interface Player : NSObject

@property (copy, nonatomic) NSString *name, *target;
@property (strong, nonatomic) NSMutableArray *nightGuesses, *seerPeeks, *priestSaves;
@property (weak, nonatomic) Game *game;
@property (strong, nonatomic) Role *role;
@property (nonatomic) int index;
@property (nonatomic) BOOL isDead, isWolfTarget, isPriestTarget, isVigilanteTarget;


-(id)initWithIndex:(int)index withGame:(Game*)game;

@end
