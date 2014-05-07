//
//  GameSetup.h
//  Werewolf
//
//  Created by Lauren Lee on 5/7/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GameData;

@interface GameSetup : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * numWerewolf;
@property (nonatomic, retain) NSNumber * numVillager;
@property (nonatomic, retain) NSNumber * numSeer;
@property (nonatomic, retain) NSNumber * numPriest;
@property (nonatomic, retain) NSNumber * numVigilante;
@property (nonatomic, retain) NSNumber * numAssassin;
@property (nonatomic, retain) NSNumber * numMinion;
@property (nonatomic, retain) NSNumber * numHunter;
@property (nonatomic, retain) NSNumber * kDayKillAnnounced;
@property (nonatomic, retain) NSNumber * kNightKillAnnounced;
@property (nonatomic, retain) NSNumber * kWolvesSeeRoleOfKill;
@property (nonatomic, retain) GameData *gameData;

@end
