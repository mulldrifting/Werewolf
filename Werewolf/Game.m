//
//  Game.m
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Game.h"
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

@implementation Game

- (id)initWithGameSetup:(GameSetup*)gameSetup
{
    if (self = [super init])
    {
        _gameSetup = gameSetup;
        _numPlayers = gameSetup.numPlayers;
        
        _roles = [NSMutableArray new];
        _players = [NSMutableArray new];
        _wolves = [NSMutableArray new];
        _gameHistory = [NSMutableArray new];

        _isNight = NO;
        _isOver = NO;
        _didWrap = NO;
        _currentRound = 0;
        _currentPlayerIndex = 0;
        
        [self prepareGame];
    }
    
    return self;
}

-(BOOL)isDuplicateName:(NSString *)name
{
    for (Player *player in _players) {
        if ([player.name isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Game Logic Methods

- (NSString *)checkNightResult
{
    NSString *dayMessage = @"";
    BOOL nobodyDied = YES;
    
    for (Player *player in _players) {
        if (player.isWolfTarget || player.isVigilanteTarget) {
            
            if (!player.isPriestTarget) {
                [self killPlayerAtIndex:player.index];
                dayMessage = [dayMessage stringByAppendingString:[NSString stringWithFormat:@"%@ was killed in the night!\n\n", player.name]];
                nobodyDied = NO;
            }
        }
    }
    
    [self checkGameState];
    
    if (nobodyDied) {
        dayMessage = [dayMessage stringByAppendingString:@"Nobody died last night!"];
    }
    
    return dayMessage;
}

- (void)resetPlayersNightStatus
{
    for (Player *player in _players) {
        player.isPriestTarget = NO;
        player.isWolfTarget = NO;
        player.isVigilanteTarget = NO;
    }
}

- (void)checkGameState
{
    int numWolf = 0;
    int numVillage = 0;
    
    for (Player *wolf in _wolves) {
        if (!wolf.isDead) {
            numWolf++;
        }
    }
    
    for (Player *player in _players) {
        if (!player.isDead) {
            if ([player.role.seerSeesAs isEqualToString:@"Non-Werewolf"]) {
                numVillage++;
            }
        }
    }
    
    if (numWolf >= numVillage) {
        _isOver = YES;
        NSLog(@"Wolves equal or outnumber Villagers: GAME OVER");
    }
    else if (numWolf == 0) {
        _isOver = YES;
        NSLog(@"Wolves are dead: GAME OVER");
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
        _didWrap = YES;
        nextPlayerIndex = 0;
    }
    return nextPlayerIndex;
}

- (Player *)nextPlayerAtIndex:(int)index
{
    int nextPlayerIndex = index + 1;
    if (nextPlayerIndex == _numPlayers) {
        _didWrap = YES;
        nextPlayerIndex = 0;
    }
    
    return _players[nextPlayerIndex];
}

- (int)nextAlivePlayer:(int)index
{
    int i = index;
    
    Player *currentPlayer = [self nextPlayerAtIndex:i];
    
    if (_didWrap) {
        return 0;
    }

    while (currentPlayer.isDead) {
        i++;
        currentPlayer = [self nextPlayerAtIndex:i];
        if (_didWrap) {
            return 0;
        }
    }
    
    return currentPlayer.index;
    
}

-(Player *)currentPlayer
{
    return _players[_currentPlayerIndex];
}

-(Player *)previousPlayer
{
    return _players[[self prevPlayerIndex:_currentPlayerIndex]];
}

-(Player *)randomPlayer
{
    return _players[arc4random_uniform((u_int32_t)[_players count])];
}

// Seer
-(Player *)randomNonWerewolf
{
    Player *randomPlayer = [self randomPlayer];
    while ([randomPlayer.role isKindOfClass:[Werewolf class]] || [randomPlayer isEqual:[self currentPlayer]]) {
        randomPlayer = [self randomPlayer];
    }
    return randomPlayer;
}

// Assassin
- (Player*)randomVillager
{
    Player *randomPlayer = [self randomPlayer];
    while (![randomPlayer.role isKindOfClass:[Villager class]]) {
        randomPlayer = [self randomPlayer];
    }
    return randomPlayer;
}

-(void)killPlayerAtIndex:(int)index
{
    Player *player = _players[index];
    
    if (player.isDead) {
        NSLog(@"Tried to kill dead player");
    }
    
    player.isDead = YES;
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
            Player *newPlayer = [[Player alloc] initWithIndex:i withGame:self];
            newPlayer.name = @"YOU";
            [_players addObject:newPlayer];
        }
        else {
            Player *newPlayer = [[Player alloc] initWithIndex:i withGame:self];
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
            return [[Villager alloc] initWithGame:self];
        case kWerewolf:
            return [[Werewolf alloc] initWithGame:self];
        case kSeer:
            return [[Seer alloc] initWithGame:self];
        case kPriest:
            return [[Priest alloc] initWithGame:self];
        case kVigilante:
            return [[Vigilante alloc] initWithGame:self];
        case kHunter:
            return [[Hunter alloc] initWithGame:self];
        case kMinion:
            return [[Minion alloc] initWithGame:self];
        case kAssassin:
            return [[Assassin alloc] initWithGame:self];
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
        player.role.player = player;
        
        if ([player.role isKindOfClass:[Werewolf class]]) {
            [_wolves addObject:player];
        }
        
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
        NSInteger n = arc4random_uniform((u_int32_t)nElements) + i;
        [_roles exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

- (NSString *)listOfWolves
{
    BOOL isFirstObject = YES;
    
    NSString *list = @"The Wolves: ";
    for (Player *wolf in _wolves) {
        if (isFirstObject) {
            list = [list stringByAppendingString:[NSString stringWithFormat:@"%@", wolf.name]];
            isFirstObject = NO;
        }
        else {
            list = [list stringByAppendingString:[NSString stringWithFormat:@", %@", wolf.name]];
        }
    }
    return list;
}

@end
