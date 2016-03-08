//
//  CombineViewController.m
//  BeautifyClose
//
//  Created by 陈 on 16/1/25.
//  Copyright © 2016年 陈若男. All rights reserved.
//

#import "CombineViewController.h"

@interface CombineViewController ()

//@property (nonatomic,strong)UIScrollView *scrollView;
//@property (nonatomic,strong)
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;

@end

@implementation CombineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    _bgScrollView.contentSize = CGSizeMake(kScreenWidth*2, kScreenHeight);
    [self setpSegmentCtrl];
    
}


- (void)setpSegmentCtrl{
    
    UISegmentedControl *segmentCtrl = [[UISegmentedControl alloc]initWithItems:@[@"穿搭",@"专题"]];
    segmentCtrl.frame = CGRectMake(0, 0, 80, 30);
    segmentCtrl.selectedSegmentIndex = 0;
//    segmentCtrl.tintColor = [UIColor grayColor];
    [segmentCtrl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self.navigationItem setTitleView:segmentCtrl];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)segmentAction:(UISegmentedControl *)sender {
    
    NSInteger index = sender.selectedSegmentIndex;
    
//    switch (index) {
//        case 0:
//            <#statements#>
//            break;
//            
//        default:
//            break;
//    }
}
@end
