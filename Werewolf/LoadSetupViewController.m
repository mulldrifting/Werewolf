//
//  LoadSetupViewController.m
//  Werewolf
//
//  Created by Lauren Lee on 4/14/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "LoadSetupViewController.h"
#import "PickerController.h"


@interface LoadSetupViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *setupPicker;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@property (strong, nonatomic) PickerController *pickerController;

@end

@implementation LoadSetupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pickerController = [PickerController new];
    self.setupPicker.delegate = self.pickerController;
    self.setupPicker.dataSource = self.pickerController;
    self.setupPicker.tag = kSetupPicker;

    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
