//
//  LTFBaseTableViewCell.m
//  Leaflet
//
//  Created by l.t.zero on 2018/8/14.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import "FlowBaseViewCell.h"

@implementation FlowBaseViewCell

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)setProvider:(FlowProvider *)provider{
    _provider = provider;
    
    [self update];
}
- (void)update{}
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{}
- (void)willDisplayforRowAtIndexPath:(NSIndexPath *)indexPath{
   
}
- (void)setCorner:(UIRectCorner)corner radius:(CGFloat)radius{
    
}
@end
