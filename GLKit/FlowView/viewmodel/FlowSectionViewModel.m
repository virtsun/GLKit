//
//  LTFTableViewSectionViewModel.m
//  Leaflet
//
//  Created by l.t.zero on 2018/8/14.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import "FlowSectionViewModel.h"

@implementation FlowSectionViewModel

+ (instancetype)sectionViewModelWithCount:(NSInteger)count
                               enumerator:(FlowBaseViewModel *(^)(NSInteger index))block{
    FlowSectionViewModel *svm = [[FlowSectionViewModel alloc] init];
    
    if (count > 0){
        NSMutableArray *array = [NSMutableArray new];
        
        for (size_t i = 0; i < count; i++){
            FlowBaseViewModel *vm = block(i);
            if (vm){
                [array addObject:vm];
            }
        }
        
        svm.cellModels = array;
    }
    
    return svm;
}

+ (NSArray<FlowSectionViewModel *> *)arraySVModelWithSCount:(NSInteger)sectionCount
                                                  cellCount:(NSInteger (^)(NSInteger section))count_block
                                                 enumerator:(FlowBaseViewModel *(^)(NSInteger sectionIndex,NSInteger viewIndex))block{
    
    NSCParameterAssert(count_block != nil);
    
    NSMutableArray<FlowSectionViewModel *> * array = [@[] mutableCopy];

    for (size_t i = 0; i < sectionCount; i++){
        size_t count = count_block(i);
        
        
        FlowSectionViewModel *svm = [self sectionViewModelWithCount:count
                                                         enumerator:^FlowBaseViewModel *(NSInteger index) {
                                                             return block(i, index);
                                                         }];
        if (svm){
            [array addObject:svm];
        }
        
    }
    
    return array;
}


- (FlowBaseViewModel *)viewModelAtIndexPath:(NSIndexPath *)indexPath{
    NSCParameterAssert(indexPath != nil);
    
    if ([self cellModels].count == 0) return nil;
    if (indexPath.row >= 0 && indexPath.row < self.cellModels.count){
        return self.cellModels[indexPath.row];
    }
    return nil;
}
- (FlowBaseModel *)modelAtIndexPath:(NSIndexPath *)indexPath{    
    FlowBaseViewModel *vm = [self viewModelAtIndexPath:indexPath];
    return vm.associatedModel;
}

@end
