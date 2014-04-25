//
//  Game.m
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Game.h"

@implementation Game

// singleton of Game
+ (Game *)sharedGame
{
    static dispatch_once_t pred;
    static Game *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[Game alloc] init];
//        shared.teachers = [[RosterData teachersFromPlist] mutableCopy];
//        shared.students = [[RosterData studentsFromPlist] mutableCopy];
    });
    return shared;
}

- (id)initWithRoles:(NSMutableArray *)roles numPlayers:(NSNumber*)numPlayers
{
    if (self = [super init]) {
        _numPlayers = numPlayers;
        _roles = roles;
        _players = [[NSMutableArray alloc] init];
        _isDay = YES;
        _currentRound = 1;
    }
    
    return self;
}


@end
