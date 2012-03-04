//
//  TDSPhotoDataSource.m
//  TwinDriveSystem
//
//  Created by 钟 声 on 12-2-12.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "TDSPhotoDataSource.h"
#import "TDSPhotoView.h"

@implementation TDSPhotoDataSource

@synthesize photos=_photos;
@synthesize numberOfPhotos=_numberOfPhotos;

- (void)dealloc{
	
	[_photos release], _photos=nil;
	[super dealloc];
}

- (id)init{
    self = [super init];
    if (self) {
        //TODO:
    }
    return self;
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

- (void)addPhotos:(NSArray *)photos{
    if (!_photos) {
        _photos = [[NSMutableArray alloc] init];
    }
    [_photos addObjectsFromArray:photos];
    _numberOfPhotos = [_photos count];    
}
- (void)addLoadingPhotosOfCount:(NSInteger)count{
    if (!_photos) {
        _photos = [[NSMutableArray alloc] init];
    }
    for (int index = 0; index < count; index++) {
        // add lazily
        [_photos addObject: [[[TDSPhotoView alloc] init] autorelease] ];
    }
    _numberOfPhotos = [_photos count];    
}
- (void)addPhotos:(NSArray *)photos inRange:(NSRange)range{
    if (!_photos) {
        _photos = [[NSMutableArray alloc] init];
    }
    // 如果量不足现在拥有的，则直接添加
    // 否则替换<>
    if ([_photos count] < (range.location+range.length)) {
        [self addPhotos:photos];
    }else{
        [_photos replaceObjectsInRange:range withObjectsFromArray:photos];
    }
}
- (void)loadMorePhotos{
    if (!_photos) {
        return;
    }
    // TODO:网络层部分

}

@end
