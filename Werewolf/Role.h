//
//  Role.h
//  Werewolf
//
//  Created by Lauren Lee on 4/26/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Role : NSObject

@property (copy, nonatomic) NSString *name, *faction, *seerSees;
@property (nonatomic) NSInteger roleID;

@end
