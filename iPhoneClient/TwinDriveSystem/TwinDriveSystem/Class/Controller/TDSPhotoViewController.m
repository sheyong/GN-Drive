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
#import "TDSPhotoViewItem.h"

#define ONCE_REQUEST_COUNT_LIMIT 5
#define MAC_COUNT_LIMIT 200

@interface TDSPhotoViewController(Private)
- (void)photosLoadMore:(BOOL)more ofSize:(NSInteger)index;
@end
@interface TDSPhotoViewController(Super)
- (void)setupScrollViewContentSize;
- (void)loadScrollViewWithPage:(NSInteger)page;
@end
@implementation TDSPhotoViewController
@synthesize photoViewNetControlCenter = _photoViewNetControlCenter;

#pragma mark - 
- (void)dealloc{
    self.photoViewNetControlCenter = nil;
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
        _requestForwardPageCount = 0;

        // 初始化载入Loading图
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

- (void)loadScrollViewWithPage:(NSInteger)page {
	
    if (page < 0) return;
    if (page >= [self.photoSource numberOfPhotos]) return;
	
	EGOPhotoImageView * photoView = [self.photoViews objectAtIndex:page];
	if ((NSNull*)photoView == [NSNull null]) {
		
		photoView = [self dequeuePhotoView];
		if (photoView != nil) {
			[self.photoViews exchangeObjectAtIndex:photoView.tag withObjectAtIndex:page];
			photoView = [self.photoViews objectAtIndex:page];
		}
		
	}
	
	if (photoView == nil || (NSNull*)photoView == [NSNull null]) {
		
		photoView = [[EGOPhotoImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
		[self.photoViews replaceObjectAtIndex:page withObject:photoView];
		[photoView release];
		
	} 
	
	[photoView setPhoto:[self.photoSource photoAtIndex:page]];
	
    if (photoView.superview == nil) {
		[self.scrollView addSubview:photoView];
	}
	
	CGRect frame = self.scrollView.frame;
	NSInteger centerPageIndex = _pageIndex;
	CGFloat xOrigin = (frame.size.width * page);
	if (page > centerPageIndex) {
		xOrigin = (frame.size.width * page) + EGOPV_IMAGE_GAP;
	} else if (page < centerPageIndex) {
		xOrigin = (frame.size.width * page) - EGOPV_IMAGE_GAP;
	}
	
	frame.origin.x = xOrigin;
	frame.origin.y = 0;
	photoView.frame = frame;
}

- (void)setupScrollViewContentSize{
	
	CGFloat toolbarSize = _popover ? 0.0f : self.navigationController.toolbar.frame.size.height;	
	
	CGSize contentSize = self.view.bounds.size;
	contentSize.width = (contentSize.width * [self.photoSource numberOfPhotos]);
	
	if (!CGSizeEqualToSize(contentSize, self.scrollView.contentSize)) {
		self.scrollView.contentSize = contentSize;
	}
	
	_captionView.frame = CGRectMake(0.0f, self.view.bounds.size.height - (toolbarSize + 40.0f), self.view.bounds.size.width, 40.0f);
    
}

- (void)moveToPhotoAtIndex:(NSInteger)index animated:(BOOL)animated {
    [super moveToPhotoAtIndex:index animated:animated];
    NSLog(@" ##all:%d   %d",[self.photoViews count],[self.photoSource numberOfPhotos]);
	NSLog(@" @@@ move to :%d",index);
    
    // 超过一天能看的总数了
    if([self.photoViews count] >= MAC_COUNT_LIMIT){
        NSLog(@" mo~ ");
    }
    else if([self.photoSource numberOfPhotos]<=0 || [self.photoViews count]<=0){
        return;
    }
    // 无限前滚逻辑
    // 在浏览到第一张照片的时候添加loadingView和请求
    if (index == 0) 
    {
        NSLog(@" ### now index = 0");
        _requestForwardPageCount += 1;
        NSMutableArray *photoArray = [NSMutableArray arrayWithCapacity:5];
        for (int index = 0; index < ONCE_REQUEST_COUNT_LIMIT; index ++) {
            TDSPhotoView *photoView = [[TDSPhotoView alloc] initWithImageURL:[NSURL URLWithString:@"http://img1.douban.com/view/photo/photo/public/p939471942.jpg"]];
            [photoArray addObject:photoView];
            [photoView release];
        }
        NSRange range;
        range.location = 0;
        range.length = ONCE_REQUEST_COUNT_LIMIT;
        for (unsigned i = 0; i < ONCE_REQUEST_COUNT_LIMIT; i++) {
            [self.photoViews insertObject:[NSNull null] atIndex:0];
        }
        [[self photoSource] insertPhotos:photoArray inRange:range];
        
        [self setupScrollViewContentSize];
        
        [self moveToPhotoAtIndex:(index+ONCE_REQUEST_COUNT_LIMIT) animated:NO];
        return;
    }
    // 无限后滚逻辑
    // 在最后2个内的时候重新请求
	else if (index + 1 >= [self.photoSource numberOfPhotos]-1) {
        // TODO: 请求新数据
        // 《记得加锁哟，亲》添加测试数据
        @synchronized(self){
            // load photoSource first
            [[self photoSource] addLoadingPhotosOfCount:ONCE_REQUEST_COUNT_LIMIT];
            for (unsigned i = 0; i < ONCE_REQUEST_COUNT_LIMIT; i++) {
                [self.photoViews addObject:[NSNull null]];
            }
            [self setupScrollViewContentSize];
            // send request
            [self photosLoadMore:YES ofSize:(++_requestPage)*ONCE_REQUEST_COUNT_LIMIT];
        }
	} 
    
    [self loadScrollViewWithPage:index-1];
	[self loadScrollViewWithPage:index];
	[self loadScrollViewWithPage:index+1];
}

#pragma mark - Private Function
- (TDSNetControlCenter*)photoViewNetControlCenter{
    if (!_photoViewNetControlCenter) {
        _photoViewNetControlCenter = [[TDSNetControlCenter alloc] init];
        _photoViewNetControlCenter.delegate = self;
    }
    return _photoViewNetControlCenter;
}
- (void)photosRequest:(int)type {
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
//    if (more) {
//        [query setObject:[NSNumber numberWithInt:index] forKey:@"start"];
//    }else{
        [query setObject:@"0" forKey:@"start"];
//    }
    TDSRequestObject *requestObject = [TDSRequestObject requestObjectForQuery:query];
    [self.photoViewNetControlCenter sendRequestWithObject:requestObject];
}
- (void)photosLoadMore:(BOOL)more ofSize:(NSInteger)index{

    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    if (more) {
        [query setObject:[NSNumber numberWithInt:index] forKey:@"start"];
    }else{
        [query setObject:@"0" forKey:@"start"];
    }
    TDSRequestObject *requestObject = [TDSRequestObject requestObjectForQuery:query];
    [self.photoViewNetControlCenter sendRequestWithObject:requestObject];
}

#pragma mark - TDSNetControlCenterDelegate

- (void)tdsNetControlCenter:(TDSNetControlCenter*)netControlCenter requestDidStartRequest:(id)response{
    TDSLOG_debug(@"start request" );    
}
- (void)tdsNetControlCenter:(TDSNetControlCenter*)netControlCenter requestDidFinishedLoad:(id)response{
    TDSLOG_debug(@"result :%@",response );
    if ([response isKindOfClass:[TDSResponseObject class]]) {
        TDSResponseObject *responseObject = (TDSResponseObject *)response;
        
        NSMutableDictionary *responseDic = (NSMutableDictionary*)responseObject.rootObject;
        NSMutableArray *photoArray = [NSMutableArray arrayWithCapacity:[responseDic.allKeys count]];
        for (id key in responseDic.allKeys) {
            NSDictionary *infoDic = [responseDic objectForKey:key];
            TDSPhotoViewItem *photoItem = [TDSPhotoViewItem objectWithDictionary:infoDic];
            photoItem.kWeiboID = (NSString*)key;
            TDSPhotoView *photoView = [TDSPhotoView photoWithItem:photoItem];
            [photoArray addObject:photoView];
            TDSLOG_info(@"key:[%@] \n[%@] \n[%@]",photoItem.kWeiboID,
                         photoItem.picUrlText,
                         photoItem.describeText);
        }
        // reset photos
        NSRange range ;
        // 要加上前滚的页数
        range.location = (_requestPage+_requestForwardPageCount)*ONCE_REQUEST_COUNT_LIMIT;
        range.length = ONCE_REQUEST_COUNT_LIMIT;
        NSLog(@" ### range:(%d,%d)",range.location,range.length);
        [[self photoSource] setPhotos:photoArray inRange:range];
        // 如果当前页面得到数据了，则刷新下显示
        if (_pageIndex>=range.location && _pageIndex<=(range.location+range.length)) {
            [self loadScrollViewWithPage:_pageIndex-1];                        
            [self loadScrollViewWithPage:_pageIndex];            
            [self loadScrollViewWithPage:_pageIndex+1];            
        }
    }
}

- (void)tdsNetControlCenter:(TDSNetControlCenter*)netControlCenter requestDidFailedLoad:(id)response{
    TDSLOG_debug(@" ## controller load failed:%@", response);
}

@end
