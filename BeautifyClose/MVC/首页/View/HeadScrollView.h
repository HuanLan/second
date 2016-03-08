//
//  HeadScrollView.h
//  BeautifyClose
//
//  Created by ios on 15/12/8.
//  Copyright (c) 2015年 陈若男. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadScrollView : UIScrollView

@property (nonatomic,strong)NSMutableArray *viewArr;


- (void)createWithPageCount:(NSInteger)count;
@end
