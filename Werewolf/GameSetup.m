//
//  GameSetup.m
//  Werewolf
//
//  Created by Lauren Lee on 4/13/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "GameSetup.h"

@implementation GameSetup

-(id)init
{
    if (self = [super init])
    {
        _name = @"9P Classic";
        _roles = [NSMutableDictionary
                  dictionaryWithDictionary: @{
                   @"Villager": [NSNumber numberWithInt:5],
                   @"Werewolf": [NSNumber numberWithInt:2],
                   @"Seer": [NSNumber numberWithInt:1],
                   @"Priest": [NSNumber numberWithInt:1],
                   @"Vigilante": [NSNumber numberWithInt:1]}];
        _numPlayers = [self calculateNumPlayers];
        _settings = [NSMutableDictionary
                     dictionaryWithDictionary: @{@"PRIEST_CAN_TARGET_SELF": @YES}];
    }
    return self;
}

-(id)initWithName:(NSString *)name roles:(NSMutableDictionary *)roles
{
    if (self = [super init])
    {
        _name = name;
        _roles = roles;
        _numPlayers = [self calculateNumPlayers];
        _settings = [NSMutableDictionary
                     dictionaryWithDictionary: @{@"PRIEST_CAN_TARGET_SELF": @YES}];
    }
    return self;
}

-(NSNumber*)calculateNumPlayers
{
    int total = 0;
    int numRole = 0;
    
    for (NSString *key in [self.roles allKeys]) {
        numRole = [[self.roles objectForKey:key] intValue];
        total = total + numRole;
//        NSLog(@"%@ %@",[NSNumber numberWithInt:numRole],[NSNumber numberWithInt:total]);
        
    }
    
    self.numPlayers = [NSNumber numberWithInt:total];
    return self.numPlayers;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.roles = [aDecoder decodeObjectForKey:@"roles"];
        self.numPlayers = [aDecoder decodeObjectForKey:@"numPlayers"];
        self.settings = [aDecoder decodeObjectForKey:@"settings"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.roles forKey:@"roles"];
    [aCoder encodeObject:self.numPlayers forKey:@"numPlayers"];
    [aCoder encodeObject:self.settings forKey:@"settings"];
}

@end
