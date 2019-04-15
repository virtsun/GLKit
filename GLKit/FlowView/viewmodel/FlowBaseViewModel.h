//
//  LTFTableViewBaseViewModel.h
//  Leaflet
//
//  Created by l.t.zero on 2018/8/14.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "FlowBaseModel.h"

@interface FlowBaseViewModel : NSObject

@property (nonatomic, strong) id<FlowBaseModel> associatedModel;//数据

@property (nonatomic) Class registedClass;

@property (nonatomic, assign) CGSize caculatedSize;
@property (nonatomic, strong) id userinfo;

- (void)caculate;

@end
