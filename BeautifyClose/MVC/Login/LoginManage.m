//
//  LoginManage.m
//  AutoLogin
//
//  Created by 陈 on 16/1/19.
//  Copyright © 2016年 fenger. All rights reserved.
//

#import "LoginManage.h"
#import "LoginViewController.h"
@implementation LoginManage


+(instancetype)sharedManager{

    static LoginManage *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _sharedManager = [[LoginManage alloc]init];
    });
    return _sharedManager;
}

//判断登录状态，已登录返回yes，未登录则弹出登录页面
//已登录返回yes，未登录返回no
-(BOOL)judgeLoginState{

    BOOL flag = NO;
    if (self.loginState == YES) {
        flag = YES;
    }
    else{
        [self showLoginView];
    }
    return flag;
}

//自动登录，登录失败则弹出登录页面

-(void)autoLogin{

    if (self.loginState != YES) {
        [self login];
    }
}

//弹出登录界面
-(void)showLoginView{
    
//    if([UIApplication sharedApplication].keyWindow == app.loginWindow){
//        
//        return;
//    }

    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    UIViewController *currentVC = [app topViewController];
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [currentVC presentViewController:loginVC animated:YES completion:nil];
    
    
    
}
//登录
-(void)login{

    //获取账号信息
    NSDictionary *accountDic = [[NSUserDefaults standardUserDefaults]objectForKey:AUTOLOGIN];
    NSString *account = [accountDic objectForKey:ACCOUNT];
    NSString *password = [accountDic objectForKey:PASSWORD];
    
    if (account == nil || account.length == 0) {
        [self showLoginView];
        return;
    }
    if (password == nil || password.length == 0) {
        [self showLoginView];
        return;
    }
    
    //此处为网络请求部分
    //模拟登录
    if ([account isEqualToString:@"123"]&&[password isEqualToString:@"123"]) {
        
        //登录成功
        [LoginManage sharedManager].loginState = YES;
        
        //保存账号，保存密码
        NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:account,ACCOUNT,password,PASSWORD ,nil];
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:AUTOLOGIN];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else{
        //请求错误或者登录失败
        [self showLoginView];
    }
}

+ (NSString *)saveFileToDocuments:(NSString *)url{
    
            NSString *resultFilePath = @"";//URL
        
            NSString *destFilePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[url substringFromIndex:7]]; // 去除域名，组合成本地文件PATH
            NSString *destFolderPath = [destFilePath stringByDeletingLastPathComponent];//文件夹路径
            
            // 判断路径文件夹是否存在不存在则创建
            if (! [[NSFileManager defaultManager] fileExistsAtPath:destFolderPath]) {
                //创建一个目录
                [[NSFileManager defaultManager] createDirectoryAtPath:destFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
            
            // 判断该文件是否已经下载过
            if ([[NSFileManager defaultManager] fileExistsAtPath:destFilePath]) {
                
                resultFilePath = destFilePath;
            } else {
                
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                
                if ([data writeToFile:destFilePath atomically:YES]) {
                    resultFilePath = destFilePath;
                }
            }
    
        return resultFilePath;
}

@end
