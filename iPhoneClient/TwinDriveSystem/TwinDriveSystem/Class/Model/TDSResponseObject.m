//
//  TDSResponseObject.m
//  TwinDriveSystem
//
//  Created by zhongsheng on 12-2-28.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "TDSResponseObject.h"

@implementation TDSResponseObject

@synthesize error = _error;
@synthesize rootObject = _rootObject;
@synthesize responseString = _responseString;

- (void)dealloc{    
    self.error = nil;
    self.rootObject = nil;
    self.responseString = nil;
    [super dealloc];
}
+ (TDSResponseObject *)response{
    TDSResponseObject *responseObject = [[TDSResponseObject alloc]init];
    return [responseObject autorelease];
}
- (id)init{
    self = [super init];
    if (self) {
        self.error = nil;
        self.rootObject = nil;
        self.responseString = nil;
    }
    return self;
}
@end
