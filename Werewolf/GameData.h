//
//  GameData.h
//  Werewolf
//
//  Created by Lauren Lee on 5/7/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GameSetup;

@interface GameData : NSManagedObject

@property (nonatomic, retain) NSSet *gameSetups;
@end

@interface GameData (CoreDataGeneratedAccessors)

- (void)addInitialGameSetups;
- (void)addGameSetupsObject:(GameSetup *)value;
- (void)removeGameSetupsObject:(GameSetup *)value;
- (void)addGameSetups:(NSSet *)values;
- (void)removeGameSetups:(NSSet *)values;

@end
