//
//  Player.m
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Player.h"

@implementation Player

- (id)initWithPosition:(NSInteger)position
{
    if (self = [super init])
    {
        _name = @"";
        _position = position;
        _role = @"";
    }
    
    return self;
}

@end
