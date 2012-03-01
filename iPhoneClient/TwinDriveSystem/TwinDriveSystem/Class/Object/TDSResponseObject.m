//
//  TDSResponseObject.m
//  TwinDriveSystem
//
//  Created by zhongsheng on 12-2-28.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "TDSResponseObject.h"

@implementation TDSResponseObject

@synthesize kWeiboID = _kWeiboID;
@synthesize describeText = _describeText;
@synthesize picUrlText = _picUrlText;
@synthesize createTime = _createTime;
@synthesize error = _error;

- (void)dealloc{
    self.kWeiboID = nil;
    self.createTime = nil;    
    self.picUrlText = nil;    
    self.describeText = nil;
    self.error = nil;
    [super dealloc];
}

- (id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        NSString *createTimeStr = [dictionary objectForKey:@"create_time"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//2011-11-08 23:50:15
        NSDate *dateFromString = [dateFormatter dateFromString:createTimeStr];
        self.createTime = dateFromString;
        
        self.picUrlText = [dictionary objectForKey:@"pic"];
        self.describeText = [dictionary objectForKey:@"text"];
    }
    return self;
}

+ (TDSResponseObject *)objectWithDictionary:(NSDictionary *)dictionary{
    TDSResponseObject *requestObject = [[TDSResponseObject alloc] initWithDictionary:dictionary]; 
    return [requestObject autorelease];
}

@end
