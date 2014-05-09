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
        _name = @"Game Template";
        [self createRoleNumbers];
        _settings = [NSMutableDictionary
                     dictionaryWithDictionary: [Constants defaultSettings]];
    }
    return self;
}

-(id)initWithName:(NSString *)name roleNumbers:(NSMutableDictionary *)roleNumbers settings:(NSMutableDictionary*)settings
{
    if (self = [super init])
    {
        _name = name;
        _roleNumbers = roleNumbers;
        _settings = settings;
    }
    return self;
}

-(void)createRoleNumbers
{
    _roleNumbers = [NSMutableDictionary new];
    
    for (NSString *role in [Constants listOfDefinedRoles]) {
        [_roleNumbers setObject:[NSNumber numberWithInt:0] forKey:role];
    }
}



-(int)numPlayers
{
    int total = 0;
    int numRole = 0;
    
    for (NSString *key in [self.roleNumbers allKeys]) {
        numRole = [[self.roleNumbers objectForKey:key] intValue];
        total = total + numRole;
    }
    
    return total;
}

#pragma mark - NSCoding Methods

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.roleNumbers = [aDecoder decodeObjectForKey:@"roleNumbers"];
        self.settings = [aDecoder decodeObjectForKey:@"settings"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.roleNumbers forKey:@"roleNumbers"];
    [aCoder encodeObject:self.settings forKey:@"settings"];
}

#pragma mark - NSCopying Methods

-(id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] init];
    
    if (copy) {
        [copy setName:self.name];
        [copy setRoleNumbers:self.roleNumbers];
        [copy setSettings:self.settings];
    }
    
    return copy;
}


@end

