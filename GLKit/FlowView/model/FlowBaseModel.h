//
//  LTFTableViewBaseModel.h
//  Leaflet
//
//  Created by l.t.zero on 2018/8/14.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FlowBaseModel <NSObject>

@end

@interface FlowBaseModel : NSObject<FlowBaseModel>

//@property (nonatomic, copy) NSString *title;

- (NSString *)md5;

@end
