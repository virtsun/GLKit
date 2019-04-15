//
//  FlowCommonAccessoryCell.m
//  Leaflet
//
//  Created by l.t.zero on 2018/9/3.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import "FlowCommonAccessoryCell.h"

@implementation FlowCommonAccessoryCell



- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]){
        
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.text = @"";
        _detailLabel.font = [UIFont systemFontOfSize:15];
        _detailLabel.textColor = UIColorFromRGB(0x323232);
        [_detailLabel sizeToFit];
        
        [self addSubview:_detailLabel];
        
        _seperatorView = [[UIView alloc] init];
        _seperatorView.backgroundColor = UIColorFromRGB(0xe1e1e1);
        [self addSubview:_seperatorView];
        
        _accessoryView = [[UIImageView alloc] init];
        ((UIImageView *)_accessoryView).image = [UIImage imageNamed:@"jf_user_arrow"];
        [_accessoryView sizeToFit];
        [self addSubview:_accessoryView];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect frame = self.titleLabel.frame;
    frame.origin.x = 15;
    self.titleLabel.frame = frame;
    
    [self.detailLabel sizeToFit];
    
    self.accessoryView.center = CGPointMake(CGRectGetWidth(self.bounds) - 15 - CGRectGetWidth(self.accessoryView.bounds), CGRectGetHeight(self.bounds)/2);
    
    frame = self.detailLabel.frame;
    frame.origin.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    frame.origin.y = CGRectGetHeight(self.bounds)/2 - CGRectGetHeight(self.detailLabel.bounds)/2;
    self.detailLabel.frame = frame;
    
    self.seperatorView.frame = CGRectMake(15, CGRectGetHeight(self.bounds) - .5f, CGRectGetWidth(self.bounds) - 30, .5f);
}

@end
