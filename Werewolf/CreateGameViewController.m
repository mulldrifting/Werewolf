//
//  CreateGameViewController.m
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "CreateGameViewController.h"
#import "StepperTableViewCell.h"
#import "Game.h"
#import "GameData.h"
#import "NSDictionary+Common.h"

@interface CreateGameViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, StepperTableViewCellProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *startButton;

//@property (strong, nonatomic) NSMutableDictionary *currentRoles;
//@property (strong, nonatomic) NSMutableArray *availableRoles;

@end

@implementation CreateGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    
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
//    self.pickerController = [PickerController new];
//    self.rolePicker.delegate = self;
//    self.rolePicker.dataSource = self;
//    self.rolePicker.tag = kRolePicker;
    
    // Game setup test
//    self.gameSetup = [[GameSetup alloc] init];
    
    NSLog(@"%@",self.gameSetup.roleNumbers);
    
    // Available roles setup
//    self.availableRoles = [NSMutableArray arrayWithArray:[Constants listOfDefinedRoles]];
//    for (NSString *role in [self.gameSetup.roles allKeys]) {
//        [self.availableRoles removeObject:role];
//    }
    
    
    // Initialize buttons
//    [self.backButton addTarget:self action:@selector(saveRoles:) forControlEvents:UIControlEventTouchUpInside];
//    [self.addRoleButton addTarget:self action:@selector(addRole:) forControlEvents:UIControlEventTouchUpInside];
    
    // Make keyboard disappear upon tapping outside text field
//    UITapGestureRecognizer *tapOutside = [[UITapGestureRecognizer alloc]
//                                          initWithTarget:self
//                                          action:@selector(dismissKeyboard)];
//    [self.view addGestureRecognizer:tapOutside];
    
    // Create dictionary of roles
//    self.currentRoles = [NSMutableDictionary dictionaryWithDictionary:self.gameSetup.roles];
}

- (void)setValue:(int)value forRole:(NSString*)role
{
    [self.gameSetup.roleNumbers setValue:[NSNumber numberWithInt:value] forKey:role];
}

#pragma mark - Table View Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.gameSetup.roleNumbers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    StepperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoleCell" forIndexPath:indexPath];
    cell.delegate = self;
    
    NSString *aKey = [self.gameSetup.roleNumbers keyAtIndex:indexPath.row];
    NSNumber *anObject = [self.gameSetup.roleNumbers objectForKey:aKey];
    cell.roleLabel.text = aKey;
    cell.stepper.value = [anObject doubleValue];
    cell.numberLabel.text = [NSString stringWithFormat:@"%d",(int)cell.stepper.value];
    
    return cell;
}

//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
////        [self.availableRoles addObject:[self.gameSetup.roles keyAtIndex:indexPath.row]];
//        [self.gameSetup.roles removeObjectForKey:[self.gameSetup.roles keyAtIndex:indexPath.row]];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        [self.rolePicker reloadAllComponents];
//    }
//}


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

//-(void)addRole:(id)sender
//{
//    NSInteger selectedRow = [self.rolePicker selectedRowInComponent:0];
//    
//    if (selectedRow == 0) {
//        return;
//    }
//    
//    NSString *role = self.availableRoles[selectedRow-1];
//    
//    if ([self.availableRoles containsObject:role]) {
//        
//        [self.gameSetup.roles setValue:[NSNumber numberWithInteger:1] forKey:role];
//        [self.availableRoles removeObject:role];
//        [self.tableView reloadData];
//        [self.rolePicker reloadAllComponents];
//    }
//}

-(IBAction)startGame:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Save Setup As" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", @"Don't Save", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    NSString *numPlayers = [[self.gameSetup numPlayers] stringValue];
    
    [[alertView textFieldAtIndex:0] setDelegate:self];
    [[alertView textFieldAtIndex:0] setText:[NSString stringWithFormat:@"%@P ", numPlayers]];
    [alertView show];
}

- (IBAction) pressedBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Alert View Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *textField = [alertView textFieldAtIndex:0];
    
    if (buttonIndex == 1) {
        
        GameSetup *newGameSetup = [[GameSetup alloc] initWithName:textField.text roles:self.gameSetup.roleNumbers];
        [[GameData sharedData] addNewGameSetup:newGameSetup];
    }
}

#pragma mark - Picker Methods

//-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    return 1;
//}

//-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//    return [self.availableRoles count] + 1;
//    
//}
//
//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    if (row == 0) {
//        return @"Add a Role";
//    } else {
//        return self.availableRoles[row-1];
//    }
//}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
