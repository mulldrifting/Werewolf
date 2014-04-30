//
//  GameData.m
//  Werewolf
//
//  Created by Lauren Lee on 4/16/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "GameData.h"

@implementation GameData

// singleton of GameData
+(GameData *)sharedData
{
    static dispatch_once_t pred;
    static GameData *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[GameData alloc] init];
        shared.gameSetups = [[GameData gameSetupsFromPlist] mutableCopy];
        [shared sortGameSetups];
    });
    
    return shared;
}

+(NSMutableArray*)gameSetupsFromPlist
{
    NSMutableArray *gameSetups = [[NSMutableArray alloc] init];
    
    // path from application documents
    NSString *plistPath = [[GameData applicationDocumentsDirectory] stringByAppendingPathComponent:@"gameSetupList.plist"];
    
    // path from main bundle
    NSString *pathBundle = [[NSBundle mainBundle] pathForResource:@"gameSetupList" ofType:@"plist"];
    
    // add game setups from main bundle (default setups)
    if ([self checkForPlistFileAtPath:pathBundle]) {

        NSArray *plistGameSetups = [[NSArray alloc] initWithContentsOfFile:pathBundle];
        
        [plistGameSetups enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            GameSetup *newSetup = [[GameSetup alloc] initWithName:obj[@"name"] roleNumbers:[obj[@"roleNumbers"] mutableCopy] settings:[obj[@"settings"] mutableCopy]];
            [gameSetups addObject:newSetup];
        }];

    }
    else {
        
        NSLog(@"Uh oh! No plist in main bundle!");
        //do something about that
    }

    // add game setups from application docs directory
    if ([self checkForPlistFileAtPath:plistPath])
    {
        NSLog(@"unarchive game data from app doc");
        [gameSetups addObjectsFromArray:[NSKeyedUnarchiver unarchiveObjectWithFile:plistPath]];
    }
    
    return gameSetups;
}

+(NSString *)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+(BOOL)checkForPlistFileAtPath:(NSString*)path
{
    NSFileManager *myManager = [NSFileManager defaultManager];
//    NSString *pathForPlistInDocs = [[GameData applicationDocumentsDirectory] stringByAppendingPathComponent:fileName];
    
    return [myManager fileExistsAtPath:path];
}

-(void)save {
    [NSKeyedArchiver archiveRootObject:self.gameSetups toFile:[[GameData applicationDocumentsDirectory] stringByAppendingPathComponent:@"gameSetupList.plist"]];
}


-(void)addNewGameSetup:(GameSetup *)newGameSetup
{
    [_gameSetups insertObject:newGameSetup atIndex:0];
    [[GameData sharedData] save];
}

-(void)removeGameDataAtIndex:(NSInteger)row
{
    [_gameSetups removeObjectAtIndex:row];
    [[GameData sharedData] save];
}

-(void)sortGameSetups
{
    //Sort game setups by name
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = @[nameDescriptor];
    NSArray *sortedGameSetups = [_gameSetups sortedArrayUsingDescriptors:sortDescriptors];
    _gameSetups = [NSMutableArray arrayWithArray:sortedGameSetups];
}

@end

