//
//  NSDictionary+Common.m
//  Werewolf
//
//  Created by Lauren Lee on 4/14/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "NSDictionary+Common.h"

@implementation NSDictionary (Common)

-(NSString *)keyAtIndex:(NSUInteger)index;
{
    NSArray *keys = [self allKeys];
    id aKey = [keys objectAtIndex:index];
    return aKey;
}

@end
