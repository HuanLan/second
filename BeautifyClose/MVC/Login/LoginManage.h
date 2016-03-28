//
//  LoginManage.h
//  AutoLogin
//
//  Created by 陈 on 16/1/19.
//  Copyright © 2016年 fenger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface LoginManage : NSObject

@property (nonatomic , assign)BOOL  loginState;

+(instancetype)sharedManager;


//判断登录状态，已登录返回yes，未登录则弹出登录页面
//已登录返回yes，未登录返回no
-(BOOL)judgeLoginState;

//登录失败则弹出登录页面

-(void)autoLogin;

//本地缓存 并且返回路径
+ (NSString *)saveFileToDocuments:(NSString *)url;
@end
