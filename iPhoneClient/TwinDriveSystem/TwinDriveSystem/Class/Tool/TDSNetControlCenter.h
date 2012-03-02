//
//  TDSPhotoHTTPRequest.h
//  TwinDriveSystem
//
//  Created by zhongsheng on 12-2-28.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASINetworkQueue;
@class TDSNetControlCenter;
@class TDSResponseObject;

@protocol TDSNetControlCenterDelegate <NSObject>
- (void)tdsNetControlCenter:(TDSNetControlCenter*)netControlCenter requestDidFinishedLoad:(TDSResponseObject*)responseObject;
- (void)tdsNetControlCenter:(TDSNetControlCenter*)netControlCenter requestDidFailedLoad:(TDSResponseObject*)responseObject;
@end

@interface TDSNetControlCenter : NSObject {
    ASINetworkQueue *_operationQueue;
}
@property (nonatomic, retain) ASINetworkQueue *operationQueue;
@property (nonatomic, assign) id<TDSNetControlCenterDelegate> delegate;

- (void)requestDidStartSelector:(ASIHTTPRequest *)request;
- (void)requestDidFinishSelector:(ASIHTTPRequest *)request;
- (void)requestDidFailSelector:(ASIHTTPRequest *)request;

/*
 * 发送请求：支持两种数据:NSURL & TDSRequestObject
 */
- (void) sendRequestWithObject:(id)reqObj;

@end
