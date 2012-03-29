    //
//  ViewController.m
//  TwinDriveSystem
//
//  Created by 钟 声 on 12-2-12.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "GNViewController.h"
#import "TDSNetControlCenter.h"
#import "TDSRequestObject.h"
#import "TDSPhotoViewController.h"
#import "TDSPhotoDataSource.h"
#import "TDSPhotoView.h"
#import "TDSMainScreenViewController.h"
#import "TDSAboutViewController.h"
@implementation GNViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)dealloc{
    [_mainScreenViewController release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
	TDSPhotoViewController *photoViewController = [[TDSPhotoViewController alloc] init];
    photoViewController.view.backgroundColor = [UIColor clearColor];
    
    EGOPhotoViewController *collectViewController = [[EGOPhotoViewController alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    collectViewController.view.backgroundColor = [UIColor redColor];


    TDSAboutViewController *aboutViewController = [[TDSAboutViewController alloc] init];
    aboutViewController.view.backgroundColor = [UIColor blueColor];
    UINavigationController *navAboutViewController = [[UINavigationController alloc] initWithRootViewController:aboutViewController];     
    navAboutViewController.navigationBar.tintColor = [UIColor blackColor];

    
    _mainScreenViewController = [[TDSMainScreenViewController alloc] init];
    [_mainScreenViewController setViewControllers:[NSArray arrayWithObjects:photoViewController,collectViewController,navAboutViewController, nil]];
    [self.view addSubview:_mainScreenViewController.view];
    
    [photoViewController release];    
	[collectViewController release];    
	[aboutViewController release];	

    [navAboutViewController release];    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return ((interfaceOrientation == UIInterfaceOrientationPortrait)||
            (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown));
}

@end
