//
//  HeadScrollView.m
//  BeautifyClose
//
//  Created by ios on 15/12/8.
//  Copyright (c) 2015年 陈若男. All rights reserved.
//

#import "HeadScrollView.h"

@implementation HeadScrollView




- (void)createWithPageCount:(NSInteger)count;
{
    _viewArr = [NSMutableArray array];
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.pagingEnabled = YES;
    self.contentSize = CGSizeMake(kScreenWidth * count, kheadViewHeight);
    
    
       for (int i=0; i<count; i++) {
           
        UIControl *contrl = [[UIControl alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kheadViewHeight)];
           
        [self addSubview:contrl];
        [_viewArr addObject:contrl];
    }


}




@end
