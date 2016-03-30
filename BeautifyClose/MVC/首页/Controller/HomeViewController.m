 //
//  HomeViewController.m
//  BeautifyClose
//
//  Created by ios on 15/12/6.
//  Copyright (c) 2015年 陈若男. All rights reserved.
//

#import "HomeViewController.h"
#import "HeadScrollView.h"


#import "HeadModel.h"
#import "ListModel.h"


#import "GoodsViewController.h"

@interface HomeViewController ()<UIScrollViewDelegate>{
    
       HMSegmentedControl *_hMItemCtrl;
    
}
@property (strong, nonatomic)HeadScrollView *headScrollView;
@property (nonatomic,strong)NSArray *navArr;
@property (strong,nonatomic)NSMutableArray *listArr;
@property (strong,nonatomic)GoodsViewController *newsCollection;
//@property (nonatomic,strong)NSMutableArray *collections;


@property (strong, nonatomic)UIPageControl *HpageCtrl;
@property (nonatomic,strong)NSTimer *timer;



@end

@implementation HomeViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"descript" : @"description"
                 };
    }];

    _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgScrollView.contentSize = CGSizeMake(kScreenWidth, kheadViewHeight+kScreenHeight);
    _bgScrollView.showsVerticalScrollIndicator = NO;
    _bgScrollView.delegate = self;
    
    [self.view addSubview:_bgScrollView];
    //滚动视图
    [self createHeadView];
    
    
    
    [self loadData];
    
}



- (void)createHeadView{
    

    //滑动视图
    _headScrollView = [[HeadScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kheadViewHeight)];
    _headScrollView.delegate = self ;
    _headScrollView.backgroundColor = [UIColor yellowColor];
    
    //分页
    _HpageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake((kScreenWidth-150)/2.0, _headScrollView.bottom-20, 150, 20)];
    [_bgScrollView addSubview:_headScrollView];
    [_bgScrollView addSubview:_HpageCtrl];

    
    
}


- (void)createGoodsViewWithTitleArr:(NSMutableArray *)arr{
    
    
    _newsCollection = [[GoodsViewController alloc]initWithFrame:CGRectMake(0, _headScrollView.bottom+44, kScreenWidth, kScreenHeight-44-64)];
    _newsCollection.scrollEnabled = NO;
    _newsCollection.backgroundColor = [UIColor whiteColor];

    [self.bgScrollView addSubview:_newsCollection];
    
    //头部控制的segMent
    _hMItemCtrl = [[HMSegmentedControl alloc]initWithSectionTitles:arr];
    _hMItemCtrl.frame = CGRectMake(0, _headScrollView.bottom, kScreenWidth, 44);
    _hMItemCtrl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    
    _hMItemCtrl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _hMItemCtrl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    _hMItemCtrl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _hMItemCtrl.verticalDividerEnabled = YES;
    _hMItemCtrl.verticalDividerColor = [UIColor colorWithWhite:0.150 alpha:1.000];
    _hMItemCtrl.verticalDividerWidth = 1.0f;
    [_hMItemCtrl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:1.000 green:0.386 blue:0.953 alpha:1.000],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        return attString;
    }];
    
    [_hMItemCtrl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];


    
    [self.bgScrollView addSubview:_hMItemCtrl];

    

}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
    NSInteger index = segmentedControl.selectedSegmentIndex;
    NSArray *arr = self.navArr[index][@"nav_cat_ids"];
    _newsCollection.paraArr = arr;
    
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}

//轮播图
- (void)loadData{
    //加载网络数据
    NSMutableArray *arr = [NSMutableArray array];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api2.hichao.com/mall/banner" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //解析网络数据
        NSArray *dataArr = responseObject[@"data"][@"items"];
        
        for(NSDictionary *dic in dataArr){
            
            HeadModel *model = [HeadModel mj_objectWithKeyValues:dic[@"component"]];
            [arr addObject:model];
        }
        
        self.data = arr;
       

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"获取失败");
       
    }];
    
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
    [manager1 GET:@"http://api2.hichao.com/region/recommend/tag" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *dataArr = responseObject[@"data"][@"items"];
        self.navArr = dataArr;
        
        AFHTTPSessionManager *manager2 = [AFHTTPSessionManager manager];
        
        //加载今日上新的列表
        _listArr = [NSMutableArray array];
        [manager2 GET:@"http://api2.hichao.com/items" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSArray *dataArr = responseObject[@"data"][@"items"];
            for (NSDictionary *dic in dataArr) {
                if ([dataArr indexOfObject:dic] == 0) {
                    
                    continue;
                }
                ListModel *model = [ListModel mj_objectWithKeyValues: dic[@"component"]];
                [_listArr addObject:model];
                
            }
            //        GoodsViewController *collView = _collections[0];
            _newsCollection.data = _listArr;
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            NSLog(@"manager2:获取失败");
            
            
        }];

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"manager1:获取失败");
        

    }];
    
    
    
}

//复写data方法
- (void)setData:(NSMutableArray *)data{
    if (_data != data) {
        _data = data;
    }
    
    [_headScrollView createWithPageCount:_data.count];
    [self loadDataWithHeadScrollView];

}

//商品种类标题
- (void)setNavArr:(NSArray *)navArr{
    
     NSMutableArray *titles = [[NSMutableArray alloc]init];
    _navArr = navArr;
    for (NSDictionary *dic in navArr) {
        
        [titles addObject:dic[@"nav_name"]];
    }
    [self createGoodsViewWithTitleArr:titles];
}


- (void)setListArr:(NSMutableArray *)listArr{
    
    _listArr = listArr;
    
    
}
- (void)loadDataWithHeadScrollView{
    
    _HpageCtrl.numberOfPages = _data.count;
    
    for (int i = 0;i < _data.count;i ++) {
        UIControl *contrl = _headScrollView.viewArr[i];
        HeadModel *model = _data[i];
        NSString *picStr = model.picUrl;
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:contrl.bounds];
        [imgView sd_setImageWithURL:[NSURL URLWithString:picStr]];
        [contrl addSubview:imgView];
        
    }
    [self addTimer];
}
#pragma mark---头部滑动视图代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    
    if (scrollView == _headScrollView) {
          int page = (offsetX +kScreenWidth/2)/kScreenWidth;
          _HpageCtrl.currentPage = page;

      
    }
      

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == _headScrollView) {
        
          [self removeTimer];
    }
  
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == _headScrollView) {
        
        [self addTimer];
        
    }
    CGFloat offsetY = _bgScrollView.contentOffset.y;
    if (offsetY < 120) {
        
        _newsCollection.scrollEnabled = NO;
        
    }else{
        
        _newsCollection.scrollEnabled = YES;
        
    }
    NSLog(@"%f",offsetY);

    
    
}

- (void)addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
}

- (void)removeTimer{
    
    [self.timer invalidate];
}

- (void)nextImage{
    
    int page = (int)self.HpageCtrl.currentPage;
    if (page == (int)self.HpageCtrl.numberOfPages-1) {
        page = 0;
    }else
    {
        page ++;
    }
//    滚动
    
        CGFloat x = page *kScreenWidth;
        [self.headScrollView setContentOffset:CGPointMake(x, 0) animated:YES];

   
    
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
