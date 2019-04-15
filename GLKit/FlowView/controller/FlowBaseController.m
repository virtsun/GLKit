//
//  LTFTableViewBaseController.m
//  Leaflet
//
//  Created by l.t.zero on 2018/8/14.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import "FlowBaseController.h"
#import "FlowBaseViewCell.h"
#import "FlowReuseHeaderFooterView.h"

@interface FlowBaseController ()

@property (nonatomic, strong) UICollectionView *flowView;


@end

@implementation FlowBaseController{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = YES;
    // Do any additional setup after loading the view.
    [self initTableView];
    
}
- (void)initTableView{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = [self respondsToSelector:@selector(columMargin)]?[self columMargin]:0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _flowView = [[UICollectionView alloc]initWithFrame:self.view.bounds
                                             collectionViewLayout:layout];
    _flowView.dataSource = self;
    _flowView.delegate = self;
    _flowView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_flowView];
    
    if (@available(iOS 11.0, *)){
        _flowView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

#pragma mark --
#pragma mark -- Setter && Getter
- (void)updateDataSource{
    
    [self.flowView.collectionViewLayout invalidateLayout];
    [self.flowView reloadData];
}
- (void)setProvider:(FlowProvider *)provider{
    _provider = provider;
    _provider.delegate = self;
}

#pragma mark --
#pragma mark -- UITableView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.provider.dataSource.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FlowSectionViewModel *sec = self.provider.dataSource[section];
    return sec.cellModels.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    FlowSectionViewModel *sectionModel = self.provider.dataSource[section];
    return [sectionModel.headerModel caculatedSize];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    FlowSectionViewModel *sectionModel = self.provider.dataSource[section];
    return [sectionModel.footerModel caculatedSize];
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        FlowSectionViewModel *model = self.provider.dataSource[indexPath.section];
        
        FlowReuseHeaderFooterView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(model.headerModel.registedClass) forIndexPath:indexPath];
        header.model = model.headerModel;

        return header;
    }else{
        FlowSectionViewModel *model = self.provider.dataSource[indexPath.section];
        
        FlowReuseHeaderFooterView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(model.footerModel.registedClass) forIndexPath:indexPath];
        header.model = model.footerModel;
        return header;
    }
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FlowSectionViewModel *section = self.provider.dataSource[indexPath.section];
    FlowBaseViewModel *model = section.cellModels[indexPath.row];
    return [model caculatedSize];
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if ([self respondsToSelector:@selector(flowViewInsetsAtSection:)]){
        return [self flowViewInsetsAtSection:section];
    }
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return [self respondsToSelector:@selector(rowMargin)]?[self rowMargin]:0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FlowSectionViewModel *section = self.provider.dataSource[indexPath.section];
    FlowBaseViewModel *model = section.cellModels[indexPath.row];
    
    FlowBaseViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(model.registedClass) forIndexPath:indexPath];
    
    cell.indexPath = indexPath;
    cell.flowView = collectionView;
    cell.provider = self.provider;
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FlowBaseViewCell *cell = (FlowBaseViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell didSelectRowAtIndexPath:indexPath];
}
@end
