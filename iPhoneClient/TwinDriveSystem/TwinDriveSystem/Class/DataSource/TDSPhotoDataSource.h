//
//  TDSPhotoDataSource.h
//  TwinDriveSystem
//
//  Created by 钟 声 on 12-2-12.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDSPhotoDataSource : NSObject <EGOPhotoSource>{
	
	NSMutableArray *_photos;
	NSInteger _numberOfPhotos;
    
    NSInteger _page; 
}

- (id)initWithPhotos:(NSMutableArray*)photos;

- (void)addPhotos:(NSArray *)photos;

// 特定位置添加loadingView
- (void)addLoadingPhotosOfCount:(NSInteger)count atIndex:(NSInteger)index;

// 末尾添加loadingView
- (void)addLoadingPhotosOfCount:(NSInteger)count;

- (void)insertPhotos:(NSArray *)photos inRange:(NSRange)range;

- (void)setPhotos:(NSArray *)photos inRange:(NSRange)range;


@end

