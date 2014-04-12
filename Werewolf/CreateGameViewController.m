//
//  CreateGameViewController.m
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "CreateGameViewController.h"
#import "Game.h"

typedef NS_ENUM(NSInteger, pickerType) {
    kNumPlayerPicker,
    kRolePicker
};

typedef NS_ENUM(NSInteger, componentNum) {
    kFirstComponent,
    kSecondComponent,
    numberOfComponents
};

@interface CreateGameViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *numPlayersTextField;

@property (weak, nonatomic) IBOutlet UIPickerView *rolePicker;
@property (weak, nonatomic) IBOutlet UIButton *addRoleButton;
@property (weak, nonatomic) IBOutlet UILabel *currentRolesLabel;

@property (weak, nonatomic) IBOutlet UIButton *createGameButton;

@property (nonatomic) NSInteger numPlayers;
@property (strong, nonatomic) NSMutableArray *roleArray;

@end

@implementation CreateGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize and set up text field
    self.numPlayersTextField.delegate = self;
    [self.numPlayersTextField addTarget:self.numPlayersTextField action:@selector(resignFirstResponder) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.numPlayers = self.numberInTextField;

    // Initialize and set up picker view
    self.rolePicker.delegate = self;
    self.rolePicker.dataSource = self;
    
    // Initialize add role button
    [self.addRoleButton addTarget:self action:@selector(addRole:) forControlEvents:UIControlEventTouchUpInside];
    
    // Make keyboard disappear upon tapping outside text field
    UITapGestureRecognizer *tapOutside = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tapOutside];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.numPlayersTextField endEditing:YES];
}

-(void)dismissKeyboard
{
    [self.numPlayersTextField resignFirstResponder];
}

#pragma mark - UIPickerView Methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return numberOfComponents;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == kFirstComponent) {
        return MAX_NUM_PEOPLE;
    } else {
        return [[Constants roleArray] count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == kFirstComponent) {
        return [NSString stringWithFormat:@"%d",row];
    } else {
        return [Constants roleArray][row];
    }
}

#pragma mark - UITextField Methods

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.numPlayers = self.numberInTextField;
    NSLog(@"%d",self.numPlayers);
}

-(NSInteger)numberInTextField
{
    return [self.numPlayersTextField.text intValue];
}

#pragma mark - Button Methods

-(void)setRole:(id)sender
{
    NSInteger roleCount = [self.rolePicker selectedRowInComponent:kFirstComponent];
    NSInteger roleRow = [self.rolePicker selectedRowInComponent:kSecondComponent];
    NSString *role = [Constants roleArray][roleRow];
    
    for (int i = 0; i < roleCount; i++) {
        [self.roleArray addObject:(NSString *)role];
    }
    
    NSString *roleString = [NSString stringWithFormat:@"\n%d %@",roleCount,role];
    self.currentRolesLabel.text = [self.currentRolesLabel.text stringByAppendingString:roleString];
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
