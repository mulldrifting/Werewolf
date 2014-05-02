//
//  CarouselController.h
//  Werewolf
//
//  Created by Lauren Lee on 5/1/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameViewController.h"
#import "iCarousel.h"
#import "Game.h"



@protocol CarouselControllerProtocol <NSObject>

- (void)createAlertViewOfType:(NSInteger)type;

@end

@interface CarouselController : NSObject <iCarouselDataSource, iCarouselDelegate>

@property (unsafe_unretained, nonatomic) id<CarouselControllerProtocol> delegate;

@property (strong, nonatomic) Game *game;

@end
