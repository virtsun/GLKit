//
//  CustomMoveView.h
//  Unity-iPhone
//
//  Created by 66-admin on 2017/1/20.
//
//

#import <UIKit/UIKit.h>

@class UIDraggableCollectionView;

@protocol UIDraggableCollectionViewDelegate <UICollectionViewDelegate>

@required
/** 将外部数据源数组传入，以便在移动cell数据发生改变时进行修改重排 */
//- (NSArray *)originalArrayDataForCollectionView:(CustomMoveView *)CollectionView;
- (void)collectionView:(UICollectionView  *)cv moveItemFromIndexPath:(NSIndexPath *)from
           toIndexPath:(NSIndexPath *)to;
- (BOOL)collectionView:(UICollectionView  *)cv canMoveAtIndexPath:(NSIndexPath *)indexPath;

@optional
/** 选中的cell准备好可以移动的时候 */
- (void)collectionView:(UIDraggableCollectionView *)collectionView cellReadyToMoveAtIndexPath:(NSIndexPath *)indexPath;

/** 选中的cell正在移动，变换位置，手势尚未松开 */
- (void)cellIsMovingInCollectionVieww:(UIDraggableCollectionView *)CollectionView;

/** 选中的cell完成移动，手势已松开 */
- (void)cellDidEndMovingInCollectionView:(UIDraggableCollectionView *)CollectionView;



@end

@interface UIDraggableCollectionView : UICollectionView

@end
