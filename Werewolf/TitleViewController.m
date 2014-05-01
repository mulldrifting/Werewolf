//
//  ViewController.m
//  Werewolf
//
//  Created by Lauren Lee on 4/11/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import "TitleViewController.h"
#import "LoadSetupViewController.h"
#import "CRProductTour.h"

@interface TitleViewController ()

@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

@property (strong, nonatomic) CRProductTour *productTourView;

@end

@implementation TitleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupSettingsPopover];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    
}

- (void)setupSettingsPopover
{
    _productTourView = [[CRProductTour alloc] initWithFrame:self.view.frame] ;
    
    // Create popover bubble
    CRBubble *settingsBubble = [[CRBubble alloc] initWithAttachedView:_settingsButton title:@"" description:@"Hold down three fingers to open\nthe settings at any time" arrowPosition:CRArrowPositionLeft andColor:[UIColor colorWithWhite:0.200 alpha:1.000]];
    NSMutableArray *bubbleArray = [[NSMutableArray alloc] initWithObjects:settingsBubble, nil];
    [_productTourView setBubbles:bubbleArray];
    
    [self.view addSubview:_productTourView];
    
}

- (IBAction)toggleSettingsPopover:(id)sender {
    [_productTourView setVisible:![_productTourView isVisible]];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
