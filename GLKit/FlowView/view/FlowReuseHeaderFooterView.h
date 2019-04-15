//
//  LTFBaseReuseHeaderFooterView.h
//  Leaflet
//
//  Created by l.t.zero on 2018/8/17.
//  Copyright © 2018 Starunion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlowBaseViewModel.h"

@interface FlowReuseHeaderFooterView : UICollectionReusableView

@property (nonatomic, copy) NSIndexPath *indexPath;
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) FlowBaseViewModel *model;

- (void)update;

@end
