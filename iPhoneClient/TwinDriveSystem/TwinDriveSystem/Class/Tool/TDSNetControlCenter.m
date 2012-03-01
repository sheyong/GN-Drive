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

@implementation TDSNetControlCenter
@synthesize operationQueue = _operationQueue;

- (void)dealloc{
    
    NSArray * array = _operationQueue.operations;
    for (ASIHTTPRequest* op in array) {
        [op setDelegate:nil];
    }
    [self.operationQueue reset];
    self.operationQueue = nil;
    
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

- (void) sendRequestWithObject:(NSURL*)reqObj{
    NSLog(@"%@",reqObj);
    TDSConfig *config = [TDSConfig getInstance];
    
    ASIHTTPRequest *AsiRequest = [ASIHTTPRequest requestWithURL:reqObj];
    [AsiRequest setDelegate:self];
    [AsiRequest setDidStartSelector:@selector(requestDidStartSelector:)];    
    [AsiRequest setDidFailSelector:@selector(requestDidFailSelector:)];
    [AsiRequest setDidFinishSelector:@selector(requestDidFinishSelector:)];    
    [AsiRequest setTimeOutSeconds:config.httpTimeout];
    [AsiRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [AsiRequest setCachePolicy:NSURLRequestReloadIgnoringCacheData];
//    [AsiRequest setUserInfo:[NSDictionary dictionaryWithObject:reqObj forKey:@"reqObject"]];
    
    [self.operationQueue addOperation:AsiRequest];     
    [self.operationQueue go];
}

- (void)requestDidStartSelector:(ASIHTTPRequest *)request{
}

- (void)requestDidFinishSelector:(ASIHTTPRequest *)request{
    
    NSMutableDictionary *responseDic = (NSMutableDictionary*)[request.responseString JSONValue];
    for (id key in responseDic.allKeys) {
        NSDictionary *infoDic = [responseDic objectForKey:key];
//        NSLog(@"[%@]:%@",key,infoDic);
        TDSResponseObject *infoObject = [TDSResponseObject objectWithDictionary:infoDic];
        infoObject.kWeiboID = (NSString*)key;
        NSLog(@"key:[%@] id:[%@] createTime[%@] pic[%@]",infoObject.kWeiboID,
                                                         infoObject.createTime,
                                                         infoObject.picUrlText,
                                                         infoObject.describeText);
    }
    
}
- (void)requestDidFailSelector:(ASIHTTPRequest *)request{
    NSLog(@"error:%@",request.responseString);
}

@end
