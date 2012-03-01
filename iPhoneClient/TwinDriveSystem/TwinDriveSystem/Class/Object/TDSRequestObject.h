//
//  TDSRequestObject.h
//  TwinDriveSystem
//
//  Created by zhongsheng on 12-3-1.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDSRequestObject : NSObject{
    NSMutableDictionary *_parametersDic;
}

@property (nonatomic, retain) NSURL *URL;
@property (nonatomic, retain) NSMutableDictionary *parametersDic;

+ (id)requestObjectForQuery:(NSMutableDictionary*)query;
@end
