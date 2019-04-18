//
//  UIView+CXExtension.h
//  CXCamera
//
//  Created by c_xie on 16/3/28.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIView (Extension)

@property IBInspectable CGFloat borderWidth;
@property IBInspectable UIColor *borderColor;
@property IBInspectable CGFloat cornerRadius;
@property IBInspectable BOOL masksToBounds;

@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;

@property (nonatomic,assign) CGFloat left;
@property (nonatomic,assign) CGFloat right;
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,assign) CGFloat bottom;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGPoint origin;
@property (nonatomic,assign) CGPoint cx_center;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGSize size;


- (UIViewController *)viewController;
- (UINavigationController *)navigationController;

- (UIImage *)renderImage;

- (UIImage *)renderImageWithSize:(CGSize)size;

- (BOOL)isShowingOnKeyWindow;

+ (instancetype)viewFromXib;

- (BOOL)findSubView:(Class)objClass allSameType:(BOOL)same container:(NSMutableArray*)container;
+ (BOOL)findSubView:(Class)objClass view:(UIView*)v allSameType:(BOOL)same container:(NSMutableArray*)container;

@end
