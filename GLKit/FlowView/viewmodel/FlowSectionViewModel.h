//
//  LTFTableViewSectionViewModel.h
//  Leaflet
//
//  Created by l.t.zero on 2018/8/14.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlowBaseViewModel.h"

@interface FlowSectionViewModel : NSObject

@property (nonatomic, strong) FlowBaseViewModel *headerModel;
@property (nonatomic, strong) FlowBaseViewModel *footerModel;

@property (nonatomic, strong) NSArray<FlowBaseViewModel *> *cellModels;

- (FlowBaseViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath;
- (FlowBaseModel *)modelAtIndexPath:(NSIndexPath *)indexPath;

+ (instancetype)sectionViewModelWithCount:(NSInteger)count
                               enumerator:(FlowBaseViewModel *(^)(NSInteger index))block;

+ (NSArray<FlowSectionViewModel *> *)arraySVModelWithSCount:(NSInteger)sectionCount
                                                  cellCount:(NSInteger (^)(NSInteger section))count_block
                                                 enumerator:(FlowBaseViewModel *(^)(NSInteger sectionIndex,NSInteger viewIndex))block;
@end
