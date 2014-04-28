//
//  Game.m
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Game.h"
#import "Player.h"
#import "ModPlayer.h"
#import "Role.h"
#import "Werewolf.h"
#import "Villager.h"
#import "Priest.h"
#import "Seer.h"
#import "Vigilante.h"
#import "Hunter.h"
#import "Minion.h"
#import "Assassin.h"

@implementation Game

- (id)initWithGameSetup:(GameSetup*)gameSetup
{
    if (self = [super init])
    {
        _gameSetup = gameSetup;
        _numPlayers = gameSetup.numPlayers;
        _roles = [NSMutableArray new];
        _players = [NSMutableArray new];
        _isDay = YES;
        _currentRound = 0;
    }
    
    return self;
}

#pragma mark - Setup Game Methods

- (void)prepareGame
{
    [self preparePlayers];
    [self prepareRoles];
    [self shuffleRoles];
    [self assignRoles];
}

- (void)preparePlayers
{
    for (int i = 0; i < _numPlayers; i++) {
        if (i == 0) {
            ModPlayer *newPlayer = [ModPlayer new];
            [newPlayer setName:@"Player"];
            [_players addObject:newPlayer];
        }
        else {
            Player *newPlayer = [Player new];
            newPlayer.name = [NSString stringWithFormat:@"Player %d", i];
            [_players addObject:newPlayer];
        }
    }
}

- (void)prepareRoles
{
    for (NSString *key in _gameSetup.roleNumbers) {
        for (int i = 0; i < [_gameSetup.roleNumbers[key] intValue]; i++) {
            [_roles addObject:[self roleForIndex:i]];
        }
    }
}

-(id)roleForIndex:(int)roleType
{
    switch (roleType) {
        case kVillager:
            return [Villager new];
        case kWerewolf:
            return [Werewolf new];
        case kSeer:
            return [Seer new];
        case kPriest:
            return [Priest new];
        case kVigilante:
            return [Vigilante new];
        case kHunter:
            return [Hunter new];
        case kMinion:
            return [Minion new];
        case kAssassin:
            return [Assassin new];
        default:
            NSLog(@"Unknown role type");
            return [Role new];
    }
}

- (void)assignRoles
{
    int index = 0;
    for (Player *player in _players) {
        player.role = _roles[index];
        index++;
    }
}

- (void)shuffleRoles
{
    NSUInteger count = [_roles count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = arc4random_uniform(nElements) + i;
        [_roles exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end
