//
//  CreateGameViewController.m
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "CreateGameViewController.h"
#import "PickerController.h"
#import "StepperTableViewCell.h"
#import "Game.h"
#import "GameSetup.h"
#import "NSDictionary+Common.h"

@interface CreateGameViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIPickerView *rolePicker;
@property (strong, nonatomic) PickerController *pickerController;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *addRoleButton;

@property (strong, nonatomic) GameSetup *testSetup;
@property (strong, nonatomic) NSMutableDictionary *currentRoles;

@end

@implementation CreateGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up scroll view
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    // Initialize and set up text field
//    self.numPlayersTextField.delegate = self;
//    [self.numPlayersTextField addTarget:self.numPlayersTextField action:@selector(resignFirstResponder) forControlEvents:UIControlEventEditingDidEndOnExit];
    
//    self.numPlayers = self.numberInTextField;

    // Set up table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Initialize and set up picker views
    self.pickerController = [PickerController new];
    self.rolePicker.delegate = self.pickerController;
    self.rolePicker.dataSource = self.pickerController;
    self.rolePicker.tag = kRolePicker;
    
    // Game setup test
    self.testSetup = [[GameSetup alloc] init];
    
    // Initialize buttons
//    [self.backButton addTarget:self action:@selector(saveRoles:) forControlEvents:UIControlEventTouchUpInside];
    [self.addRoleButton addTarget:self action:@selector(addRole:) forControlEvents:UIControlEventTouchUpInside];
    
    // Make keyboard disappear upon tapping outside text field
//    UITapGestureRecognizer *tapOutside = [[UITapGestureRecognizer alloc]
//                                          initWithTarget:self
//                                          action:@selector(dismissKeyboard)];
//    [self.view addGestureRecognizer:tapOutside];
    
    // Create dictionary of roles
    self.currentRoles = [NSMutableDictionary dictionaryWithDictionary:self.testSetup.roles];
}


#pragma mark - Table View Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.currentRoles count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    StepperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *aKey = [self.currentRoles keyAtIndex:indexPath.row];
    NSNumber *anObject = [self.currentRoles objectForKey:aKey];
    cell.roleLabel.text = aKey;
    cell.stepper.value = [anObject doubleValue];
    cell.numberLabel.text = [NSString stringWithFormat:@"%d",(int)cell.stepper.value];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.currentRoles removeObjectForKey:[self.currentRoles keyAtIndex:indexPath.row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - UITextField Methods

//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    self.numPlayers = self.numberInTextField;
//    NSLog(@"%d",self.numPlayers);
//}

//-(NSInteger)numberInTextField
//{
//    return [self.numPlayersTextField.text intValue];
//}

#pragma mark - Button Methods

-(void)addRole:(id)sender
{
    NSInteger roleRow = [self.rolePicker selectedRowInComponent:0];
    NSString *role = [Constants listOfDefinedRoles][roleRow];
    
    [self.currentRoles setValue:[NSNumber numberWithInteger:1] forKey:role];
    
//    NSString *roleString = [NSString stringWithFormat:@"\n%d %@",roleCount,role];
//    self.currentRolesLabel.text = [self.currentRolesLabel.text stringByAppendingString:roleString];

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
