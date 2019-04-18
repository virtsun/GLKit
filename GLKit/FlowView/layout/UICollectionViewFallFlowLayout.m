//
//  WaterfallLayout.m
//  MoveCollectionView
//
//  Created by sunlantao on 2019/4/4.
//  Copyright © 2019 66rpg. All rights reserved.
//

#import "UICollectionViewFallFlowLayout.h"

@implementation UICollectionViewFallFlowLayout{
    NSMutableArray *__atrributesAray_;
    NSMutableArray *__availableFrames;
    
    CGFloat __maxWidth_;
    CGFloat __maxHeight_;
    CGRect __lastSectionHeaderFrame_;

}

- (void)prepareLayout{
    [super prepareLayout];
    
    self.sectionInset             = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
    self.minimumLineSpacing       = 0.f;
    self.minimumInteritemSpacing  = 0.f;

    __atrributesAray_ = [@[] mutableCopy];
    
    __availableFrames = [@[@(CGRectMake(0, 0, CGRectGetWidth(self.collectionView.bounds), HUGE_VALF))] mutableCopy];
    
    for (size_t i = 0; i < [self.collectionView numberOfSections]; i++){
        UICollectionViewLayoutAttributes *header = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
        [__atrributesAray_ addObject:header];
        for (size_t j = 0; j < [self.collectionView numberOfItemsInSection:i]; j++){
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i]];
            [__atrributesAray_ addObject:attributes];
        }
    }
    
}
-(CGSize)collectionViewContentSize{
    return CGSizeMake(__maxWidth_, __maxHeight_);
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
  
    id<UICollectionViewDelegateFlowLayout> layout = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    CGSize size = CGSizeZero;
    
    if ([layout respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]){
        size = [layout collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    }
    
    attributes.frame = [self searchForNextRect:size atIndex:indexPath  supplementaryViewOfKind:NO];

    
    return attributes;
}
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    id<UICollectionViewDelegateFlowLayout> layout = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    CGSize size = CGSizeZero;
    
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]){
        if ([layout respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]){
            size = [layout collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:indexPath.section];
        }
    }else{
        if ([layout respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]){
            size = [layout collectionView:self.collectionView layout:self referenceSizeForFooterInSection:indexPath.section];
        }
    }
    
    attributes.frame = [self searchForNextRect:size atIndex:indexPath supplementaryViewOfKind:YES];
    
    __lastSectionHeaderFrame_ = attributes.frame;
    
    return attributes;
}

- (CGRect)searchForNextRect:(CGSize)size atIndex:(NSIndexPath *)indexPath supplementaryViewOfKind:(BOOL)isSupplementaryViewOfKind{
    
    if (__availableFrames.count == 0) return CGRectZero;
    
    size = (CGSize){floor(size.width), floor(size.height)};
    [self resort];
    UIEdgeInsets insets = UIEdgeInsetsZero;
    
    id<UICollectionViewDelegateFlowLayout> layout = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    CGFloat itemSpace = 0;
    CGFloat lineSpace = 0;
    
    if ([layout respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]){
        insets = [layout collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.section];
    }
    
    if ([layout respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]){
        itemSpace = [layout collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:indexPath.section];
    }
    
    if ([layout respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]){
        lineSpace = [layout collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:indexPath.section];
    }
    //header or footer 强制拉伸至collectionView宽度
    if (isSupplementaryViewOfKind){insets.left = 0; insets.right = 0;lineSpace=0;itemSpace=0;size.width = CGRectGetWidth(self.collectionView.bounds);};

    if (size.width + insets.left + insets.right > CGRectGetWidth(self.collectionView.bounds)) return CGRectZero;
    
    for (NSNumber *value in __availableFrames){
        CGRect frame = [value CGRectValue];
        CGRect newFrame;
        CGFloat offX = CGRectGetMinX(frame) <= insets.left?insets.left:itemSpace;
        CGFloat offY = CGRectGetMinY(frame) <= CGRectGetMaxY(__lastSectionHeaderFrame_)?insets.top:lineSpace;
 
        CGRect originFrame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), size.width, size.height);

        newFrame = CGRectOffset(originFrame, offX, offY);
        
        if (CGRectContainsRect(frame, newFrame)){
            __maxWidth_ = MAX(CGRectGetMaxX(newFrame), __maxWidth_);
            __maxHeight_ = MAX(CGRectGetMaxY(newFrame), __maxHeight_);
    
            //移除原来的矩形,生成新的可用矩形
            [__availableFrames removeObject:value];
            
            CGRect availableRect01 = CGRectMake(CGRectGetMinX(frame), CGRectGetMaxY(newFrame), CGRectGetMaxX(newFrame) - CGRectGetMinX(frame), HUGE_VALF);
            [__availableFrames addObject:@(availableRect01)];
            
            if (CGRectGetMaxX(frame) - CGRectGetMaxX(availableRect01) > 5){
                CGRect availableRect02 = CGRectMake(CGRectGetMaxX(availableRect01), CGRectGetMinY(frame),
                                                    CGRectGetWidth(frame) - CGRectGetWidth(availableRect01),
                                                    HUGE_VALF);
                [__availableFrames addObject:@(availableRect02)];
            }
            return newFrame;
        }
    }
    
    //如果现有可用矩形没有找到可用
    //排序可用矩形
    NSArray *availableFrames = [__availableFrames copy];
    
    [__availableFrames removeAllObjects];
    //重构
    CGFloat minX = 0, maxY = 0;
    for (NSValue *v in availableFrames){
        CGRect frame = [v CGRectValue];
        minX = MIN(minX, CGRectGetMinX(frame));
        maxY = MAX(maxY, CGRectGetMinY(frame));
    }
    [__availableFrames addObject:@(CGRectMake(minX, maxY, CGRectGetWidth(self.collectionView.bounds), HUGE_VALF))];
    return [self searchForNextRect:size atIndex:indexPath supplementaryViewOfKind:isSupplementaryViewOfKind];
}
- (void)resort{
    __availableFrames = [[__availableFrames sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CGRect frame01 = [obj1 CGRectValue];
        CGRect frame02 = [obj2 CGRectValue];
        if (CGRectGetMinY(frame02) > CGRectGetMinY(frame01)){
            return NSOrderedAscending;
        }else if (CGRectGetMinY(frame02) < CGRectGetMinY(frame01)){
            return NSOrderedDescending;
        }else{
           return CGRectGetMinX(frame02) > CGRectGetMinX(frame01)?NSOrderedAscending:NSOrderedDescending;
        }
    }] mutableCopy];
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return  __atrributesAray_;
}
@end
