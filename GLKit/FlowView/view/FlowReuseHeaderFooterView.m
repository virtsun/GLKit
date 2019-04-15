//
//  LTFBaseReuseHeaderFooterView.m
//  Leaflet
//
//  Created by l.t.zero on 2018/8/17.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import "FlowReuseHeaderFooterView.h"

@implementation FlowReuseHeaderFooterView

- (void)setModel:(FlowBaseViewModel *)model{
    _model = model;
    
    [self update];
}
- (void)update{}

@end
