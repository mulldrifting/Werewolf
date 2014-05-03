//
//  Role.m
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "Role.h"


@implementation Role

- (id)init
{
    if (self = [super init]) {
        _name = @"";
        _faction = @"";
        _roleID = -1;
    }
    return  self;
}

@end
