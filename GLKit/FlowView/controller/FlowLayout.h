//
//  LTFTableViewBaseController.h
//  Leaflet
//
//  Created by l.t.zero on 2018/8/14.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,AlignType){
    AlignWithLeft,
    AlignWithCenter,
    AlignWithRight
};
@interface FlowLayout : UICollectionViewFlowLayout
//cell对齐方式
@property (nonatomic,assign) AlignType alignType;

- (instancetype)initWithType:(AlignType)alignType;

@end
