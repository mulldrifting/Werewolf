//
//  GameSetup.h
//  Werewolf
//
//  Created by Lauren Lee on 4/13/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameSetup : NSObject <NSCoding>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableDictionary *roleNumbers;
@property (strong, nonatomic) NSArray *sortedRoles;
@property (strong, nonatomic) NSMutableDictionary *settings;

-(id)initWithName:(NSString*)name roles:(NSMutableDictionary*)roles;
-(NSNumber*)numPlayers;

@end
