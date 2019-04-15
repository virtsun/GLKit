//
//  FlowProvider.h
//  FlowView
//
//  Created by sunlantao on 2018/11/2.
//  Copyright © 2018年 sunlantao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlowSectionViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FlowProviderDelegate <NSObject>

@required
- (void)updateDataSource;

@end


@interface FlowProvider : NSObject

@property (nonatomic, weak) id <FlowProviderDelegate> delegate;
@property (nonatomic, weak) UICollectionView *flowView;
@property (nonatomic, strong) NSArray<FlowSectionViewModel *> *dataSource;

+ (instancetype)providerWithFlowView:(UICollectionView *)flowView;

- (FlowBaseViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath;
- (FlowBaseModel *)modelAtIndexPath:(NSIndexPath *)indexPath;

- (void)update;

@end

NS_ASSUME_NONNULL_END
