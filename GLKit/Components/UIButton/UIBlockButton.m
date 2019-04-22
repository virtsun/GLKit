//
//  UIBlockButton.m
//  Moline
//
//  Created by sunlantao on 2019/4/2.
//  Copyright © 2019 sunlantao. All rights reserved.
//

#import "UIBlockButton.h"

@implementation UIBlockButton

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]){
        
        _badgeLabel = [[UILabel alloc] init];
        
        _badgeLabel.frame = CGRectMake(0, 0, 13, 13);
        _badgeLabel.backgroundColor = [UIColor whiteColor];
        _badgeLabel.layer.cornerRadius = 13.f/2;
        _badgeLabel.clipsToBounds = YES;
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.hidden = YES;
        //    _badgeLabel.text = @"99";
        _badgeLabel.textColor = [UIColor blackColor];
        _badgeLabel.font = [UIFont systemFontOfSize:8];
        
        [self addSubview:_badgeLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _badgeLabel.center = (CGPoint){CGRectGetWidth(self.bounds) * 9/10, CGRectGetHeight(self.bounds)/10};
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if(CGRectContainsPoint(self.bounds, point))
        return self;
    else{
        if (fabs(point.x - CGRectGetMidX(self.bounds)) <= 25
            &&fabs(point.y - CGRectGetMidY(self.bounds)) <= 20){
            return self;
        }else{
            return [super hitTest:point withEvent:event];
        }
    }
}

- (void)setBadge:(NSUInteger)badge{
    _badgeLabel.hidden = !(badge > 0);
    
    _badgeLabel.text = [NSString stringWithFormat:@"%lu", MIN(99, badge)];
}


- (void)setBlock:(void (^)(void))block{
    _block = [block copy];
    
    if (_block){
        [self addTarget:self
                 action:@selector(tap:)
       forControlEvents:UIControlEventTouchUpInside];
    }else{
        [self removeTarget:self
                    action:@selector(tap:)
          forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)tap:(id)sender{
    if (_block){
        _block();
    }
}

@end
