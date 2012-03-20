//
//  TDSPhotoViewItem.m
//  TwinDriveSystem
//
//  Created by 自 己 on 12-3-20.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "TDSPhotoViewItem.h"

@implementation TDSPhotoViewItem
@synthesize pid = _pid;
@synthesize photoUrl = _photoUrl;
@synthesize caption = _caption;

- (id)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.pid = [dictionary objectForKey:@"id"];        
        self.photoUrl = [dictionary objectForKey:@"url"];
        self.caption = [dictionary objectForKey:@"text"];
    }
    return self;
}

+ (TDSPhotoViewItem *)objectWithDictionary:(NSDictionary *)dictionary{
    TDSPhotoViewItem *photoViewItem = [[TDSPhotoViewItem alloc] initWithDictionary:dictionary]; 
    return [photoViewItem autorelease];
}
@end
