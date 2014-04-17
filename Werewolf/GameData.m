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
    });
    
    return shared;
}

+(NSMutableArray*)gameSetupsFromPlist
{
    NSMutableArray *gameSetups = [[NSMutableArray alloc] init];
    
    // path from application documents
    NSString *plistPath = [[GameData applicationDocumentsDirectory] stringByAppendingPathComponent:@"gameSetupList.plist"];

    if ([GameData checkForPlistFileInDocs:@"gameSetupList.plist"])
    {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];
    }
    
    return gameSetups;
}

+(NSString *)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+(BOOL)checkForPlistFileInDocs:(NSString*)fileName
{
    NSFileManager *myManager = [NSFileManager defaultManager];
    NSString *pathForPlistInDocs = [[GameData applicationDocumentsDirectory] stringByAppendingPathComponent:fileName];
    
    return [myManager fileExistsAtPath:pathForPlistInDocs];
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

@end

