//
//  CreateGameViewController.m
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "CreateGameViewController.h"
#import "GameViewController.h"
#import "StepperTableViewCell.h"
#import "Game.h"
#import "GameData.h"
#import "NSDictionary+Common.h"

@interface CreateGameViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UITextFieldDelegate, StepperTableViewCellProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *startButton;

@end

@implementation CreateGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Show navigation bar in edit game setup screen
    [self.navigationController setNavigationBarHidden:NO];

    // Set up table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Set up gesture recognizers
    UIScreenEdgePanGestureRecognizer *swipeToGoBack = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)];
    swipeToGoBack.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:swipeToGoBack];
    
    // Initialize buttons
//    [self.backButton addTarget:self action:@selector(saveRoles:) forControlEvents:UIControlEventTouchUpInside];
//    [self.addRoleButton addTarget:self action:@selector(addRole:) forControlEvents:UIControlEventTouchUpInside];
    
    // Make keyboard disappear upon tapping outside text field
//    UITapGestureRecognizer *tapOutside = [[UITapGestureRecognizer alloc]
//                                          initWithTarget:self
//                                          action:@selector(dismissKeyboard)];
//    [self.view addGestureRecognizer:tapOutside];

}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

// change dictionary value for role in roleNumbers
// sent from Stepper Table View Cell
- (void)setValue:(int)value forRole:(NSString*)role
{
    [self.gameSetup.roleNumbers setValue:[NSNumber numberWithInt:value] forKey:role];
}

#pragma mark - Table View Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // number of defined roles
    return [[Constants listOfDefinedRoles] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    StepperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoleCell" forIndexPath:indexPath];
    
    // set cell's delegate to self
    cell.delegate = self;
    
    // set cell's values using the list of defined roles and the game setup dictionary roleNumbers
    NSString *roleString = [Constants listOfDefinedRoles][indexPath.row];
    cell.roleLabel.text = roleString;
    cell.stepper.value = [[self.gameSetup.roleNumbers objectForKey:roleString] doubleValue];
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

#pragma mark - Button Methods

- (IBAction)saveSetup:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Save Setup As" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [[alertView textFieldAtIndex:0] setDelegate:self];
    [[alertView textFieldAtIndex:0] setText:[NSString stringWithFormat:@"%dP ", [self.gameSetup numPlayers]]];
    [alertView show];
}


#pragma mark - Alert View Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *textField = [alertView textFieldAtIndex:0];
    
    if (buttonIndex == 1) {
        
        GameSetup *newGameSetup = [[GameSetup alloc] initWithName:textField.text roleNumbers:self.gameSetup.roleNumbers settings:[NSMutableDictionary new]];
        [[GameData sharedData] addNewGameSetup:newGameSetup];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showGameViewSegue"]) {
        GameViewController *destination = segue.destinationViewController;
        
        Game *newGame = [[Game alloc] initWithGameSetup:_gameSetup];
        [newGame prepareGame];
        destination.game = newGame;
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
