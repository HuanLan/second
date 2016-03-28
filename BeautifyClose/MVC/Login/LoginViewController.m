//
//  LoginViewController.m
//  框架搭建
//
//  Created by 陈 on 16/1/19.
//  Copyright © 2016年 MFK. All rights reserved.
//

#import "LoginViewController.h"
#import "ShowView.h"
#import "LoginManage.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *logView;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    self.navigationController.navigationBar.hidden = YES;
    
    //获取账号
    NSMutableDictionary *accountDic = [[NSUserDefaults standardUserDefaults] objectForKey:AUTOLOGIN];

    NSString *account = [accountDic objectForKey:ACCOUNT];
    NSString *password = [accountDic objectForKey:PASSWORD];
    
    if (account != nil && account.length >0) {
        self.userName.text = account;
    }
    if (password != nil && password.length >0) {
        self.password.text = password;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self _intSubView];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gbimg"]];
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
  
    
}

//登录界面隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)_intSubView{
    //背景

    
    //文本框
    _userName.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
    _userName.leftViewMode = UITextFieldViewModeAlways;
//    UIImageView *userimg=[[UIImageView alloc]initWithFrame:CGRectMake(11, 11, 22, 22)];
//    userimg.image=[UIImage imageNamed:@"user"];
    UILabel *account = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
    account.text = @"ACCOUNT :";
    account.textColor = [UIColor colorWithWhite:0.941 alpha:1.000];
    account.font = [UIFont systemFontOfSize:15];
    [_userName.leftView addSubview:account];
    
    _password.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
    _password.leftViewMode = UITextFieldViewModeAlways;
    
//    UIImageView* pssimag = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 25, 25)];
//    pssimag.image = [UIImage imageNamed:@"pass"];
    
    UILabel *pwd = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
    pwd.text = @"PASSWORD:";
    pwd.textColor = [UIColor colorWithWhite:0.941 alpha:1.000];;
    pwd.font = [UIFont systemFontOfSize:15];
    [_password.leftView addSubview:pwd];
    
//    _password.autocapitalizationType = 
    
    //按钮
    [_loginBtn.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    
    [_loginBtn.layer setCornerRadius:5];
    
    [_loginBtn.layer setBorderWidth:1];//设置边界的宽度
    //设置按钮的边界颜色
    
    [_loginBtn.layer setBorderColor:[UIColor greenColor].CGColor];
    

    
}

//- (void)_initBgimgView{
//    
//    _bgimgView.image = [UIImage imageNamed:@"bgimg.png"];
//    
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithFrame:self.view.frame];
//    effectView.alpha = .7;
//    
//    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    effectView.effect = effect;
//    
//
//    [_bgimgView addSubview:effectView];
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginAction:(UIButton *)sender {
    
    NSString *userText = _userName.text;
    NSString *passText = _password.text;
    
  
    
    
    if (userText.length == 0 || passText.length == 0) {
        
        ShowView *showView = [[ShowView alloc]initWithFrame:CGRectMake((kScreenWidth-150)/2, _logView.center.y-30, 150, 30) withMessage:@"请输入帐号或者密码"];
        [self.view addSubview:showView];
        
    }
    else{
         //此处为网络请求部分
        
        if ([userText isEqualToString:@"123"]&&[passText isEqualToString:@"123"]) {
            
            [LoginManage sharedManager].loginState = YES;
            //保存账号，不保存密码
            NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:userText,ACCOUNT,passText,PASSWORD ,nil];
            
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:AUTOLOGIN];
            [[NSUserDefaults standardUserDefaults]synchronize];
            //获取帐号信息 本地缓存
            
            //更换主窗口
//            if ([UIApplication sharedApplication].keyWindow == app.loginWindow) {
//                
//                [[NSNotificationCenter defaultCenter]postNotificationName:NOTKEYWINDOW object:nil];
//                
//                return;
//                
//            }
            [self back];
            
        }
        else{
            
            ShowView *showView = [[ShowView alloc]initWithFrame:CGRectMake((kScreenWidth-150)/2, _logView.center.y-30, 150, 30) withMessage:@"帐号或者密码错误"];
            [self.view addSubview:showView];
            
        }

    }
   

    
}

-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
   
}

-(void)closeKeyboard{
    
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
}

//return按钮的作用
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == _userName) {
        
        [_password becomeFirstResponder];
        
    }
    else{
        
        [textField resignFirstResponder];
        [self LoginAction:nil];
        
        
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField == _userName) {
        
        _userName.returnKeyType = UIReturnKeyDefault;
        
    }
    else{
        
         _password.returnKeyType = UIReturnKeyDone;
        
    }
     textField.enablesReturnKeyAutomatically = YES;
    
}


@end
