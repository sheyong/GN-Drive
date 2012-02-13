//
//  TDSPhotoModel.h
//  TwinDriveSystem
//
//  Created by 钟 声 on 12-2-12.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import "ASIHTTPRequestConfig.h"

@interface TDSPhotoModel : ASIHTTPRequest <EGOPhotoSource>{
	
	NSMutableArray *_photos;
	NSInteger _numberOfPhotos;
    
}

- (id)initWithPhotos:(NSMutableArray*)photos;

- (void)addPhotos:(NSMutableArray *)photos;

- (void)loadMorePhotos;

@end

