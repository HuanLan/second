//
//  BaseTabBarController.m
//  BeautifyClose
//
//  Created by ios on 15/12/6.
//  Copyright (c) 2015年 陈若男. All rights reserved.
//

#import "BaseTabBarController.h"
#import "HomeViewController.h"
#import "CombineViewController.h"
#import "BbsViewController.h"
#import "BuyCarViewController.h"
#import "PersonViewController.h"

#import "Comment.h"
#import "BaseNaviController.h"

@interface BaseTabBarController ()

@property (nonatomic,strong)UITabBar *myTabbar;
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _initTabbar];
    
    // 设置item属性
    [self setupItem];
    
    // 添加所有的子控制器
    [self initSubView];

    
    // 处理TabBar
    [self setupTabBar];
    
//    self.selectedIndex = 1;
    
}

- (void)_initTabbar{
    
    _myTabbar = [[UITabBar alloc]init];
    
    //设置背景
    UIImage *bgImg = [UIImage imageNamed:@"bottom_bg@2x.png"];
    _myTabbar.backgroundColor = [UIColor colorWithPatternImage:bgImg];
    
    // 按钮的尺寸
    CGFloat tabBarButtonW = kScreenWidth / 5;
    CGFloat tabBarButtonH = 50;
    CGFloat tabBarButtonY = 0;
    
    int index = 0;
    // 设置4个TabBarButton的frame
    for (UIView *tabBarButton in _myTabbar.subviews) {
        if (![NSStringFromClass(tabBarButton.class) isEqualToString:@"UITabBarButton"]) continue;
        
        // 计算按钮的X值
        CGFloat tabBarButtonX = index * tabBarButtonW;
        // 设置按钮的frame
        tabBarButton.frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonW, tabBarButtonH);
        
        // 增加索引
        index++;
    }
//    _myTabbar.tintColor = [UIColor colorWithRed:255/255 green:0/255 blue:0/255 alpha:1];

    
}


/**
 * 处理TabBar
 */
- (void)setupTabBar
{
    [self setValue:_myTabbar forKeyPath:@"tabBar"];
}


/**
 * 添加一个子控制器
 * @param title 文字
 * @param image 图片
 * @param selectedImage 选中时的图片
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    
    BaseNaviController *nav = [[BaseNaviController alloc]initWithRootViewController:vc];
   
    [self addChildViewController:nav];
    
    // 设置子控制器的tabBarItem
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:image];
    UIImage *selectedImg = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = selectedImg;
    
    
}

- (void)initSubView{
  
   
    
    [self setupChildVc:[[HomeViewController alloc]init] title:@"首页" image:@"bottom_home_icon@2x.png" selectedImage:@"bottom_home_icon_on@2x.png"];
    
    [self setupChildVc:[[CombineViewController alloc]init] title:@"穿搭" image:@"bottom_dapei_icon@2x.png" selectedImage: @"bottom_dapei_icon_on@2x.png"];
    
    [self setupChildVc:[[BbsViewController alloc]init] title:@"社区" image:@"bottom_bbs_icon@2x.png" selectedImage:@"bottom_bbs_icon_on@2x.png"];
    
    [self setupChildVc:[[BuyCarViewController alloc]init] title:@"购物车" image:@"botton_shoppingcart_icon@2x.png" selectedImage:@"icon_shopping64x64on@2x.png"];
    
//    [self setupChildVc:[[PersonViewController alloc]init] title:@"我的" image:@"bottom_like_icon@2x.png" selectedImage: @"bottom_like_icon_on@2x.png"];
    BaseNaviController *nav = [[UIStoryboard storyboardWithName:@"PersonSB" bundle:nil]instantiateInitialViewController];
    nav.tabBarItem.title = @"我的";
    [self addChildViewController:nav];
       
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 设置item属性
 */
- (void)setupItem
{
 
    
    // UIControlStateNormal状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    // 文字颜色
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    // 文字大小
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    // UIControlStateSelected状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    // 文字颜色
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:251/255 green:28/255 blue:124/255 alpha:1];
    
    // 统一给所有的UITabBarItem设置文字属性
    // 只有后面带有UI_APPEARANCE_SELECTOR的属性或方法, 才可以通过appearance对象来统一设置
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}
@end
