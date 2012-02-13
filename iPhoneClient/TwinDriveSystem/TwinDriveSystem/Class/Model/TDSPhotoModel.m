//
//  TDSPhotoModel.m
//  TwinDriveSystem
//
//  Created by 钟 声 on 12-2-12.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "TDSPhotoModel.h"

@implementation TDSPhotoModel

@synthesize photos=_photos;
@synthesize numberOfPhotos=_numberOfPhotos;

- (void)dealloc{
	
	[_photos release], _photos=nil;
	[super dealloc];
}

- (id)initWithPhotos:(NSMutableArray*)photos{
	
	if (self = [super init]) {
        [self addPhotos:photos];
	}
	
	return self;
    
}

- (id <EGOPhoto>)photoAtIndex:(NSInteger)index{
	
	return [_photos objectAtIndex:index];
	
}

- (void)addPhotos:(NSMutableArray *)photos{
    if (!_photos) {
        _photos = [[NSMutableArray alloc] init];
    }
    [_photos addObjectsFromArray:photos];
    _numberOfPhotos = [_photos count];    
}

- (void)loadMorePhotos{
    if (!_photos) {
        return;
    }
    // TODO:网络层部分
}

@end
