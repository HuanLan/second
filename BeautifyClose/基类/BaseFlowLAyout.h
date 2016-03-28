//
//  BaseFlowLAyout.h
//  BeautifyClose
//
//  Created by 陈 on 16/3/9.
//  Copyright © 2016年 陈若男. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseFlowLAyout : UICollectionViewFlowLayout

- (instancetype)initWithItem:(CGSize)itemSize withScrollDirection:(UICollectionViewScrollDirection)direction withMinSpace:(CGFloat)mSpace withMinLine:(CGFloat)minLine;
@end
