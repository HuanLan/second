//
//  NewsViewCell.h
//  BeautifyClose
//
//  Created by 陈 on 16/3/9.
//  Copyright © 2016年 陈若男. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodImgView;

@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *goodPrice;
@end
