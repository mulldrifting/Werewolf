//
//  Player.h
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) NSInteger position;
@property (strong, nonatomic) NSString *role;

- (id)initWithPosition:(NSInteger)position;

@end
