//
//  UIScrollView+StatusBar.h
//  qualitymarket
//
//  Created by sunlantao on 2019/4/10.
//  Copyright © 2019 sunlantao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, UIScrollViewStatusBarMode){
    UIScrollViewStatusBarModeAlpha,//透明度渐变
    UIScrollViewStatusBarModeColor//背景色渐变
};

@interface UIScrollView(StatusBar)

@property (nonatomic, weak) UIView *statusBar;
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;//默认状态栏
@property (nonatomic, assign) CGFloat judgeMaximumHeight;//默认状态栏
@property (nonatomic, assign) UIScrollViewStatusBarMode barMode;//默认状态栏

- (UIStatusBarStyle)currentStatusBarStyle;

@end

NS_ASSUME_NONNULL_END
