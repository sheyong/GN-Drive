//
//  TDSTabViewController.h
//  TwinDriveSystem
//
//  Created by zhongsheng on 12-2-28.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDSMainScreenTabBar.h"

@interface TDSMainScreenViewController : UIViewController<TDSMainScreenTabBarDelegate, UINavigationControllerDelegate>{
    // 标签栏
    TDSMainScreenTabBar *_tabBar;
    // 标签栏对应的viewController
    NSMutableArray *_viewControllers;
    // 当前显示viewController的索引
    NSInteger _currentViewControllerIndex;
}

// 标签栏
@property (nonatomic, retain) TDSMainScreenTabBar *tabBar;
// 标签栏对应的viewController
@property (nonatomic, retain) NSMutableArray *viewControllers;
// 当前显示的viewController索引
@property (nonatomic, assign) NSInteger currentViewControllerIndex;


@end
