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


@interface LoadSetupViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LoadSetupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Show navigation bar on load game setup screen
    [self.navigationController setNavigationBarHidden:NO];
    
    // Add swipe to go back gesture
    UIScreenEdgePanGestureRecognizer *swipeToGoBack = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)];
    swipeToGoBack.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:swipeToGoBack];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark - Button Methods

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table View Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return number of game setups in shared data
    return [[[GameData sharedData] gameSetups] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetupCell" forIndexPath:indexPath];
    cell.textLabel.text = [[[GameData sharedData] gameSetups][indexPath.row] name];
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"showCreateGameSegue"])
    {
        CreateGameViewController *destination = segue.destinationViewController;
        
        // use selected row to create new copy of Game Setup for editing
        GameSetup *selectedSetup = [[[GameData sharedData] gameSetups] objectAtIndex:[[_tableView indexPathForSelectedRow] row]];
        destination.gameSetup = [selectedSetup copy];
    }
}


@end
