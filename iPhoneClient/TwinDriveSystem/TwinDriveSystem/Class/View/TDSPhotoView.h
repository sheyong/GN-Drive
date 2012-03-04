//
//  TDSPhotoView.h
//  TwinDriveSystem
//
//  Created by 钟 声 on 12-2-12.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TDSResponseObject;
@interface TDSPhotoView : NSObject <EGOPhoto>{
    
    NSURL *_URL;
    NSString *_caption;
    CGSize _size;
    UIImage *_image;
    
    BOOL _failed;
    
}

- (id)initWithResponseObject:(TDSResponseObject*)responseObject;

- (id)initWithImageURL:(NSURL*)aURL name:(NSString*)aName image:(UIImage*)aImage;
- (id)initWithImageURL:(NSURL*)aURL name:(NSString*)aName;
- (id)initWithImageURL:(NSURL*)aURL;
- (id)initWithImage:(UIImage*)aImage;


@end