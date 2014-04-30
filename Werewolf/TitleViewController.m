//
//  ViewController.m
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "TitleViewController.h"
#import "LoadSetupViewController.h"

@interface TitleViewController ()


@end

@implementation TitleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    [self.navigationController setNavigationBarHidden:YES];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
