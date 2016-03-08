//
//  MyButton.m
//  BeautifyClose
//
//  Created by ios on 15/12/6.
//  Copyright (c) 2015年 陈若男. All rights reserved.
//

#import "MyButton.h"
#define  kImgHeight 35
@implementation MyButton

- (id)initWithFrame:(CGRect)frame
          withImage:(NSString *)imgName
          withTitle:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        
        UIImage *img = [UIImage imageNamed:imgName];
        _imgView = [[UIImageView alloc]initWithImage:img];
        _imgView.frame = CGRectMake(0, 0, self.frame.size.width, kImgHeight);
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imgView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imgView.frame), CGRectGetWidth(self.frame), 49-kImgHeight)];
        _titleLabel.text = title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:_titleLabel];
        
    }
    return self;
}

@end
