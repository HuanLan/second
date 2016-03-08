//
//  MyButton.h
//  BeautifyClose
//
//  Created by ios on 15/12/6.
//  Copyright (c) 2015年 陈若男. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyButton : UIControl
{
    UIImageView *_imgView;
    UILabel *_titleLabel;
}

- (id)initWithFrame:(CGRect)frame
          withImage:(NSString *)imgName
          withTitle:(NSString *)title;
@end
