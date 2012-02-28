//
//  TDSConfig.h
//  TwinDriveSystem
//
//  Created by 钟 声 on 12-2-12.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDSConfigDelegate.h"

@interface TDSConfig : NSObject <TDSConfigDelegate>{
    // app id
    NSString *_appId;
    
    /**
     *本应用在appStore的ID
     */
    NSString* _appStoreId;
    
    // Client name.
    NSString *_clientName;
    
    // 3G API URL
    NSString *_mApiUrl;
    
    // Client version.
    NSString *_version;
    
    // Client fromType.
    NSString *_fromType;
    
    // Client fromID.
    NSString *_fromID;
    
    // Device model.
    NSString *_model;
    
    // Client Info.
    NSString *_clientInfoJSONString;
        
    // http请求超时时间
	NSTimeInterval _httpTimeout;
    
}

// singleton
+ (TDSConfig* )getInstance;

/**
 * @return 设备唯一标识。如果UIDevice.uniqueIdentifier不为空，那么返回uniqueIdentifier，否则返回nil
 */
- (NSString *)udid;
// app id
@property (nonatomic, copy) NSString *appId;

// 本应用在appStore的ID
@property (nonatomic, copy) NSString* appStoreId;

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

@property (assign) NSTimeInterval httpTimeout;

@end
