//
//  TDSPhotoView.m
//  TwinDriveSystem
//
//  Created by 钟 声 on 12-2-12.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "TDSPhotoView.h"
#import "TDSPhotoViewItem.h"

@implementation TDSPhotoView

@synthesize URL=_URL;
@synthesize caption=_caption;
@synthesize image=_image;
@synthesize size=_size;
@synthesize failed=_failed;

- (void)dealloc{
    
	[_URL release], _URL=nil;
	[_image release], _image=nil;
	[_caption release], _caption=nil;
	
	[super dealloc];
}
+ (TDSPhotoView*)photoWithItem:(TDSPhotoViewItem*)item{
    TDSPhotoView *photoView = [[TDSPhotoView alloc] initWithPhotoViewItem:item]; 
    return [photoView autorelease];
}
- (id)initWithPhotoViewItem:(TDSPhotoViewItem*)item{
    if (self = [super init]) {
        
		_URL=[[NSURL URLWithString:item.photoUrl] retain];
		_caption=[item.caption retain];
		
	}
	
	return self;
}
- (id)initWithImageURL:(NSURL*)aURL name:(NSString*)aName image:(UIImage*)aImage{
	
	if (self = [super init]) {
        
		_URL=[aURL retain];
		_caption=[aName retain];
		_image=[aImage retain];
		
	}
	
	return self;
}

- (id)initWithImageURL:(NSURL*)aURL name:(NSString*)aName{
	return [self initWithImageURL:aURL name:aName image:nil];
}

- (id)initWithImageURL:(NSURL*)aURL{
	return [self initWithImageURL:aURL name:nil image:nil];
}

- (id)initWithImage:(UIImage*)aImage{
	return [self initWithImageURL:nil name:nil image:aImage];
}


@end
