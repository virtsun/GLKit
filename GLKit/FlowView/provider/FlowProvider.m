//
//  FlowProvider.m
//  FlowView
//
//  Created by sunlantao on 2018/11/2.
//  Copyright © 2018年 sunlantao. All rights reserved.
//

#import "FlowProvider.h"

@implementation FlowProvider{
    NSMutableArray *__registedCells;
    NSMutableArray *__registedSections;
}

+ (instancetype)providerWithFlowView:(UICollectionView *)flowView{
    FlowProvider *fp = [[[self class] alloc] init];
    fp.flowView = flowView;
    
    [fp update];
    
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
    
    [self registerClassess:dataSource];

    [self.flowView.collectionViewLayout invalidateLayout];
    [self.flowView reloadData];
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

- (BOOL)existXib:(Class)cls{
    return [[NSBundle mainBundle] pathForResource:NSStringFromClass(cls)
                                           ofType:@"nib"].length > 0;
}
- (void)registerClassess:(NSArray<FlowSectionViewModel *> *)dataSource{
    /*注册cell*/
    if (!__registedCells){
        __registedCells = [NSMutableArray new];
    }
    if (!__registedSections){
        __registedSections = [NSMutableArray new];
    }
    
    [dataSource enumerateObjectsUsingBlock:^(FlowSectionViewModel * _Nonnull section, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (section.headerModel){
            NSString *identifier = NSStringFromClass(section.headerModel.registedClass);
            
            if (![self->__registedSections containsObject:identifier]){
                
                @try{
                    if ([self existXib:section.headerModel.registedClass]){
                        NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil];
                        
                        UINib *nib = [UINib nibWithNibName:NSStringFromClass([xibs.firstObject class]) bundle:nil];
                        [self.flowView registerNib:nib
                        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(section.headerModel.registedClass)];
                        
                    }else{
                        [self.flowView registerClass:section.headerModel.registedClass
                          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(section.headerModel.registedClass)];
                    }
                    
                }@catch(NSException *exception){
                    [self.flowView registerClass:section.headerModel.registedClass
                      forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(section.headerModel.registedClass)];
                    
                }@finally{
                    [self->__registedSections addObject:identifier];
                }
                
            }
        }
        if (section.footerModel){
            NSString *identifier = NSStringFromClass(section.footerModel.registedClass);
            
            if (![self->__registedSections containsObject:identifier]){
                
                @try{
                    if ([self existXib:section.footerModel.registedClass]){
                        NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil];
                        UINib *nib = [UINib nibWithNibName:NSStringFromClass([xibs.firstObject class]) bundle:nil];
                        [self.flowView registerNib:nib
                        forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(section.footerModel.registedClass)];
                        
                    }else{
                        [self.flowView registerClass:section.footerModel.registedClass
                          forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                 withReuseIdentifier:NSStringFromClass(section.footerModel.registedClass)];
                    }
                    
                }@catch(NSException *exception){
                    [self.flowView registerClass:section.footerModel.registedClass
                      forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                             withReuseIdentifier:NSStringFromClass(section.footerModel.registedClass)];
                    
                }@finally{
                    [self->__registedSections addObject:identifier];
                }
            }
        }
        
        
        //注册cell
        [section.cellModels enumerateObjectsUsingBlock:^(FlowBaseViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *identifier = NSStringFromClass(obj.registedClass);
            
            if (![self->__registedCells containsObject:identifier]){
                @try{
                    if ([self existXib:obj.registedClass]){
                        NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil];
                        UINib *nib = [UINib nibWithNibName:NSStringFromClass([xibs.firstObject class]) bundle:nil];
                        [self.flowView registerNib:nib forCellWithReuseIdentifier:identifier];
                    }else{
                        [self.flowView registerClass:obj.registedClass forCellWithReuseIdentifier:identifier];
                    }
                    
                }@catch(NSException *exception){
                    [self.flowView registerClass:obj.registedClass forCellWithReuseIdentifier:identifier];
                }@finally{
                    [self->__registedCells addObject:identifier];
                }
            }
            
        }];
    }];
    
}

@end
