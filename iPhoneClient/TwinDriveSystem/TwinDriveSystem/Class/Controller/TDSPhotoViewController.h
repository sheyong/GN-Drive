//
//  TDSPhotoViewController.h
//  TwinDriveSystem
//
//  Created by 钟 声 on 12-2-12.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "EGOPhotoViewController.h"
#import "TDSNetControlCenter.h"
@class TDSPhotoDataSource;
@interface TDSPhotoViewController : EGOPhotoViewController <TDSNetControlCenterDelegate>{
    TDSNetControlCenter *_photoViewNetControlCenter;
    
    NSInteger _requestPage; // 请求次数
}
- (TDSPhotoDataSource *)photoSource; // 这尼玛为啥会是readOnly，暴露出来
@end
