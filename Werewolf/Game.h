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
@property (nonatomic) NSNumber* numPlayers;
@property (nonatomic) BOOL isDay;
@property (nonatomic) NSInteger currentRound;

+ (Game *)sharedGame;

- (id)initWithRoles:(NSMutableArray *)roles numPlayers:(NSNumber*)numPlayers;

- (BOOL)isGameValid;
- (void)assignRoles;

@end
