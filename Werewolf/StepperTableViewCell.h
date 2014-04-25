//
//  StepperTableViewCell.h
//  Werewolf
//
//  Created by Lauren Lee on 4/14/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateGameViewController.h"

@protocol StepperTableViewCellProtocol <NSObject>

@optional

- (void)setValue:(int)value forRole:(NSString*)role;

@end

@interface StepperTableViewCell : UITableViewCell 

@property (unsafe_unretained, nonatomic) id<StepperTableViewCellProtocol> delegate;

@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;


@end
