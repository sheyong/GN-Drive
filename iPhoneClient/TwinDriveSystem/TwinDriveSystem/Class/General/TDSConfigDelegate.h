//
//  TDSConfigDelegate.h
//  TwinDriveSystem
//
//  Created by 钟 声 on 12-2-12.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TDSConfigDelegate <NSObject>

// 3G API URL
@property (nonatomic, copy) NSString *mApiUrl;

// Client name.
@property (nonatomic, copy) NSString *clientName;

// Client version.
@property (nonatomic, copy) NSString *version;

// Client fromType.
@property (nonatomic, copy) NSString *fromType;

// Client fromID.
@property (nonatomic, copy) NSString *fromID;

// Device model.
@property (nonatomic, copy) NSString *model;

// Client Info.
@property (nonatomic, readonly) NSString *clientInfoJSONString;


@end
