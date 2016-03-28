//
//  LoginViewController.h
//  框架搭建
//
//  Created by 陈 on 16/1/19.
//  Copyright © 2016年 MFK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController



@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)LoginAction:(UIButton *)sender;

@end
