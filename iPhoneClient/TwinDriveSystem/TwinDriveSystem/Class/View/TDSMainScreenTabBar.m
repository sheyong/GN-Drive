//
//  TDSMainScreenTabBar.m
//  TwinDriveSystem
//
//  Created by zhongsheng on 12-2-29.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "TDSMainScreenTabBar.h"
#define EDGE_WIDTH 18

#define DEFAULT_ANIMATION_DURATION 0.2

@interface TDSMainScreenTabBar (Private)
- (void)initializationTabs;
- (void)updateTabs;
- (void)setTabOfIndex:(NSInteger)index selected:(BOOL)selected;
- (void)tapHandle:(UITapGestureRecognizer *)tapRecognizer;
@end

@implementation TDSMainScreenTabBar
@synthesize backgroundView = _bakcgroundView;
@synthesize thumbView = _thumbView;
@synthesize normalTabs = _normalTabs;
@synthesize selectedTabs = _selectedTabs;
@synthesize badgeLabels = _badgeLabels;
@synthesize currentTabIndex = _currentTabIndex;
@synthesize barDelegate = _barDelegate;
@synthesize animationDuration = _animationDuration;
@synthesize selfSize = _selfSize;

- (void)setSkinResView{
    [self removeAllSubviews];
    
    self.backgroundColor = [UIColor clearColor];
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 
                                                                                0.0f, 
                                                                                320.0f, 
                                                                                44.0f)];
    backgroundView.backgroundColor = [UIColor blackColor];
    self.backgroundView = backgroundView;
    [backgroundView release];
    [self addSubview:self.backgroundView];    
    
    UIImageView *thumbView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 
                                                                           0.0f, 
                                                                           100.0f, 
                                                                           44.0f)];
    self.thumbView = thumbView;
    [thumbView release];
    [self addSubview:self.thumbView];
    
    [self initializationTabs];
}

#pragma mark - 
- (void)dealloc{
    
    self.backgroundView = nil;
    self.thumbView = nil;
    self.normalTabs = nil;
    self.selectedTabs = nil;
    self.badgeLabels = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setSkinResView];        
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
        [self addGestureRecognizer:tapRecognizer];
        [tapRecognizer release];
        
        self.animationDuration = DEFAULT_ANIMATION_DURATION;
        _selfSize =  CGSizeMake(320, 48);
        _thumbWidth = self.thumbView.image.size.width;
        _thumbSpace = (_selfSize.width - 2*EDGE_WIDTH - self.normalTabs.count*_thumbWidth)/(self.normalTabs.count - 1);
    }
    return self;
}

- (void)initializationTabs{
    // for change skin
    [self.normalTabs removeAllObjects];
    [self.selectedTabs removeAllObjects];
    
    // initialization normal tabs view
    UIImage *photoViewerImage = [UIImage imageNamed:@"photoViewerImage.png"];
    UIImageView *photoViewerButton = [[UIImageView alloc] initWithImage:photoViewerImage];
    [self.normalTabs addObject:photoViewerButton];
    [photoViewerButton release];
    
    UIImage *collectImage = [UIImage imageNamed:@"collectImage.png"];
    UIImageView *collectButton = [[UIImageView alloc] initWithImage:collectImage];
    [self.normalTabs addObject:collectButton];
    [collectButton release];
    
    UIImage *aboutImage = [UIImage imageNamed:@"aboutImage.png"];
    UIImageView *aboutButton = [[UIImageView alloc] initWithImage:aboutImage];
    [self.normalTabs addObject:aboutButton];
    [aboutButton release];
    
    UIImage *photoViewerImageHL = [UIImage imageNamed:@"photoViewerImage_hl.png"];
    UIImageView *photoViewerHLButton = [[UIImageView alloc] initWithImage:photoViewerImageHL];
    [self.selectedTabs addObject:photoViewerHLButton];
    [photoViewerHLButton release];
    
    UIImage *collectImageHL = [UIImage imageNamed:@"collectImage_hl.png"];
    UIImageView *collectHLButton = [[UIImageView alloc] initWithImage:collectImageHL];
    [self.selectedTabs addObject:collectHLButton];
    [collectHLButton release];
    
    UIImage *aboutImageHL = [UIImage imageNamed:@"aboutImage_hl.png"];
    UIImageView *aboutHLButton = [[UIImageView alloc] initWithImage:aboutImageHL];
    [self.selectedTabs addObject:aboutHLButton];
    [aboutHLButton release];    
    
    for (UIImageView *tab in self.normalTabs) {
        [self addSubview:tab];
    }
    
    for (UIImageView *tab in self.selectedTabs) {
        [self addSubview:tab];
    }
    
    self.currentTabIndex = 0;
}

- (NSMutableArray *)normalTabs{
    if (_normalTabs == nil) {
        _normalTabs = [[NSMutableArray alloc] initWithCapacity:5];
    }
    
    return _normalTabs;
}

- (NSMutableArray *)selectedTabs{
    if (_selectedTabs == nil) {
        _selectedTabs = [[NSMutableArray alloc] initWithCapacity:5];
    }
    
    return _selectedTabs;
}

- (void)layoutSubviews{
    self.backgroundView.frame = CGRectIntegral(CGRectMake((_selfSize.width - self.backgroundView.image.size.width)/2,
                                                          (_selfSize.height - self.backgroundView.image.size.height)/2,
                                                          self.backgroundView.image.size.width,
                                                          self.backgroundView.image.size.height));
    
    
    self.thumbView.frame = CGRectIntegral(CGRectMake(EDGE_WIDTH + self.currentTabIndex * (_thumbSpace + _thumbWidth),
                                                     0,
                                                     _thumbWidth,
                                                     self.thumbView.image.size.height));
    
    for (NSInteger idx = 0; idx < self.normalTabs.count; idx ++) {
        UIImageView *normalTab = [self.normalTabs objectAtIndex:idx];
        UIImageView *selectedTab = [self.selectedTabs objectAtIndex:idx];
        CGRect tabFrame = CGRectIntegral(CGRectMake(EDGE_WIDTH + idx * (_thumbSpace + _thumbWidth) + (_thumbWidth - normalTab.image.size.width)/2,
                                                    (_selfSize.height - normalTab.image.size.height)/2,
                                                    normalTab.image.size.width,
                                                    normalTab.image.size.height));
        normalTab.frame = tabFrame;
        selectedTab.frame = tabFrame;
        
        [self setTabOfIndex:idx selected:(idx == self.currentTabIndex)];
        
    }
}


- (void)updateTabs{
    for (NSInteger idx = 0; idx < self.normalTabs.count; idx ++) {
        [self setTabOfIndex:idx selected:(idx == self.currentTabIndex)];
    }
}


- (void)setTabOfIndex:(NSInteger)index selected:(BOOL)selected{
    UIView *normalTab = [self.normalTabs objectAtIndex:index];
    UIView *selectTab = [self.selectedTabs objectAtIndex:index];
    
    if (selected) {
        normalTab.alpha = 0.0;
        selectTab.alpha = 1.0;
    }
    else{
        normalTab.alpha = 1.0;
        selectTab.alpha = 0.0;
    }
}

- (void)setSelectTabIndex:(NSInteger)index animated:(BOOL)animated{    
    
    CGFloat currentThumbShouldX = EDGE_WIDTH + self.currentTabIndex * (_thumbSpace + _thumbWidth);
    
    if (index == self.currentTabIndex && CGRectGetMinX(self.thumbView.frame) == currentThumbShouldX) {
        // 选中项等于当前项有两种情况：1.重复点击；2.未拉倒位置回退的情况;     
        // 情况1改成不动画了，情况2处理动画        
        //        return;
        animated = NO;
    }
    
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:self.animationDuration];
        //        [UIView setAnimationDelegate:self];
        //        [UIView setAnimationDidStopSelector:@selector(selectEnded:finished:context:)];
    }
    
    self.currentTabIndex = index;
    
    if (animated) {
        self.thumbView.frame = CGRectIntegral(CGRectMake(EDGE_WIDTH + self.currentTabIndex * (_thumbSpace + _thumbWidth),
                                                         0,
                                                         _thumbWidth,
                                                         self.thumbView.image.size.height));
        [self updateTabs];
        
        [UIView commitAnimations];
    }
    else{
        [self setNeedsLayout];
    }
    
    if (self.barDelegate != nil) {
        [self.barDelegate mainScreenTabBar:self didSelectIndex:index animated:FALSE];
    }
    
}



#pragma mark -  手势处理
- (void)tapHandle:(UITapGestureRecognizer *)tapRecognizer{
    if (tapRecognizer.state != UIGestureRecognizerStateRecognized) {
        return;
    }
    
    CGPoint location = [tapRecognizer locationInView:self];
    
    NSInteger selectIdx = self.currentTabIndex;
    
    for (NSInteger idx = 0; idx < self.normalTabs.count; idx ++) {
        CGRect idxThumbFrame = CGRectMake(EDGE_WIDTH + idx * (_thumbSpace + _thumbWidth) - 15,
                                          0,
                                          _thumbWidth + 15*2,
                                          self.thumbView.image.size.height);
        if (CGRectContainsPoint(idxThumbFrame, location)) {
            selectIdx = idx;
            break;
        }
    }
    
    [self setSelectTabIndex:selectIdx animated:YES];
}

@end
