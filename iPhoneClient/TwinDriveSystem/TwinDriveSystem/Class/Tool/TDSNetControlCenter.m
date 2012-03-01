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
#import "TDSResponseObject.h"
#import "TDSRequestObject.h"

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
}

- (void)requestDidFinishSelector:(ASIHTTPRequest *)request{
    
    NSMutableDictionary *responseDic = (NSMutableDictionary*)[request.responseString JSONValue];
    TDSResponseObject *responseObject = nil;
    for (id key in responseDic.allKeys) {
        NSDictionary *infoDic = [responseDic objectForKey:key];
        responseObject = [TDSResponseObject objectWithDictionary:infoDic];
        responseObject.kWeiboID = (NSString*)key;
        TDSLOG_info(@" requestDidFinishSelector");
        TDSLOG_debug(@"key:[%@] createTime:[%@] url[%@] text[%@]",responseObject.kWeiboID,
                                                         responseObject.createTime,
                                                         responseObject.picUrlText,
                                                         responseObject.describeText);
    }
    // 回调
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tdsNetControlCenter:requestDidFinishedLoad:)]) {
        [self.delegate tdsNetControlCenter:self requestDidFinishedLoad:responseObject];
    }
}
- (void)requestDidFailSelector:(ASIHTTPRequest *)request{
    TDSLOG_info(@" requestDidFailSelector");    
    TDSLOG_error(@"error:%@",request.responseString);
    TDSResponseObject *responseObject = nil;
    // 回调
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tdsNetControlCenter:requestDidFailedLoad::)]) {
        [self.delegate tdsNetControlCenter:self requestDidFailedLoad:responseObject];
    }
}

@end
