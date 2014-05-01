//
//  WerewolfViewController.m
//  Werewolf
//
//  Created by Lauren Lee on 4/30/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "WerewolfViewController.h"
#import "SettingsViewController.h"
#import "TitleViewController.h"

@interface WerewolfViewController ()

@end

@implementation WerewolfViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupSettingsGesture];
    
    TitleViewController *titleViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"title"];
//    [self presentViewController:titleViewController animated:NO completion:nil];
    UINavigationController *titleNav = [[UINavigationController alloc] initWithRootViewController:titleViewController];
    
    [self addChildViewController:titleNav];
    [self.view addSubview:titleNav.view];
    [titleNav didMoveToParentViewController:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)setupSettingsGesture
{
    UILongPressGestureRecognizer *openSettingsGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showSettingsView)];
    
    [openSettingsGesture setMinimumPressDuration:.8];
    [openSettingsGesture setNumberOfTouchesRequired:3];
    
    [self.view addGestureRecognizer:openSettingsGesture];
}

- (void)showSettingsView
{
    
    // This isn't working - find out why
    NSLog(@"start show settings");
    [self dismissViewControllerAnimated:YES completion:^{
        
        NSLog(@"inside completion block");
        UIViewController *settingsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"settings"];
        [settingsViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        [self presentViewController:settingsViewController animated:YES completion:nil];

    }];
    
    
}

- (IBAction)closeSettingsView:(id)sender
{
    // set the new values in NSUserDefaults
    
    [self dismissViewControllerAnimated:YES completion:^{
        // post an NSNotifcation for "SettingsChanged"
    }];
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
