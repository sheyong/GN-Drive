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
    
    NSInteger _requestPage; // 请求页面
    NSInteger _requestPrePageCount; // 向前请求page计数
    
    // TODO:持久化数据
    // 暂作为临时变量觉醒
    NSInteger _startPage;   // 开始页面，这个要做本地持久化
    NSInteger _startIndex;  // 配合显示历史页面
}
@property (nonatomic, retain)TDSNetControlCenter *photoViewNetControlCenter;
- (TDSPhotoDataSource *)photoSource; // 这尼玛为啥会是readOnly，暴露出来

@end
