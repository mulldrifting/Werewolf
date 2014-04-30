//
//  Player.h
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Role.h"

@interface Player : NSObject

@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) Role *role;
@property (nonatomic) int index;
@property (nonatomic) BOOL isDead;

-(id)initWithIndex:(int)index;

@end
