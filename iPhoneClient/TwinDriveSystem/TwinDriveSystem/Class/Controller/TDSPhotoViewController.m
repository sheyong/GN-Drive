//
//  TDSPhotoViewController.m
//  TwinDriveSystem
//
//  Created by 钟 声 on 12-2-12.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "TDSPhotoViewController.h"
#import "TDSPhotoView.h"
#import "TDSPhotoModel.h"

@implementation TDSPhotoViewController

#pragma mark - Public Function

- (void)testAddMoreImage{
    int nowIndex = [self.photoSource numberOfPhotos]+1;
    TDSPhotoView *photo = [[TDSPhotoView alloc] initWithImageURL:[NSURL URLWithString:@"http://ww3.sinaimg.cn/large/75ae7671jw1dpuzsrqhb9j.jpg"] name:[NSString stringWithFormat:@"ceshi %d",nowIndex]];
    TDSPhotoView *photo2 = [[TDSPhotoView alloc] initWithImageURL:[NSURL URLWithString:@"http://pic13.nipic.com/20110307/6860000_151209260116_2.jpg"] name:[NSString stringWithFormat:@"Exia %d",nowIndex+1]];
    TDSPhotoView *photo3 = [[TDSPhotoView alloc] initWithImageURL:[NSURL URLWithString:@"http://img3.douban.com/mpic/s3517475.jpg"] name:[NSString stringWithFormat:@"Music %d",nowIndex+2]];
    [(TDSPhotoModel*)_photoSource addPhotos:[NSMutableArray arrayWithObjects:photo,photo2,photo3,nil]];
    [photo release];
    [photo2 release];
    [photo3 release];
    //  load photoviews lazily
    
    for (unsigned i = 0; i < 3; i++) {
        [self.photoViews addObject:[NSNull null]];
    }
    if ([self respondsToSelector:@selector(setupScrollViewContentSize)]) {
        [self performSelector:@selector(setupScrollViewContentSize)];
    }
}
- (void)moveToPhotoAtIndex:(NSInteger)index animated:(BOOL)animated {
    [super moveToPhotoAtIndex:index animated:animated];
	
    // 在最后一个的时候重新请求
	if (index + 1 >= [self.photoSource numberOfPhotos]-1) {
        // TODO: 请求新数据
        // 《记得加锁哟，亲》添加测试数据
        @synchronized(self){
            [self testAddMoreImage];
        }
	} 
}

#pragma mark - 
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];


}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
