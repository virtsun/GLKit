//
//  UIBlockButton.h
//  Moline
//
//  Created by sunlantao on 2019/4/2.
//  Copyright © 2019 sunlantao. All rights reserved.
//

#import <UIKit/UIKit.h>


/*提供自动扩大点击区域的按钮及block点击事件*/
@interface UIBlockButton : UIButton

@property (nonatomic, strong) UILabel *badgeLabel;

@property (nonatomic, copy) void (^block)(void);

@property (nonatomic, assign) NSUInteger badge;

@end
