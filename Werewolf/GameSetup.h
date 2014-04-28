//
//  GameSetup.h
//  Werewolf
//
//  Created by Lauren Lee on 4/13/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameSetup : NSObject <NSCoding, NSCopying>

@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableDictionary *roleNumbers, *settings;
@property (strong, nonatomic) NSMutableArray *roles;

-(id)initWithName:(NSString*)name roleNumbers:(NSMutableDictionary*)roleNumbers settings:(NSMutableDictionary*)settings;
-(int)numPlayers;

@end
