//
//  TDSPhotoHTTPRequest.m
//  TwinDriveSystem
//
//  Created by zhongsheng on 12-2-28.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "TDSNetControlCenter.h"
#import "ASINetworkQueue.h"
#import "TDSResponseObject.h"
#import "ASIFormDataRequest.h"
#import "TDSRequestObject.h"
#import "TDSPhotoViewItem.h"


#define RETRY_TIMES 3

@interface TDSNetControlCenter (Private)
- (void)requestDidStartSelector:(ASIHTTPRequest *)request;
- (void)requestDidFinishSelector:(ASIHTTPRequest *)request;
- (void)requestDidFailSelector:(ASIHTTPRequest *)request;

@end
@implementation TDSNetControlCenter
@synthesize operationQueue = _operationQueue;
@synthesize delegate;
- (void)dealloc{
    
    NSArray * array = _operationQueue.operations;
    for (ASIHTTPRequest* op in array) {
        [op setDelegate:nil];
    }
    [self.operationQueue reset];
    self.operationQueue = nil;
    self.delegate = nil;
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self) {
        _operationQueue = [[ASINetworkQueue alloc] init];
    }
    return self;
}
- (void)notifyWithNewMessage:(id)message {
    
}

- (void) sendRequestWithObject:(id)reqObj{
    TDSLOG_info(@"sendRequestWithObject %@",reqObj);
    if (reqObj == nil) {
        return;
    }
    
    TDSConfig *config = [TDSConfig getInstance];
    
    ASIHTTPRequest *asiRequest = nil;
    
    if ([reqObj isKindOfClass:[NSURL class]]) {
        asiRequest = [ASIHTTPRequest requestWithURL:reqObj];
    }else if ([reqObj isKindOfClass:[TDSRequestObject class]]){
        TDSRequestObject *requestObject = (TDSRequestObject*)reqObj;
        asiRequest = [ASIHTTPRequest requestWithURL:requestObject.URL];
    }
    if (asiRequest != nil) {
        [asiRequest setDelegate:self];
        [asiRequest setDidStartSelector:@selector(requestDidStartSelector:)];    
        [asiRequest setDidFailSelector:@selector(requestDidFailSelector:)];
        [asiRequest setDidFinishSelector:@selector(requestDidFinishSelector:)];    
        [asiRequest setTimeOutSeconds:config.httpTimeout];
        [asiRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [asiRequest setCachePolicy:NSURLRequestReloadIgnoringCacheData];
        [asiRequest setNumberOfTimesToRetryOnTimeout:RETRY_TIMES];
        [self.operationQueue addOperation:asiRequest];     

    }
    // 锁定操作队列执行
    @synchronized(self.operationQueue){
        if (self.operationQueue.isSuspended) {   
            [self.operationQueue go];
        }
    }
}

- (void)requestDidStartSelector:(ASIHTTPRequest *)request{
    TDSLOG_info(@" requestDidStartSelector");
    // 回调
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tdsNetControlCenter:requestDidFinishedLoad:)]) {
        [self.delegate tdsNetControlCenter:self requestDidStartRequest:nil];
    }
}

- (void)requestDidFinishSelector:(ASIHTTPRequest *)request{
    TDSLOG_info(@" requestDidFinishSelector");
    TDSResponseObject *responseObject = [TDSResponseObject response];
    // json 格式
    responseObject.rootObject = [request.responseString JSONValue];
    // 回调
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tdsNetControlCenter:requestDidFinishedLoad:)]) {
        [self.delegate tdsNetControlCenter:self requestDidFinishedLoad:responseObject];
    }
}
- (void)requestDidFailSelector:(ASIHTTPRequest *)request{
    TDSLOG_info(@" requestDidFailSelector");    
    TDSLOG_error(@"error:%@",request.responseString);
    TDSResponseObject *responseObject = [TDSResponseObject response];
    responseObject.error = request.error;
    // 回调
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tdsNetControlCenter:requestDidFailedLoad:)]) {
        [self.delegate tdsNetControlCenter:self requestDidFailedLoad:responseObject];
    }    
    return;
}

@end
