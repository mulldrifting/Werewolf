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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.navigationController setNavigationBarHidden:NO];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark - Button Methods

-(void)setupSelected
{
//    self.gameSetup = [[GameData sharedData] gameSetups][selectedRow];
}

- (IBAction) pressedBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table View Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    [self setupSelected];
    
    if ([segue.identifier isEqualToString:@"showCreateGameSegue"])
    {
        CreateGameViewController *destination = segue.destinationViewController;
        destination.gameSetup = [[[GameData sharedData] gameSetups] objectAtIndex:[[_tableView indexPathForSelectedRow] row]];
    }
}


@end
