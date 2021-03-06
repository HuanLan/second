//
//  Comment.h
//  BeautifyClose
//
//  Created by ios on 15/12/6.
//  Copyright (c) 2015年 陈若男. All rights reserved.
//

#ifndef BeautifyClose_Comment_h
#define BeautifyClose_Comment_h


#import "UIViewExt.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "MJRefresh.h"



#import "BaseFlowLAyout.h"
#import "HMSegmentedControl.h"



#pragma mark 账号系统
#define     PASSWORD        @"PASSWORD"     //密码
#define     ACCOUNT         @"ACCOUNT"      //账户
#define     AUTOLOGIN       @"AUTOLOGIN"    //自动登录

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

#define  kheadViewHeight 140


#pragma mark 网络链接
#define kBaseRequest @"http://api2.hichao.com"


#define kARC4_Color [UIColor colorWithRed:arc4random_uniform(10)*0.1 green:arc4random_uniform(10)*0.1  blue:arc4random_uniform(10)*0.1  alpha:1]

#endif
