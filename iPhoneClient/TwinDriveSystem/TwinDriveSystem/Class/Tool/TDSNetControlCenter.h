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
- (void)tdsNetControlCenter:(TDSNetControlCenter*)netControlCenter requestDidStartRequest:(id)response;
- (void)tdsNetControlCenter:(TDSNetControlCenter*)netControlCenter requestDidFinishedLoad:(id)response;
- (void)tdsNetControlCenter:(TDSNetControlCenter*)netControlCenter requestDidFailedLoad:(id)response;
@end

@interface TDSNetControlCenter : NSObject {
    ASINetworkQueue *_operationQueue;
}
@property (nonatomic, retain) ASINetworkQueue *operationQueue;
@property (nonatomic, assign) id<TDSNetControlCenterDelegate> delegate;

/*
 * 发送请求：支持两种数据:NSURL & TDSRequestObject
 */
- (void) sendRequestWithObject:(id)reqObj;

@end
