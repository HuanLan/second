//
//  CombineViewController.m
//  BeautifyClose
//
//  Created by 陈 on 16/1/25.
//  Copyright © 2016年 陈若男. All rights reserved.
//

#import "CombineViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface CombineViewController ()

//@property (nonatomic,strong)UIScrollView *scrollView;
//@property (nonatomic,strong)
//@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;

@end

@implementation CombineViewController

- (instancetype)init{
    
    if (self = [super init]) {
        
        FirstViewController *firstVC = [[FirstViewController alloc] init];
        SecondViewController *secondVC = [[SecondViewController alloc] init];
        
//        self.segmentBgColor = [UIColor colorWithRed:18.0f/255 green:50.0f/255 blue:110.0f/255 alpha:1.0f];
        self.indicatorViewColor = [UIColor whiteColor];
        self.titleColor = [UIColor colorWithRed:0.144 green:0.608 blue:0.911 alpha:1.000];

        
        [self setViewControllers:@[firstVC, secondVC]];
        [self setTitles:@[@"穿搭", @"话题"]];

    }
    return self;
    
}
- (void)loadView{
    
    [super loadView];
    
   }
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    

    
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

@end
