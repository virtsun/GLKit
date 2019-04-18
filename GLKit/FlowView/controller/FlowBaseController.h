//
//  LTFTableViewBaseController.h
//  Leaflet
//
//  Created by l.t.zero on 2018/8/14.
//  Copyright © 2018 Starunion. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "FlowSectionViewModel.h"
#import "FlowLayout.h"
#import "FlowProvider.h"

@protocol FLowLayoutSpace <NSObject>

@optional
- (CGFloat)columMargin;
- (CGFloat)rowMargin;
- (UIEdgeInsets)flowViewInsetsAtSection:(NSInteger)section;

@end

@interface FlowBaseController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate,FLowLayoutSpace,FlowProviderDelegate>

@property (nonatomic, readonly) UICollectionView *flowView;

@property (nonatomic, strong) FlowProvider *provider;


@end
