//
//  GoodsDetailViewCtrl.m
//  BeautifyClose
//
//  Created by 陈 on 16/4/1.
//  Copyright © 2016年 陈若男. All rights reserved.
//

#import "GoodsDetailViewCtrl.h"
#define HOMEPATH @"http://m.hichao.com/lib/interface.php"
#import "FeHourGlass.h"

@interface GoodsDetailViewCtrl ()<UIWebViewDelegate>
{
    FeHourGlass *fehourView;
}
@property (nonatomic,copy)NSString *detailPath;
@property (nonatomic,copy)NSString *sizePath;
@property (nonatomic,copy)NSString *afterSalePath;

@property (nonatomic,strong)HMSegmentedControl *segmentControl;
@property (nonatomic,strong)NSURLRequest *request;
@property (nonatomic,strong)UIWebView *webView;


@end

@implementation GoodsDetailViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _segmentControl = [[HMSegmentedControl alloc]initWithSectionTitles:@[@"详情",@"尺码",@"售后"]];
    _segmentControl.frame = CGRectMake(0, 65, kScreenWidth, 44);
    _segmentControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    
    _segmentControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentControl.selectionIndicatorColor = [UIColor colorWithRed:1.000 green:0.485 blue:0.924 alpha:1.000];
    [_segmentControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor colorWithWhite:0.200 alpha:1.000],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        return attString;
    }];
    
    [_segmentControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_segmentControl];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, _segmentControl.bottom, kScreenWidth, kScreenHeight-_segmentControl.height)];
    
    [self.view addSubview:_webView];
//    [_webView loadRequest:_request];
    
    _webView.delegate = self;
    
    fehourView = [[FeHourGlass alloc]initWithView:self.view];
    [fehourView dismiss];
    [self.view addSubview:fehourView];

 
}


- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
    NSInteger index = segmentedControl.selectedSegmentIndex;
    switch (index) {
        case 0:
              self.request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString: _detailPath] cachePolicy:0 timeoutInterval:10];
            break;
        case 1:
            self.request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString: _sizePath] cachePolicy:0 timeoutInterval:10];
            break;
        default:
            self.request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString: _afterSalePath] cachePolicy:0 timeoutInterval:10];
            
           
            break;
    }
    
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setRequest:(NSURLRequest *)request{
    
    _request = request;
    [_webView loadRequest:request];
//    [self.view ]
}
- (void)setSId:(NSString *)sId{
    
    _sId = sId;
//    http://m.hichao.com/lib/interface.php?m=aftersaleservice&sid=2308515
    _detailPath = [NSString stringWithFormat:@"%@?m=goodsdetail&sid=%@",HOMEPATH,sId];
    _sizePath = [NSString stringWithFormat:@"%@?m=goodssize&sid=%@",HOMEPATH,sId];
    _afterSalePath = [NSString stringWithFormat:@"%@?m=aftersaleservice&sid=%@",HOMEPATH,sId];
    [self segmentedControlChangedValue:_segmentControl];
    NSLog(@"\n%@\n%@\n%@",_detailPath,_sizePath,_afterSalePath);
    
    
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [fehourView show];
    NSLog(@"正在加载");
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
     [fehourView dismiss];
      NSLog(@"加载完成");
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    
    
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
