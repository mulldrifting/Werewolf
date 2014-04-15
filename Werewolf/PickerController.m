//
//  PickerController.m
//  Werewolf
//
//  Created by Lauren Lee on 4/14/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "PickerController.h"

@implementation PickerController


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case kSetupPicker:
            return 1;
        default:
            return [[Constants listOfDefinedRoles] count] + 1;
            
    }
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case kSetupPicker:
            return @"Game Setup";
        default:
            if (row == 0) {
                return @"Add a Role";
            } else {
                return [Constants listOfDefinedRoles][row-1];
            }
            
    }
    
}

@end
