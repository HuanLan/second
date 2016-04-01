//
//  BaseHeaderView.m
//  CollectionViewDemo
//
//  Created by 陈 on 16/3/31.
//  Copyright © 2016年 CR. All rights reserved.
//

#import "BaseHeaderView.h"
#import "HeadModel.h"
@implementation BaseHeaderView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setpSubVeiw];
        
    }
    return self;
}

- (void)setHeadimgArr:(NSArray *)headimgArr{
    
    _headimgArr = [NSMutableArray array];

      for (HeadModel *model  in headimgArr) {
          
          [_headimgArr addObject:model.picUrl];
    }
    _cycleScrollView.imageURLStringsGroup = _headimgArr;
    [self setNeedsDisplay];
    
}
- (void)setpSubVeiw{
    
    _cycleScrollView =  [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.bounds.size.width, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
//    NSArray *arr = @[ @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//                      @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"];
//
//    
//    _cycleScrollView.imageURLStringsGroup = arr;
    

    [self addSubview:_cycleScrollView];

    
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
//    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
