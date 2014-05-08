//
//  GameData.h
//  Werewolf
//
//  Created by Lauren Lee on 4/16/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameSetup.h"

@interface GameData : NSObject

@property (strong, nonatomic) NSMutableArray *gameSetups;
@property (strong, nonatomic) NSMutableArray *defaultGameSetups;

+(GameData*)sharedData;
+(NSMutableArray*)gameSetupsFromPlist;
+(NSMutableArray*)defaultGameSetupsFromPlist;

-(void)addNewGameSetup:(GameSetup *)newGameSetup;
-(void)removeGameDataAtIndex:(NSInteger)row;

@end
