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

+(GameData*)sharedData;
+(NSMutableArray*)gameSetupsFromPlist;

-(void)addNewGameSetup:(GameSetup *)newGameSetup;
-(void)removeGameDataAtIndex:(NSInteger)row;

@end
