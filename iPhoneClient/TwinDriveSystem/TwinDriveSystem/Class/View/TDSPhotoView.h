//
//  TDSPhotoView.h
//  TwinDriveSystem
//
//  Created by 钟 声 on 12-2-12.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TDSPhotoViewItem;
@interface TDSPhotoView : NSObject <EGOPhoto>{
    
    NSURL *_URL;
    NSString *_caption;
    CGSize _size;
    UIImage *_image;
    
    BOOL _failed;
    
}
+ (TDSPhotoView*)photoWithItem:(TDSPhotoViewItem*)item;
- (id)initWithPhotoViewItem:(TDSPhotoViewItem*)item;

- (id)initWithImageURL:(NSURL*)aURL name:(NSString*)aName image:(UIImage*)aImage;
- (id)initWithImageURL:(NSURL*)aURL name:(NSString*)aName;
- (id)initWithImageURL:(NSURL*)aURL;
- (id)initWithImage:(UIImage*)aImage;


@end