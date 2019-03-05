//
//  LFTPopView.m
//  Leaflet
//
//  Created by l.t.zero on 2018/8/24.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import "CKPopView.h"
#import "UIApplication+Present.h"

@interface CKPopView()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *contentView;

@end

@implementation CKPopView{
    BOOL isDismissed;
}


+ (instancetype)popView{
    return [[[self class] alloc] initWithFrame:[UIScreen mainScreen].bounds];
}
- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]){
        _popLevel = kCKPopLevelNormal;
        
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:_contentView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.delegate = self;
        
        [self addGestureRecognizer:tap];
        
        [self autoLayout];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    [self autoLayout];
}


- (UIEdgeInsets)contentInsets{
    return UIEdgeInsetsMake(100, 20, 100, 20);
}
- (void)autoLayout{
    _contentView.frame = CGRectMake(self.contentInsets.left,
                                    self.contentInsets.top,
                                    CGRectGetWidth(self.bounds) - self.contentInsets.left - self.contentInsets.right,
                                    CGRectGetHeight(self.bounds) - self.contentInsets.top - self.contentInsets.bottom);
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    CGPoint point = [gestureRecognizer locationInView:self];
    if (CGRectContainsPoint(self.contentView.frame, point)){
        return NO;
    }else{
        return YES;
    }
}

- (void)tap:(UIGestureRecognizer *)gesture{
    [self dismiss];
}

- (void)show{
    switch (_popLevel) {
        case kCKPopLevelNormal:
        {
            [[UIApplication currentViewController].view addSubview:self];

        }
            break;
        case kCKPopLevelWindow:
        {
            [[UIApplication sharedApplication].delegate.window addSubview:self];
        }
            break;
        default:
            break;
    }
    if ([self respondsToSelector:@selector(supportAnimations)] && [self supportAnimations]){
        [self pushAnimation];
    }
}
- (void)dismiss:(BOOL)flag{
    
    if ([self respondsToSelector:@selector(supportAnimations)] && [self supportAnimations]){
        __weak typeof(self) self_weak_ = self;
        [self popAnimation:^{
            [self_weak_ removeFromSuperview];
        }];
    }else{
        [self removeFromSuperview];
    }
}
- (void)dismiss{
    [self dismiss:NO];
}

- (BOOL)supportAnimations{return YES;}
- (void)popAnimation:(void (^)(void))completion{
    if (completion) completion();
}
- (void)pushAnimation{
   
}
@end
