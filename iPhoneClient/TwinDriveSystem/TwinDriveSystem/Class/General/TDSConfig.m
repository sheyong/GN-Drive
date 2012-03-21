//
//  TDSConfig.m
//  TwinDriveSystem
//
//  Created by 钟 声 on 12-2-12.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "TDSConfig.h"

static TDSConfig *_globalConfig = nil;

@implementation TDSConfig

@synthesize mApiUrl = _mApiUrl;
@synthesize clientName = _clientName;
@synthesize version = _version;
@synthesize fromType = _fromType;
@synthesize fromID = _fromID;
@synthesize model = _model;
@synthesize clientInfoJSONString = _clientInfoJSONString;
@synthesize httpTimeout = _httpTimeout;
@synthesize appId = _appId;
@synthesize appStoreId = _appStoreId;

- (void)dealloc
{
    self.appId = nil;
    self.appStoreId = nil;
    self.mApiUrl = nil;
    self.clientName = nil;
    self.version = nil;
    self.fromType = nil;
    self.fromID = nil;
    self.model = nil;
    [_clientInfoJSONString release];    
    
    [super dealloc];
}

- (id)init {
    self = [super init]; 
    if (self) {
        
//        self.mApiUrl = @"http://ofshellohicy.sinaapp.com/api_photo.php";//?start=0
        self.mApiUrl = @"http://morelife.sinaapp.com";
        //应用在appStore的ID
        self.appStoreId = @"1010101";
        // App ID
        self.appId = @"100000";     // 1.0.0
        
        self.fromType = @"9100301";
        self.fromID = self.fromType;
        
        self.version = @"1";        // 版本号
        self.clientName = @"TwinDriveSystem";
        self.model = @"iPhone";
        
        self.httpTimeout = 45.0f;
        
    }
    return self;
}

- (NSString *)udid {
    UIDevice *device = [UIDevice currentDevice];
    NSString *udid = [[device macAddress] MD5String];
    
    return udid;
}
- (NSString *)userAgent {
    return [NSString stringWithFormat:@"%@%@", self.clientName, self.version];
}
- (NSString *)clientInfoJSONString {
    UIDevice *device = [UIDevice currentDevice];
	if([device.model hasPrefix:@"iPad"])
    {
        return [NSString stringWithFormat:@"{\"model\":\"%@\", \"os\":\"%@%@\", \"uniqid\":\"%@\", \"screen\":\"768x1024\", \"font\":\"system 12\", \"ua\":\"%@\", \"from\":\"%@\", \"version\":\"%@\"}",
                device.model, device.systemName, device.systemVersion, [self udid], [self userAgent], self.fromID, self.version];
    }
	return [NSString stringWithFormat:@"{\"model\":\"%@\", \"os\":\"%@%@\", \"uniqid\":\"%@\", \"screen\":\"320x480\", \"font\":\"system 12\", \"ua\":\"%@%@\", \"from\":\"%@\", \"version\":\"%@\"}",
			device.model, device.systemName, device.systemVersion, [self udid], self.clientName, self.version, self.fromID, self.version];
    
}

#pragma mark - Singleton
+ (TDSConfig*)getInstance{
    @synchronized(self) { // 防止同步问题
		if (_globalConfig == nil) {
            [[TDSConfig alloc] init];
		}
	}
	return _globalConfig; 
}

+ (id) allocWithZone:(NSZone*) zone {
	@synchronized(self) { 
		if (_globalConfig == nil) {
			_globalConfig = [super allocWithZone:zone];  // assignment and return on first allocation
			return _globalConfig;
		}
	}
	return nil;
}

- (id) copyWithZone:(NSZone*) zone {
	return _globalConfig;
}

- (id) retain {
	return _globalConfig;
}

- (unsigned) retainCount {
	return UINT_MAX;  //denotes an object that cannot be released
}

- (id) autorelease {
	return self;
}

@end
