//
//  Game.h
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameSetup.h"

@class Player;


@interface Game : NSObject

@property (strong, nonatomic) GameSetup *gameSetup;
@property (strong, nonatomic) NSMutableArray *players, *roles, *wolves, *gameHistory;
@property (nonatomic) int numPlayers, currentPlayerIndex, currentRound;
@property (nonatomic) BOOL isNight, isOver, didWrap;

- (id)initWithGameSetup:(GameSetup*)gameSetup;

- (BOOL)isDuplicateName:(NSString*)name;
- (int)nextAlivePlayer:(int)index;
- (Player*)currentPlayer;
- (Player*)previousPlayer;
- (Player*)randomPlayer;
- (Player*)randomNonWerewolf;
- (Player*)randomVillager;

- (void)killPlayerAtIndex:(int)index;
- (void)checkGameState;
- (NSString *)checkNightResult;
- (NSString *)listOfWolves;
- (void)resetPlayersNightStatus;

@end
