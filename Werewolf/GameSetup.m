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
        _sortedRoles = [NSArray arrayWithArray:[Constants listOfDefinedRoles]];
        _roleNumbers = [NSMutableDictionary new];
        
        for (NSString *role in _sortedRoles) {
            [_roleNumbers setObject:[NSNumber numberWithInt:0] forKey:role];
        }
        
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
        _roleNumbers = roles;
        _settings = [NSMutableDictionary
                     dictionaryWithDictionary: @{@"PRIEST_CAN_TARGET_SELF": @YES}];
    }
    return self;
}

-(NSNumber*)numPlayers
{
    int total = 0;
    int numRole = 0;
    
    for (NSString *key in [self.roleNumbers allKeys]) {
        numRole = [[self.roleNumbers objectForKey:key] intValue];
        total = total + numRole;
//        NSLog(@"%@ %@",[NSNumber numberWithInt:numRole],[NSNumber numberWithInt:total]);
        
    }
    
    return [NSNumber numberWithInt:total];
}

- (void)sortByKey:(NSString *)sortKey
{
//    //Sort teacher and student arrays by first name
//    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:YES];
//    NSArray *sortDescriptors = @[nameDescriptor];
//    NSArray *sortedRolesArray = [_roles sortedArrayUsingDescriptors:sortDescriptors];
//    
//    //Set teacher and student arrays to sorted arrays
//    _roles = [NSMutableArray arrayWithArray:sortedRolesArray];
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.roleNumbers = [aDecoder decodeObjectForKey:@"roles"];
        self.settings = [aDecoder decodeObjectForKey:@"settings"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.roleNumbers forKey:@"roles"];
    [aCoder encodeObject:self.settings forKey:@"settings"];
}

@end
