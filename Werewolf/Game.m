//
//  Game.m
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Game.h"
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
        _isNight = NO;
        _isOver = NO;
        _currentRound = 0;
    }
    
    return self;
}

#pragma mark - Game Logic Methods

- (void)checkGameState
{
    int numAlive = 0;
    int numWolf = 0;
    int numVillage = 0;
    
    for (Player *player in _players) {
        if (!player.isDead) {
            
            numAlive++;
            
            if ([player.role.faction isEqualToString:@"Werewolf"]) {
                numWolf++;
            }
            else if ([player.role.faction isEqualToString:@"Villager"]) {
                numVillage++;
            }
        }
    }
    
    if (numWolf >= numVillage) {
        _isOver = YES;
    }
    else {
        _isOver = NO;
    }
}

- (void)endGame
{
    
}

#pragma mark - Player Action Methods

//- (NSString*)getNightInfoForPlayerAtIndex:(int)index
//{
//    NSString *message;
//    Player *currentPlayer = _players[index];
//    
//    switch (currentPlayer.role.roleID) {
//        case kVillager:
//            return @"";
//            break;
//        case kWerewolf:
//            
//            break;
//        case kSeer:
//            
//            if (_gameSetup.settings[@"SEER_PEEKS_NIGHT_ZERO"]) {
//                
//            }
//            
//            break;
//        case kPriest:
//            return @"";
//            break;
//        case kVigilante:
//            return @"";
//            break;
//        case kHunter:
//            return @"";
//            break;
//        case kMinion:
//            
//            break;
//        case kAssassin:
//            
//            break;
//            
//        default:
//            break;
//    }
//}

#pragma mark - Player Control Methods

- (int)prevPlayerIndex:(int)index
{
    int prevPlayerIndex = index - 1;
    if (prevPlayerIndex < 0) {
        prevPlayerIndex = _numPlayers-1;
    }
    return prevPlayerIndex;
}

- (int)nextPlayerIndex:(int)index
{
    int nextPlayerIndex = index + 1;
    if (nextPlayerIndex == _numPlayers) {
        nextPlayerIndex = 0;
    }
    return nextPlayerIndex;
}

- (Player*)nextAlivePlayer:(int)index
{
    Player *currentPlayer = _players[[self nextPlayerIndex:index]];
    NSLog(@"%@: %hhd", currentPlayer.name, currentPlayer.isDead);

    while (currentPlayer.isDead) {
        currentPlayer = _players[[self nextPlayerIndex:index]];
        NSLog(@"%@: %hhd", currentPlayer.name, currentPlayer.isDead);
    }
    
    return currentPlayer;
}

-(void)killPlayerAtIndex:(int)index
{
    Player *player = _players[index];
    player.isDead = YES;
    [self checkGameState];
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
            ModPlayer *newPlayer = [[ModPlayer alloc] initWithIndex:i];
            [newPlayer setName:@"(Mod) Player"];
            [_players addObject:newPlayer];
        }
        else {
            Player *newPlayer = [[Player alloc] initWithIndex:i];
            [_players addObject:newPlayer];
        }
    }
}

- (void)prepareRoles
{
    int keyIndex = 0;
    
    for (NSString *roleName in [Constants listOfDefinedRoles]) {
        
        int roleNum = [_gameSetup.roleNumbers[roleName] intValue];
        
        for (int i = 0; i < roleNum; i++) {
            [_roles addObject:[self roleForIndex:keyIndex]];
        }
        
        keyIndex++;
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
        NSLog(@"%@: %@",player.name,[_roles[index] name]);
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
