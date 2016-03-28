//
//  RemindView.m
//  #2ios
//
//  Created by 陈 on 16/3/11.
//  Copyright © 2016年 陈. All rights reserved.
//

#import "RemindView.h"

@implementation RemindView

- (void)awakeFromNib{
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _label .textAlignment =NSTextAlignmentCenter;
    _label.backgroundColor = [UIColor clearColor];
    _label.font = [UIFont systemFontOfSize:14];
    _label.textColor = [UIColor lightTextColor];
    
    [self addSubview:_label];

    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _label .textAlignment =NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:14];
         _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor lightTextColor];
    
        [self addSubview:_label];

    }
    return self;
}
//- (void)drawRect:(CGRect)rect {
//   
//    CGPoint center = CGPointMake(self.width/2.0, self.height/2.0);
//
//    //绘制
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:self.width/2.0     startAngle:0 endAngle:M_PI*2 clockwise:YES];
//    [[UIColor redColor]setFill];
//    [path fill];
//    
//
//}


@end
