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

- (void)addLoadingPhotosOfCount:(NSInteger)count;

- (void)addPhotos:(NSArray *)photos inRange:(NSRange)range;

- (void)loadMorePhotos;

@end

