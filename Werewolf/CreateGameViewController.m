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

@property (nonatomic) NSIndexPath *expandingIndexPath;
@property (nonatomic) NSIndexPath *expandedIndexPath;

@end

@implementation CreateGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Show navigation bar in edit game setup screen
    [self.navigationController setNavigationBarHidden:NO];
    
    // Set style bar to default color = black
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

// change dictionary value for role in roleNumbers
// sent from Stepper Table View Cell
- (void)setValue:(int)value forRole:(NSString*)role
{
    NSString *key = [@"num" stringByAppendingString:role];
    [self.gameSetup setValue:[NSNumber numberWithInt:value] forKey:key];
}

- (NSIndexPath *)actualIndexPathForTappedIndexPath:(NSIndexPath *)indexPath
{
	if (self.expandedIndexPath && [indexPath row] > [self.expandedIndexPath row]) {
		return [NSIndexPath indexPathForRow:[indexPath row] - 1
								  inSection:[indexPath section]];
	}
	
	return indexPath;
}

#pragma mark - Table View Data Source Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // if a cell is expanded, take into account
    if (self.expandedIndexPath) {
        return [[Constants listOfDefinedRoles] count] + 1;
    }
    // number of defined roles
    return [[Constants listOfDefinedRoles] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    // init expanded cell
	if ([indexPath isEqual:self.expandedIndexPath]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DescCell"
                                                                forIndexPath:indexPath];
        
        if (cell == nil) {
            NSLog(@"Desc Cell is nil");
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                          reuseIdentifier:cellIdentifier];
        }
        
        NSIndexPath *theIndexPath = [self actualIndexPathForTappedIndexPath:indexPath];
		[cell.textLabel setText:[[Constants listOfRoleDescriptions] objectAtIndex:[theIndexPath row] - 1]];
        cell.textLabel.font = [[cell.textLabel font] fontWithSize:14.0];

        return cell;
	}
    
    // init expanding cell
	else {
        
        StepperTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoleCell" forIndexPath:indexPath];
        
        if (cell == nil) {
            NSLog(@"Role Cell is nil");
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                          reuseIdentifier:cellIdentifier];
        }
        
        // set cell's delegate to self
        cell.delegate = self;
        
        // set cell's values using the list of defined roles and the game setup dictionary roleNumbers
        NSIndexPath *theIndexPath = [self actualIndexPathForTappedIndexPath:indexPath];
        NSString *roleString = [Constants listOfDefinedRoles][theIndexPath.row];
        cell.roleLabel.text = roleString;
        cell.stepper.value = [[self.gameSetup valueForKey:roleString] doubleValue];
        cell.numberLabel.text = [NSString stringWithFormat:@"%d",(int)cell.stepper.value];
        
        return cell;

	}
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // disable touch on expanded cell
	UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
	if ([[cell reuseIdentifier] isEqualToString:@"DescCell"]) {
		return;
	}
	
    // deselect row
	[tableView deselectRowAtIndexPath:indexPath
							 animated:NO];
	
    // get the actual index path
	indexPath = [self actualIndexPathForTappedIndexPath:indexPath];
	
    // save the expanded cell to delete it later
	NSIndexPath *theExpandedIndexPath = self.expandedIndexPath;
	
    // same row tapped twice - get rid of the expanded cell
	if ([indexPath isEqual:self.expandingIndexPath]) {
		self.expandingIndexPath = nil;
		self.expandedIndexPath = nil;
	}
    // add the expanded cell
	else {
		self.expandingIndexPath = indexPath;
		self.expandedIndexPath = [NSIndexPath indexPathForRow:[indexPath row] + 1
													inSection:[indexPath section]];
	}
	
	[tableView beginUpdates];
	
	if (theExpandedIndexPath) {
		[_tableView deleteRowsAtIndexPaths:@[theExpandedIndexPath]
							 withRowAnimation:UITableViewRowAnimationNone];
	}
	if (self.expandedIndexPath) {
		[_tableView insertRowsAtIndexPaths:@[self.expandedIndexPath]
							 withRowAnimation:UITableViewRowAnimationNone];
	}
	
	[tableView endUpdates];
	
    // scroll to the expanded cell
	[_tableView scrollToRowAtIndexPath:indexPath
							 atScrollPosition:UITableViewScrollPositionMiddle
									 animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([indexPath isEqual:self.expandedIndexPath]) {
        return 90.0;
    }
    else {
        return 50.0;
    }
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
        
        
        



        GameSetup *newSetup = [NSEntityDescription insertNewObjectForEntityForName:@"GameSetup"
                                                            inManagedObjectContext:self.gameSetup.managedObjectContext];
        newSetup.name = textField.text;
        
        
        NSError *error;
        [self.gameSetup.managedObjectContext save:&error];
        
//        GameSetup *newGameSetup = [[GameSetup alloc] initWithName:textField.text roleNumbers:self.gameSetup.roleNumbers settings:[NSMutableDictionary new]];
//        [[GameData sharedData] addNewGameSetup:newGameSetup];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showGameViewSegue"]) {
        GameViewController *destination = segue.destinationViewController;
        
        Game *newGame = [[Game alloc] initWithGameSetup:_gameSetup];
        destination.game = newGame;
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
