//
//  ShowView.m
//  LoginDemo
//
//  Created by 陈 on 16/1/19.
//  Copyright © 2016年 陈. All rights reserved.
//

#import "ShowView.h"

@implementation ShowView


- (instancetype)initWithFrame:(CGRect)frame withMessage:(NSString *)message{
    
    if (self = [super initWithFrame:frame]) {
       
        self.backgroundColor = [UIColor darkGrayColor];
        self.alpha = 1.0f;
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        
        
        UILabel *label = [[UILabel alloc]init];
//        CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(290, 9000)];
        label.frame = self.bounds;
        label.text = message;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:13];
        
        [self addSubview:label];
//        showview.frame = CGRectMake((SCREEN_WIDTH - LabelSize.width - 20)/2, SCREEN_HEIGHT - 100, LabelSize.width+20, LabelSize.height+10);
        [UIView animateWithDuration:1.5 animations:^{
            
            self.alpha = 0;
            
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
