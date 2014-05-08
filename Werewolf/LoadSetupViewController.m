//
//  LoadSetupViewController.m
//  Werewolf
//
//  Created by Lauren Lee on 4/14/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "LoadSetupViewController.h"
#import "CreateGameViewController.h"
#import "AppDelegate+CoreDataContext.h"
#import "NSManagedObject+Clone.h"

typedef NS_ENUM(NSInteger, gameSetupType)
{
    kCustomGameSetup,
    kDefaultGameSetup
};

@interface LoadSetupViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) NSManagedObjectContext *objectContext;
@property (weak, nonatomic) GameData *gameData;
@property (strong, nonatomic) NSArray *customSetups, *defaultSetups;

@end

@implementation LoadSetupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup table view
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // Add swipe to go back gesture
    UIScreenEdgePanGestureRecognizer *swipeToGoBack = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)];
    swipeToGoBack.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:swipeToGoBack];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate createManagedObjectContext:^(NSManagedObjectContext *context) {
        self.objectContext = context;
    }];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"GameData"];
    NSError *error;
    self.gameData = [[self.objectContext executeFetchRequest:request error:&error] firstObject];
    
   }

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Show navigation bar on load game setup screen
    [self.navigationController setNavigationBarHidden:NO];

    // Set style bar color to default = black
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [self fetchGameSetups];
    [self.tableView reloadData];
    
}

- (void)fetchGameSetups
{
    NSError *error;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"GameSetup"];
    request.predicate = [NSPredicate predicateWithFormat:@"isDefault == %@", [NSNumber numberWithBool: YES]];
    
    self.defaultSetups = [self.objectContext executeFetchRequest:request error:&error];
    
    request.predicate = [NSPredicate predicateWithFormat:@"isDefault == %@", [NSNumber numberWithBool:NO]];
    
    self.customSetups = [self.objectContext executeFetchRequest:request error:&error];
}

#pragma mark - Button Methods

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table View Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //return number of game setups in game data
    switch (section) {
        case kCustomGameSetup:

            return [self.customSetups count];
            
        default:
//            NSLog(@"%lu",(unsigned long)[[[GameData sharedData] defaultGameSetups] count]);
            return [self.defaultSetups count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetupCell" forIndexPath:indexPath];
    
    switch (indexPath.section) {
            
        case kCustomGameSetup:
            cell.textLabel.text = [self.customSetups[indexPath.row] name];
            break;
            
        default:
            cell.textLabel.text = [self.defaultSetups[indexPath.row] name];
            break;
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
//        [[GameData sharedData] removeGameDataAtIndex:indexPath.row];
        NSString *name = [self.customSetups[indexPath.row] name];
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"GameSetup"];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        
        NSError *error;
        GameSetup *object = [[self.objectContext executeFetchRequest:fetchRequest error:&error] firstObject];
        
        [self.gameData removeGameSetupsObject:object];
        
        [self fetchGameSetups];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        

    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
            
        case kCustomGameSetup:
            return YES;
            
        default:
            return NO;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.customSetups.count == 0 && section == 0) {
        return 0; //hide header if section is empty
    }
    return 50; //play around with this value
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(20.0, 10.0, 300.0, 40.0)];
    [customView setBackgroundColor:[UIColor whiteColor]];
    
    // create a label object
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0,20.0,100.0,40.0)];
    titleLabel.textColor = [UIColor colorWithWhite:0.298 alpha:1.000];
    titleLabel.font = [titleLabel.font fontWithSize:(13.0)];
    switch (section) {
        case kCustomGameSetup:
            titleLabel.text = @"CUSTOM";
            break;
        default:
            titleLabel.text = @"DEFAULT";
    }
    
    [customView addSubview:titleLabel];
    
    return customView;
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSIndexPath *indexPath = [_tableView indexPathForSelectedRow];
    
    if ([segue.identifier isEqualToString:@"showCreateGameSegue"]) {
        
        CreateGameViewController *destination = segue.destinationViewController;
        
        // use selected row to create new copy of Game Setup for editing
        GameSetup *selectedSetup;
        
        if (indexPath.section == kCustomGameSetup) {
            
            selectedSetup = [self.customSetups objectAtIndex:[[_tableView indexPathForSelectedRow] row]];
            
        } else {
            
            selectedSetup = [self.defaultSetups objectAtIndex:[[_tableView indexPathForSelectedRow] row]];
        }
        
        destination.gameSetup = (GameSetup*)[selectedSetup clone];
        destination.title = [selectedSetup name];
    }
}


@end
