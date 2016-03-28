//
//  BaseFlowLAyout.m
//  BeautifyClose
//
//  Created by 陈 on 16/3/9.
//  Copyright © 2016年 陈若男. All rights reserved.
//

#import "BaseFlowLAyout.h"

@implementation BaseFlowLAyout

- (instancetype)initWithItem:(CGSize)itemSize withScrollDirection:(UICollectionViewScrollDirection)direction withMinSpace:(CGFloat)mSpace withMinLine:(CGFloat)minLine{
    
    if (self = [super init]) {
        
        self.itemSize = itemSize;
        self.scrollDirection = direction;
        self.minimumInteritemSpacing = mSpace;
        self.minimumLineSpacing = minLine;
        
    }
    return self;
}

@end
