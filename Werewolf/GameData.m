//
//  GameData.m
//  Werewolf
//
//  Created by Lauren Lee on 5/7/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "GameData.h"
#import "GameSetup.h"


@implementation GameData

@dynamic gameSetups;

- (void)addInitialGameSetups
{
    GameSetup *assassinSetup = [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup" inManagedObjectContext:self.managedObjectContext];
    assassinSetup.name = @"5P Assassin";
    assassinSetup.numWerewolf = @1;
    assassinSetup.numVillager = @3;
    assassinSetup.numAssassin = @1;
    assassinSetup.gameData = self;
    
    GameSetup *fivesSetup = [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup" inManagedObjectContext:self.managedObjectContext];
    fivesSetup.name = @"5P Special";
    fivesSetup.numWerewolf = @1;
    fivesSetup.numVillager = @1;
    fivesSetup.numHunter = @1;
    fivesSetup.numSeer = @1;
    fivesSetup.numMinion = @1;
    fivesSetup.gameData = self;

    GameSetup *sevensSetup = [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup" inManagedObjectContext:self.managedObjectContext];
    sevensSetup.name = @"7P Classic";
    sevensSetup.numWerewolf = @2;
    sevensSetup.numVillager = @4;
    sevensSetup.numSeer = @1;
    sevensSetup.kWolvesSeeRoleOfKill = @NO;
    sevensSetup.gameData = self;

    GameSetup *ninesSetup = [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup" inManagedObjectContext:self.managedObjectContext];
    ninesSetup.name = @"9P Classic";
    ninesSetup.numWerewolf = @2;
    ninesSetup.numVillager = @6;
    ninesSetup.numSeer = @1;
    ninesSetup.gameData = self;
}

@end
