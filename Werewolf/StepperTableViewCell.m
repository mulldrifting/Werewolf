//
//  StepperTableViewCell.m
//  Werewolf
//
//  Created by Lauren Lee on 4/14/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "StepperTableViewCell.h"

@implementation StepperTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:NO];

    // Configure the view for the selected state
}

- (IBAction)valueChanged:(UIStepper *)sender
{
    int value = (int)[sender value];
    
    [self.delegate setValue:value forRole:self.roleLabel.text];
    
    [self.numberLabel setText:[NSString stringWithFormat:@"%d", value]];
    
}

@end
