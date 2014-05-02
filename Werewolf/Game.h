//
//  Game.h
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameSetup.h"
#import "Player.h"
#import "Role.h"
#import "Werewolf.h"
#import "Villager.h"
#import "Priest.h"
#import "Seer.h"
#import "Vigilante.h"
#import "Hunter.h"
#import "Minion.h"
#import "Assassin.h"

@interface Game : NSObject

@property (strong, nonatomic) GameSetup *gameSetup;
@property (strong, nonatomic) NSMutableArray *players, *roles;
@property (nonatomic) int numPlayers, currentPlayerIndex, currentRound;
@property (nonatomic) BOOL isNight, isOver, didWrap;

- (id)initWithGameSetup:(GameSetup*)gameSetup;
- (int)nextAlivePlayer:(int)index;
- (Player*)currentPlayer;
- (Player*)previousPlayer;
- (Player *)randomPlayer;
- (Player *)randomNonWerewolf;
- (Player*)randomVillager;
- (void)killPlayerAtIndex:(int)index;

@end
