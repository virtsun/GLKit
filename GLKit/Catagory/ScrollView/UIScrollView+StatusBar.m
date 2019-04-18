//
//  UIScrollView+StatusBar.m
//  qualitymarket
//
//  Created by sunlantao on 2019/4/10.
//  Copyright © 2019 sunlantao. All rights reserved.
//

#import "UIScrollView+StatusBar.h"
#import <objc/runtime.h>
#import "NSObject+Observer.h"
#import "UIView+Extension.h"

@implementation UIScrollView(StatusBar)

@dynamic statusBar;

- (void)setStatusBar:(UIView *)statusBar{
    objc_setAssociatedObject(self, "statusBar", statusBar, OBJC_ASSOCIATION_ASSIGN);

    [self addSubview:statusBar];
    
    __weak typeof(self) self_weak_ = self;
    
    GLObserver(self, frame, ^(id newValue){
        [self_weak_ update];
    });
}
- (UIView *)statusBar{
    return objc_getAssociatedObject(self, "statusBar");
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle{
    objc_setAssociatedObject(self, "statusBarType", @(statusBarStyle), OBJC_ASSOCIATION_COPY);
}
- (UIStatusBarStyle)statusBarStyle{
    return [objc_getAssociatedObject(self, "statusBarType") intValue];
}

- (void)setJudgeMaximumHeight:(CGFloat)judgeMaximumHeight{
    objc_setAssociatedObject(self, "judgeMaximumHeight", @(judgeMaximumHeight), OBJC_ASSOCIATION_COPY);
}
- (CGFloat)judgeMaximumHeight{
    return [objc_getAssociatedObject(self, "judgeMaximumHeight") floatValue];
}

- (void)update{

    self.statusBar.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.statusBar.bounds)/2 + self.contentOffset.y);
    if (self.judgeMaximumHeight > 0){
        self.statusBar.alpha = (self.contentOffset.y + self.contentInset.top)/self.judgeMaximumHeight;
    }else{
        self.statusBar.alpha = (self.contentOffset.y + self.contentInset.top)/CGRectGetHeight(self.statusBar.bounds);
    }
    [self bringSubviewToFront:self.statusBar];
    
    if (self.statusBarStyle == UIStatusBarStyleLightContent){
        [self.viewController setNeedsStatusBarAppearanceUpdate];
    }
}

- (UIStatusBarStyle)currentStatusBarStyle{
    return self.statusBar.alpha > .5f?UIStatusBarStyleDefault:self.statusBarStyle;
}

@end