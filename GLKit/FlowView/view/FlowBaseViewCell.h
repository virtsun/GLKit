//
//  LTFBaseTableViewCell.h
//  Leaflet
//
//  Created by l.t.zero on 2018/8/14.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowProvider.h"

#ifndef RGBACOLOR
#define UIColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.f)
#endif

@protocol FlowBaseViewCell <NSObject>

@optional
- (void)update;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)willDisplayforRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface FlowBaseViewCell : UICollectionViewCell<FlowBaseViewCell>

@property (nonatomic, copy) NSIndexPath *indexPath;
@property (nonatomic, weak) UICollectionView *flowView;
@property (nonatomic, weak) FlowProvider *provider;

- (void)setCorner:(UIRectCorner)corner radius:(CGFloat)radius;

@end
