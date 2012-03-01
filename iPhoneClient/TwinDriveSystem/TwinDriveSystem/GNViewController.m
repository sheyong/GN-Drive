    //
//  ViewController.m
//  TwinDriveSystem
//
//  Created by 钟 声 on 12-2-12.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "GNViewController.h"
#import "TDSPhotoViewController.h"
#import "TDSPhotoModel.h"
#import "TDSPhotoView.h"
#import "TDSNetControlCenter.h"
#import "TDSMainScreenViewController.h"
#import "TDSRequestObject.h"

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
- (TDSPhotoModel *)testSource{
    TDSPhotoView *photo = [[TDSPhotoView alloc] initWithImageURL:[NSURL URLWithString:@"http://ww3.sinaimg.cn/large/75ae7671jw1dpuzsrqhb9j.jpg"] name:@" laksd;lkas;dlkaslkd ;a"];
    TDSPhotoView *photo2 = [[TDSPhotoView alloc] initWithImageURL:[NSURL URLWithString:@"http://pic13.nipic.com/20110307/6860000_151209260116_2.jpg"] name:@"Exia "];
    TDSPhotoView *photo3 = [[TDSPhotoView alloc] initWithImageURL:[NSURL URLWithString:@"http://img3.douban.com/mpic/s3517475.jpg"] name:@"Music "];
    TDSPhotoModel *source = [[TDSPhotoModel alloc] initWithPhotos:[NSArray arrayWithObjects:photo, photo2, photo3, nil]];
    [photo release];
    [photo2 release];
    [photo3 release];
    
    return [source autorelease];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
	TDSPhotoViewController *photoViewController = [[TDSPhotoViewController alloc] initWithPhotoSource:[self testSource]];
    photoViewController.view.backgroundColor = [UIColor clearColor];
    
    UIViewController *collectViewController = [[UIViewController alloc] init];
    collectViewController.view.backgroundColor = [UIColor redColor];

    UIViewController *aboutViewController = [[UIViewController alloc] init];
    aboutViewController.view.backgroundColor = [UIColor blueColor];
    
    _mainScreenViewController = [[TDSMainScreenViewController alloc] init];
    [_mainScreenViewController setViewControllers:[NSArray arrayWithObjects:photoViewController,collectViewController,aboutViewController, nil]];
    [self.view addSubview:_mainScreenViewController.view];
    
    [photoViewController release];    
	[collectViewController release];    
	[aboutViewController release];	
    
    // test ASIHttpRequest OK!!~
    TDSNetControlCenter *request = [[TDSNetControlCenter alloc] init];
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    [query setObject:@"0" forKey:@"start"];
    TDSRequestObject *requestObject = [TDSRequestObject requestObjectForQuery:query];
    [request sendRequestWithObject:requestObject];
    
    
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
