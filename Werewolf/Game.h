//
//  Game.h
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameSetup.h"

@interface Game : NSObject

@property (strong, nonatomic) GameSetup *gameSetup;
@property (strong, nonatomic) NSMutableArray *players, *roles;
@property (nonatomic) int numPlayers;
@property (nonatomic) BOOL isDay;
@property (nonatomic) NSInteger currentRound;

- (id)initWithGameSetup:(GameSetup*)gameSetup;
- (void)prepareGame;

@end
