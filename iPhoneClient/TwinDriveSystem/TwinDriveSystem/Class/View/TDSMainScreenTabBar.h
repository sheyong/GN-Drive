//
//  TDSMainScreenTabBar.h
//  TwinDriveSystem
//
//  Created by zhongsheng on 12-2-29.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TDSMainScreenTabBar;

@protocol TDSMainScreenTabBarDelegate <NSObject>
- (void)mainScreenTabBar:(TDSMainScreenTabBar *)tabBar didSelectIndex:(NSInteger)index animated:(BOOL)animated;
@end

@interface TDSMainScreenTabBar : UIView <UIGestureRecognizerDelegate> {
    UIImageView *_bakcgroundView;
    UIImageView *_thumbView;
    NSMutableArray *_normalTabs;
    NSMutableArray *_selectedTabs;
    NSMutableArray *_badgeLabels;
    NSInteger _currentTabIndex;
    id<TDSMainScreenTabBarDelegate> _barDelegate;
    CGFloat _animationDuration;
    CGSize _selfSize;
    // 滑块宽度
    CGFloat _thumbWidth;
    // 各位置间的滑块距离
    CGFloat _thumbSpace;
}

- (void)setBadgeOfIndex:(NSInteger)index content:(NSString *)content;
- (void)setSelectTabIndex:(NSInteger)index animated:(BOOL)animated;

@property (nonatomic) CGSize selfSize;
@property (nonatomic, retain) UIImageView *backgroundView;
@property (nonatomic, retain) UIImageView *thumbView;
@property (nonatomic, retain) NSMutableArray *normalTabs;
@property (nonatomic, retain) NSMutableArray *selectedTabs;
@property (nonatomic, retain) NSMutableArray *badgeLabels;
@property (nonatomic, assign) NSInteger currentTabIndex;
@property (nonatomic, assign) id<TDSMainScreenTabBarDelegate> barDelegate;
@property (nonatomic, assign) CGFloat animationDuration;

@end

