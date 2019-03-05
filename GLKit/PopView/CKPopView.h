//
//  LFTPopView.h
//  Leaflet
//
//  Created by l.t.zero on 2018/8/24.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CKPopLevel){
    kCKPopLevelNormal,//基于当前controller弹出
    kCKPopLevelWindow//基于当前window弹出
};

@protocol CKPopViewLayout<NSObject>

@required
/**
 *容器的上下左右间距
 **/
- (UIEdgeInsets)contentInsets;

@end

@protocol CKPopViewAnimation<NSObject>

@optional
- (BOOL)supportAnimations;
- (void)popAnimation:(void (^)(void))completion;
- (void)pushAnimation;

@end

@interface CKPopView : UIView<CKPopViewLayout, CKPopViewAnimation>

@property (nonatomic, assign) CKPopLevel popLevel;
@property (nonatomic, readonly) UIView *contentView;

+ (instancetype)popView;

- (void)autoLayout;

- (void)show;
- (void)dismiss:(BOOL)flag;//YES:表示主动 NO:表示自动
- (void)dismiss;

@end
