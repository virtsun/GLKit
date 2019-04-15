//
//  FlowCommonCell.m
//  Leaflet
//
//  Created by l.t.zero on 2018/8/29.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import "FlowCommonCell.h"

@interface FlowCommonCell()

//@property (nonatomic, assign) UIRectCorner corner;
//@property (nonatomic, assign) CGFloat cornerRadius;

@end



@implementation FlowCommonCell

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]){
        
        _imageView = [[UIImageView alloc] init];
     //   _imageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.1f];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"CommonCell";
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor blackColor];
        [_titleLabel sizeToFit];
        
        [self addSubview:_titleLabel];
    }
    
    return self;
}

- (void)setCorner:(UIRectCorner)corner radius:(CGFloat)radius{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    
    self.layer.mask = layer;
//    self.layer.masksToBounds = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_titleLabel sizeToFit];
    
    _imageView.frame = self.bounds;
    _titleLabel.frame = CGRectMake(CGRectGetWidth(self.bounds)/2 - CGRectGetWidth(self.titleLabel.bounds)/2,
                                   CGRectGetHeight(self.bounds)/2 - CGRectGetHeight(_titleLabel.bounds)/2,
                                   CGRectGetWidth(self.titleLabel.bounds),
                                   CGRectGetHeight(self.titleLabel.bounds));
}

@end
