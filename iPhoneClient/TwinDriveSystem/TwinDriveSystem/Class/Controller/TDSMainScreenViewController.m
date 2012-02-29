//
//  TDSTabViewController.m
//  TwinDriveSystem
//
//  Created by zhongsheng on 12-2-28.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "TDSMainScreenViewController.h"
#import "TDSPhotoViewController.h"

@implementation TDSMainScreenViewController
@synthesize tabBar = _tabBar;
@synthesize viewControllers = _viewControllers;
@synthesize currentViewControllerIndex = _currentViewControllerIndex;

- (void)dealloc{
    self.tabBar = nil;
    self.viewControllers = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:3];  
    
    TDSPhotoViewController *photoViewController = [[TDSPhotoViewController alloc] initWithPhotoSource:nil];
    photoViewController.view.backgroundColor = [UIColor clearColor];
    [viewControllers addObject:photoViewController];
    [photoViewController release];
    
    UIViewController *collectViewController = [[UIViewController alloc] init];
    collectViewController.view.backgroundColor = [UIColor redColor];
    [viewControllers addObject:collectViewController];
    [collectViewController release];
    
    UIViewController *aboutViewController = [[UIViewController alloc] init];
    aboutViewController.view.backgroundColor = [UIColor blueColor];
    [viewControllers addObject:aboutViewController];
    [aboutViewController release];
    
    self.viewControllers = viewControllers;
    
    for (UIViewController *viewController in self.viewControllers) {
        
        viewController.view.frame = CGRectMake(0,
                                               0,
                                               self.view.bounds.size.width,
                                               self.view.bounds.size.height);
        viewController.view.hidden = YES;
        [self.view addSubview:viewController.view];
    }
    
    CGRect tabBarFrame = CGRectMake(0, self.view.bounds.size.height, 0, 0);
    TDSMainScreenTabBar *tabBar = [[TDSMainScreenTabBar alloc] initWithFrame:tabBarFrame];
    self.tabBar = tabBar;
    tabBarFrame = CGRectMake(0,
                             self.view.bounds.size.height - self.tabBar.selfSize.height,
                             self.tabBar.selfSize.width,
                             self.tabBar.selfSize.height);
    self.tabBar.barDelegate = self;
    self.tabBar.frame = tabBarFrame;
    [tabBar release],tabBar = nil;
    [self.view addSubview:self.tabBar];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 
    UIViewController* viewController = [self.viewControllers objectAtIndex:self.currentViewControllerIndex];
    viewController.view.hidden = NO;
    [viewController viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.topItem.leftBarButtonItem = nil;
    self.navigationController.navigationBar.topItem.rightBarButtonItem = nil;
    // 
    UIViewController* viewController = [self.viewControllers objectAtIndex:self.currentViewControllerIndex];
    [viewController viewDidAppear:animated];
    
    [self showNewViewController:self.currentViewControllerIndex viewAppear:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    UIViewController *currentViewController = [self.viewControllers objectAtIndex:self.currentViewControllerIndex];
    [currentViewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    UIViewController *currentViewController = [self.viewControllers objectAtIndex:self.currentViewControllerIndex];
    [currentViewController viewDidDisappear:animated];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tabBar setSelectTabIndex:self.currentViewControllerIndex animated:NO];

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.viewControllers = nil;
    self.tabBar = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// 隐藏旧的界面
- (void)hideOldViewController:(NSInteger)oldIndex
{
    UIViewController* viewController = [self.viewControllers objectAtIndex:oldIndex];
    self.navigationController.navigationBar.topItem.leftBarButtonItem = nil;
    self.navigationController.navigationBar.topItem.rightBarButtonItem = nil;
    
    viewController.view.hidden = YES;
    [viewController viewWillDisappear:NO];
    [viewController viewDidDisappear:NO];
}

// 显示新的界面
- (void)showNewViewController:(NSInteger)newIndex viewAppear:(BOOL)viewAppear
{
    UIViewController* viewController = [self.viewControllers objectAtIndex:newIndex];
    viewController.view.hidden = NO;
    
    if (viewAppear) {
        [viewController viewWillAppear:NO];
        [viewController viewDidAppear:NO];        
    }
}

#pragma mark - mainScreenTabBar delegate
- (void)mainScreenTabBar:(TDSMainScreenTabBar *)tabBar didSelectIndex:(NSInteger)index animated:(BOOL)animated{
    if (index == self.currentViewControllerIndex) {
        return;
    }
    
    // 隐藏旧的
    [self hideOldViewController:self.currentViewControllerIndex];
    // 更新索引
    self.currentViewControllerIndex = index;
    // 显示新的
    [self showNewViewController:index viewAppear:YES];
}

@end
