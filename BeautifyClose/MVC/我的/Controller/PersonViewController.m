//
//  PersonViewController.m
//  #2ios
//
//  Created by 陈 on 16/3/3.
//  Copyright © 2016年 陈. All rights reserved.
//

#import "PersonViewController.h"
#import "RemindView.h"

@interface PersonViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *lvLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet RemindView *remindView;
- (IBAction)headImgTapActon:(UITapGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation PersonViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
    
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        
           }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _remindView.layer.cornerRadius = _remindView.width/2.0;
    _remindView.layer.masksToBounds = YES;
    _headImgView.userInteractionEnabled = YES;

    if (!self.tableView.mj_header) {
        
        self.tableView.mj_header = [self refresh];
        
    }

    [self loadData];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgImage"]];
    _remindView.label.text = @"2";
     [self _setpUserInfo];
    
    _cancelBtn.layer.borderWidth = 1.0;
    _cancelBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    [self _setNaviBar];
   
//     [super.navigationController setNavigationBarHidden:YES animated:NO];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (MJRefreshNormalHeader *)refresh{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 设置文字
    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor grayColor];
    header.lastUpdatedTimeLabel.textColor =  [UIColor grayColor];

    return header;
}

- (void)loadData{
    
    //获取账号信息
    NSDictionary *accountDic = [[NSUserDefaults standardUserDefaults]objectForKey:AUTOLOGIN];
    if (accountDic[ACCOUNT]) {
        
        _nameLabel.text = [accountDic objectForKey:ACCOUNT];
//        NSString *password = [accountDic objectForKey:PASSWORD];
        //请求网络信息
        

    }else{
        
        _nameLabel.text = @"未登录";
        
    }
    
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
//    });

}
- (void)_setpUserInfo{
    
//    [_headImgView sd_setImageWithURL:[NSURL URLWithString:@"http://cdn.duitang.com/uploads/item/201406/08/20140608004245_jmBmP.thumb.jpeg"]];
    
}

- (void)_setNaviBar{
    
    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor colorWithWhite:0.860 alpha:1.000],NSForegroundColorAttributeName,
                                               [UIFont systemFontOfSize:20],
                                               NSFontAttributeName, nil];
    
    [self.navigationController.navigationBar setTitleTextAttributes:navbarTitleTextAttributes];
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTranslucent:YES];

}

//透明图片
-(UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)headImgTapActon:(UITapGestureRecognizer *)sender {
    
//    LoginViewController *loginVC = [[LoginViewController alloc]init];
//    [self presentViewController:loginVC animated:YES completion:nil];
//    if(![LoginManage sharedManager].loginState)
//    {
//         [[LoginManage sharedManager] autoLogin];
//        
//         [self.tableView reloadData];
//    }else{
//        
//        NSLog(@"进入用户帐号详情页");
//        
//    }
   
//    [[LoginManage sharedManager]showLoginView];
    [self.tableView reloadData];

}

- (void)cancelAction:(UIButton *)btn{
    
    //获取帐号字典
    NSMutableDictionary *accountDic = [[NSUserDefaults standardUserDefaults] objectForKey:AUTOLOGIN];
    
    accountDic = [NSMutableDictionary dictionary];
    [[NSUserDefaults standardUserDefaults] setObject:accountDic forKey:AUTOLOGIN];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
//    [LoginManage sharedManager].loginState = NO;
//    [[LoginManage sharedManager]showLoginView];

}
@end
