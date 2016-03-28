//
//  ShowView.h
//  LoginDemo
//
//  Created by 陈 on 16/1/19.
//  Copyright © 2016年 陈. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowView : UIView

@property (nonatomic,strong)UILabel *message;

- (instancetype)initWithFrame:(CGRect)frame withMessage:(NSString *)message;
@end
