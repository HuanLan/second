//
//  BaseHeaderView.h
//  CollectionViewDemo
//
//  Created by 陈 on 16/3/31.
//  Copyright © 2016年 CR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@interface BaseHeaderView : UICollectionReusableView<SDCycleScrollViewDelegate>

@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong)NSMutableArray *headimgArr;

@end
