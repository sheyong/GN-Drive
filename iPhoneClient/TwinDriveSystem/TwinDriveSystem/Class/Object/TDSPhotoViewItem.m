//
//  TDSPhotoViewItem.m
//  TwinDriveSystem
//
//  Created by 自 己 on 12-3-20.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "TDSPhotoViewItem.h"

@implementation TDSPhotoViewItem
@synthesize kWeiboID = _kWeiboID;
@synthesize describeText = _describeText;
@synthesize picUrlText = _picUrlText;
@synthesize createTime = _createTime;

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

+ (TDSPhotoViewItem *)objectWithDictionary:(NSDictionary *)dictionary{
    TDSPhotoViewItem *photoViewItem = [[TDSPhotoViewItem alloc] initWithDictionary:dictionary]; 
    return [photoViewItem autorelease];
}
@end
