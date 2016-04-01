//
//  NewsViewCell.h
//  BeautifyClose
//
//  Created by 陈 on 16/3/9.
//  Copyright © 2016年 陈若男. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"
IB_DESIGNABLE

@interface NewsViewCell : UICollectionViewCell

@property (nonatomic)IBInspectable CGFloat bWidth;
@property (nonatomic)IBInspectable CGFloat raidus;
@property (nonatomic)IBInspectable UIColor *wColor;


@property (weak, nonatomic) IBOutlet UIImageView *goodImgView;

@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *goodPrice;

@property (nonatomic,strong)ListModel *model;

- (void)config;
@end
