//
//  TDSPhotoHTTPRequest.h
//  TwinDriveSystem
//
//  Created by zhongsheng on 12-2-28.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASINetworkQueue;

@interface TDSNetControlCenter : NSObject {
    ASINetworkQueue *_operationQueue;
}
@property (nonatomic, retain) ASINetworkQueue *operationQueue;

- (void)requestDidStartSelector:(ASIHTTPRequest *)request;
- (void)requestDidFinishSelector:(ASIHTTPRequest *)request;
- (void)requestDidFailSelector:(ASIHTTPRequest *)request;

- (void) sendRequestWithObject:(NSURL*)reqObj;

@end
