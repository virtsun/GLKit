//
//  FlowProvider.m
//  FlowView
//
//  Created by sunlantao on 2018/11/2.
//  Copyright © 2018年 sunlantao. All rights reserved.
//

#import "FlowProvider.h"

@implementation FlowProvider

+ (instancetype)providerWithFlowView:(UICollectionView *)flowView{
    FlowProvider *fp = [[[self class] alloc] init];
    fp.flowView = flowView;
    
    return fp;
}


+ (instancetype)providerWithFlowView:(UICollectionView *)flowView delegate:(id<FlowProviderDelegate>)delegate{
    FlowProvider *fp = [[FlowProvider alloc] init];
    fp.flowView = flowView;
    fp.delegate = delegate;
    return fp;
}
- (void)update{}

//提供默认数据防止异常

- (void)setDataSource:(NSArray<FlowSectionViewModel *> *)dataSource{
    _dataSource = dataSource;
    
    if ([self.delegate respondsToSelector:@selector(updateDataSource)]){
        [self.delegate updateDataSource];
    }
}


- (FlowBaseViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath{
    NSCParameterAssert(indexPath != nil);
    
    if (indexPath.section >= 0 && indexPath.section < self.dataSource.count){
        FlowSectionViewModel *svm = [self dataSource][indexPath.section];
        return [svm viewModelAtIndexPath:indexPath];
    }
    
    return nil;
}
- (FlowBaseModel *)modelAtIndexPath:(NSIndexPath *)indexPath{
    NSCParameterAssert(indexPath != nil);
    
    if (indexPath.section >= 0 && indexPath.section < self.dataSource.count){
        FlowSectionViewModel *svm = [self dataSource][indexPath.section];
        return [svm modelAtIndexPath:indexPath];
    }
    
    return nil;
}

@end
