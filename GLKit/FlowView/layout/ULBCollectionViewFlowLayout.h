//
//  ULBCollectionViewFlowLayout.h
//  uliaobao
//
//  Created by FishYu on 16/8/24.
//  Copyright © 2016年 CGC. All rights reserved.
//

#import <UIKit/UIKit.h>


/// 扩展section的背景色
@class ULBCollectionReusableView;

@protocol ULBCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

@optional
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout colorForSectionAtIndex:(NSInteger)section;

@optional
- (NSString *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout titleForSectionAtIndex:(NSInteger)section;

- (void)collectionView:(UICollectionView *)collectionView willDisplayDecorationView:(ULBCollectionReusableView *)reuseView forSection:(NSInteger)section;

@end

@interface ULBCollectionReusableView : UICollectionReusableView
@property (nonatomic, strong) UILabel *titleLabel;
@end

@interface ULBCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) Class decorationClass;

@end
