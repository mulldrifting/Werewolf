//
//  Role.h
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Role : NSObject

@property (copy, nonatomic) NSString *name, *faction, *target;
@property (nonatomic) NSInteger roleID;
@property (strong, nonatomic) NSMutableArray *wolfGuesses;

@end
