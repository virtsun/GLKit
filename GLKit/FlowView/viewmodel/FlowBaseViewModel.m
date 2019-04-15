//
//  LTFTableViewBaseViewModel.m
//  Leaflet
//
//  Created by l.t.zero on 2018/8/14.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import "FlowBaseViewModel.h"

@implementation FlowBaseViewModel


- (void)setAssociatedModel:(id)associatedModel{
    _associatedModel = associatedModel;
    
    [self caculate];
}

- (void)caculate{
 //   self.caculatedSize = CGSizeMake(100, 100);
}
@end
