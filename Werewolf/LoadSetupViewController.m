//
//  LoadSetupViewController.m
//  Werewolf
//
//  Created by Lauren Lee on 4/14/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "LoadSetupViewController.h"
#import "CreateGameViewController.h"
#import "GameData.h"


@interface LoadSetupViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *setupPicker;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@property (strong, nonatomic) GameSetup *gameSetup;

@end

@implementation LoadSetupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.setupPicker.delegate = self;
    self.setupPicker.dataSource = self;
    self.setupPicker.tag = kSetupPicker;
}

#pragma mark - Button Methods

-(void)setupSelected
{
    NSInteger selectedRow = [self.setupPicker selectedRowInComponent:0];
    
    self.gameSetup = [[GameData sharedData] gameSetups][selectedRow];
}

#pragma mark - Picker Methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[[GameData sharedData] gameSetups] count]; //temporary value
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    GameSetup *gameSetup = [[GameData sharedData] gameSetups][row];
    return gameSetup.name;
    
//    return @"Game Setup"; // temporary value
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self setupSelected];
    
    if ([segue.identifier isEqualToString:@"showCreateGameSegue"])
    {
        CreateGameViewController *destination = segue.destinationViewController;
        destination.testSetup = self.gameSetup;
    }
}


@end
