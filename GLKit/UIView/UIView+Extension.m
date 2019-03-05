//
//  UIView+CXExtension.m
//  CXCamera
//
//  Created by c_xie on 16/3/28.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

//Designable Property
- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds= cornerRadius >0;
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setMasksToBounds:(BOOL)masksToBounds
{
    self.layer.masksToBounds = masksToBounds;
}

- (BOOL)masksToBounds
{
    return self.layer.masksToBounds;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}



- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}


- (void)setRight:(CGFloat)right
{
    [self setLeft:right - self.width];
}

- (CGFloat)right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}


- (void)setBottom:(CGFloat)bottom
{
    [self setTop:bottom - self.height];
}

- (CGFloat)bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.bounds.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.bounds.size.height;
}


- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setCx_center:(CGPoint)cx_center
{
    self.center = cx_center;
}

- (CGPoint)cx_center
{
    return CGPointMake(self.width * 0.5, self.height * 0.5);
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.bounds.size;
}

/**
 *  将当前view渲染成image对象
 *
 */
- (UIImage *)renderImage
{
    return [self renderImageWithSize:self.bounds.size];
}

/**
 *  将当前view渲染成指定大小的image对象
 *
 *
 */
- (UIImage *)renderImageWithSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


/**
 *  是否正在当前window上显示
 *
 */
- (BOOL)isShowingOnKeyWindow{
    if (self.isHidden) return NO;
    if (self.alpha < 0.01) return NO;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (self.window != keyWindow) return NO;
    CGRect subviewRect = [keyWindow convertRect:self.frame fromView:self.superview];
    return CGRectIntersectsRect(subviewRect, keyWindow.bounds);
}


/**
 *  从xib加载view通用方法
 *
 */
+ (instancetype)viewFromXib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
    } while (next);
    
    return nil;
}

- (UINavigationController *)navigationController
{
    UIResponder *next = self.nextResponder;
    
    do {
        if ([next isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)next;
        }
        
        next = next.nextResponder;
    } while (next);
    
    return nil;
}
+ (BOOL)findSubView:(Class)objClass view:(UIView*)v allSameType:(BOOL)same container:(NSMutableArray *)container{
    __block BOOL found = nil;
    [v.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:objClass]) {
            found = YES;
            *stop = !same;
            [container addObject:obj];
        }
    }];
    
    if (!found) {
        [v.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            BOOL tmp = [self findSubView:objClass view:obj allSameType:same container:container];
            found = found?YES:tmp;
            *stop = found && !same;
            
        }];
    }
    
    return found;
}

- (BOOL)findSubView:(Class)objClass allSameType:(BOOL)same container:(NSMutableArray*)container{
    return [[self class] findSubView:objClass view:self allSameType:same container:container];
}
@end
