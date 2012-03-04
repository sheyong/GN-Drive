//
//  TDSPhotoViewController.m
//  TwinDriveSystem
//
//  Created by 钟 声 on 12-2-12.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "TDSPhotoViewController.h"
#import "TDSPhotoView.h"
#import "TDSPhotoDataSource.h"
#import "TDSRequestObject.h"
#import "TDSResponseObject.h"

#define ONCE_REQUEST_COUNT_LIMIT 5
#define MAC_COUNT_LIMIT 200

@interface TDSPhotoViewController(Private)
- (void)photosLoadMore:(BOOL)more ofSize:(NSInteger)index;
@end

@implementation TDSPhotoViewController


#pragma mark - 
- (void)dealloc{
    [_photoViewNetControlCenter release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (id)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleBarsNotification:) name:@"EGOPhotoViewToggleBars" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photoViewDidFinishLoading:) name:@"EGOPhotoDidFinishLoading" object:nil];
		
		self.hidesBottomBarWhenPushed = YES;
		self.wantsFullScreenLayout = YES;		
		_photoSource = [[TDSPhotoDataSource alloc] init];
		_pageIndex = 0;
        _requestPage = 0;
        [[self photoSource] addLoadingPhotosOfCount:ONCE_REQUEST_COUNT_LIMIT];
    }
    return self;
}
- (TDSPhotoDataSource *)photoSource{
    return (TDSPhotoDataSource*)_photoSource;
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

    [self photosLoadMore:NO ofSize:(_requestPage*ONCE_REQUEST_COUNT_LIMIT)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - Super Function

- (void)testAddMoreImage{
    int nowIndex = [self.photoSource numberOfPhotos]+1;
    TDSPhotoView *photo = [[TDSPhotoView alloc] initWithImageURL:[NSURL URLWithString:@"http://ww4.sinaimg.cn/bmiddle/8136e213jw1dmwr3ivzrhj.jpg"] name:[NSString stringWithFormat:@"ceshi %d",nowIndex]];
    TDSPhotoView *photo2 = [[TDSPhotoView alloc] initWithImageURL:[NSURL URLWithString:@"http://pic13.nipic.com/20110307/6860000_151209260116_2.jpg"] name:[NSString stringWithFormat:@"Exia %d",nowIndex+1]];
    TDSPhotoView *photo3 = [[TDSPhotoView alloc] initWithImageURL:[NSURL URLWithString:@"http://img3.douban.com/mpic/s3517475.jpg"] name:[NSString stringWithFormat:@"Music %d",nowIndex+2]];
    [[self photoSource] addPhotos:[NSArray arrayWithObjects:photo,photo2,photo3,nil]];
    [photo release];
    [photo2 release];
    [photo3 release];
    //  load photoviews lazily
    
    for (unsigned i = 0; i < ONCE_REQUEST_COUNT_LIMIT; i++) {
        [self.photoViews addObject:[NSNull null]];
    }
    if ([self respondsToSelector:@selector(setupScrollViewContentSize)]) {
        [self performSelector:@selector(setupScrollViewContentSize)];
    }
}

- (void)moveToPhotoAtIndex:(NSInteger)index animated:(BOOL)animated {
    [super moveToPhotoAtIndex:index animated:animated];
	
    // 在最后2个内的时候重新请求
	if (index + 1 >= [self.photoSource numberOfPhotos]-1 && [self.photoViews count] < MAC_COUNT_LIMIT) {
        // TODO: 请求新数据
        // 《记得加锁哟，亲》添加测试数据
        @synchronized(self){
            // load photoSource first
            [[self photoSource] addLoadingPhotosOfCount:ONCE_REQUEST_COUNT_LIMIT];
            for (unsigned i = 0; i < ONCE_REQUEST_COUNT_LIMIT; i++) {
                [self.photoViews addObject:[NSNull null]];
            }
            if ([self respondsToSelector:@selector(setupScrollViewContentSize)]) {
                [self performSelector:@selector(setupScrollViewContentSize)];
            }
            
//            [self testAddMoreImage];// test
            // send request
            [self photosLoadMore:YES ofSize:(++_requestPage)*ONCE_REQUEST_COUNT_LIMIT];
        }
	} 
}

#pragma mark - Private Function

- (void)photosLoadMore:(BOOL)more ofSize:(NSInteger)index{
    if (!_photoViewNetControlCenter) {
        _photoViewNetControlCenter = [[TDSNetControlCenter alloc] init];
        _photoViewNetControlCenter.delegate = self;
    }
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    if (more) {
        [query setObject:[NSNumber numberWithInt:index] forKey:@"start"];
    }else{
        [query setObject:@"0" forKey:@"start"];
    }
    TDSRequestObject *requestObject = [TDSRequestObject requestObjectForQuery:query];
    [_photoViewNetControlCenter sendRequestWithObject:requestObject];
}

#pragma mark - TDSNetControlCenterDelegate

- (void)tdsNetControlCenter:(TDSNetControlCenter*)netControlCenter requestDidStartRequest:(id)response{
    
}
- (void)tdsNetControlCenter:(TDSNetControlCenter*)netControlCenter requestDidFinishedLoad:(id)response{
    TDSLOG_debug(@"result :%@",response );
    if ([response isKindOfClass:[NSArray class]]) {
        NSArray *responseArray = (NSArray *)response;
        NSMutableArray *photoArray = [NSMutableArray arrayWithCapacity:[responseArray count]];
        for (id object in responseArray) {
            if ([object isKindOfClass:[TDSResponseObject class]]) {
                TDSResponseObject *responseObject = (TDSResponseObject*)object;
                TDSPhotoView *photoView = [[TDSPhotoView alloc] initWithResponseObject:responseObject];
                [photoArray addObject:photoView];
                [photoView release];
                TDSLOG_debug(@" ### response url:%@ \n des:%@", responseObject.picUrlText,responseObject.describeText);
            }
        }
        // reset photos
        NSRange range ;
        range.location = _requestPage*ONCE_REQUEST_COUNT_LIMIT;
        range.length = ONCE_REQUEST_COUNT_LIMIT;
        NSLog(@" ### range:(%d,%d)",range.location,range.length);
        [[self photoSource] addPhotos:photoArray inRange:range];
        if ([self respondsToSelector:@selector(loadScrollViewWithPage:)]) {
            [self loadScrollViewWithPage:range.location];            
        }
    }
}
- (void)tdsNetControlCenter:(TDSNetControlCenter*)netControlCenter requestDidFailedLoad:(id)response{
    TDSLOG_debug(@" ## controller load failed:%@", response);
}

@end
