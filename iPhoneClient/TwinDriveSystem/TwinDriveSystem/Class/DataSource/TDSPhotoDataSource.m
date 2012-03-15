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
- (void)addLoadingPhotosOfCount:(NSInteger)count atIndex:(NSInteger)index{
    if (!_photos) {
        _photos = [[NSMutableArray alloc] init];
    }
    // 容错
    if (index < 0) {
        index = 0;
    }
    else if (index > [_photos count] && [_photos count]>0) {
        index = [_photos count];
    }
    
    for (int i = index; i < index+count; i++) {
        // add lazily
        [_photos insertObject:[[[TDSPhotoView alloc] init] autorelease] atIndex:i];
    }
    _numberOfPhotos = [_photos count];    
}
- (void)addLoadingPhotosOfCount:(NSInteger)count{
    if (!_photos) {
        _photos = [[NSMutableArray alloc] init];
    }
    NSInteger lastIndex = [_photos count];
    [self addLoadingPhotosOfCount:count atIndex:lastIndex];
}
- (void)setPhotos:(NSArray *)photos inRange:(NSRange)range{
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
    _numberOfPhotos = [_photos count];    
}
- (void)insertPhotos:(NSArray *)photos inRange:(NSRange)range{
    if (!_photos) {
        _photos = [[NSMutableArray alloc] init];
    }
    // 如果量不足现在拥有的，则直接添加
    // 否则替换<>
    if ([_photos count] < (range.location+range.length)) {
        [self addPhotos:photos];
    }else{
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [_photos insertObjects:photos atIndexes:indexSet];
    }
    _numberOfPhotos = [_photos count];
}
- (void)loadMorePhotos{
    if (!_photos) {
        return;
    }
    // TODO:网络层部分

}

@end
