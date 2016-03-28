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

#import "WJItemsControlView.h"

#import "GoodsViewController.h"

@interface HomeViewController ()<UIScrollViewDelegate>{
    
       WJItemsControlView *_itemControlView;
}
@property (strong, nonatomic)HeadScrollView *headScrollView;
@property (strong,nonatomic)NSMutableArray *listArr;
//@property (strong,nonatomic)UICollectionView *newsCollection;

@property (strong, nonatomic)UIPageControl *HpageCtrl;
@property (nonatomic,strong)NSTimer *timer;



@end

@implementation HomeViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgScrollView.contentSize = CGSizeMake(kScreenWidth, kheadViewHeight+kScreenHeight);
    _bgScrollView.showsVerticalScrollIndicator = NO;
    
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
    
//    NSArray * titleArr = @[@"今日上新",@"上装",@"裙装",@"裤装"];
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _headScrollView.bottom+44, kScreenWidth, kScreenHeight-44-64)];
    scroll.delegate = self;
    scroll.pagingEnabled = YES;
    scroll.contentSize = CGSizeMake(kScreenWidth*arr.count, kScreenHeight*4);
    scroll.backgroundColor = [UIColor yellowColor];
    
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.bounces = NO;
    
    for (int i=0; i<arr.count; i++) {
                
        GoodsViewController *collectionView = [[GoodsViewController alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight)];
        collectionView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(10)*0.1 green:arc4random_uniform(10)*0.1  blue:arc4random_uniform(10)*0.1  alpha:1];
        
        [scroll addSubview:collectionView];
    }
    [self.bgScrollView addSubview:scroll];

    //头部控制的segMent
    WJItemsConfig *config = [[WJItemsConfig alloc]init];
    config.itemWidth = kScreenWidth/4.0;
    
    _itemControlView = [[WJItemsControlView alloc]initWithFrame:CGRectMake(0, _headScrollView.bottom, kScreenWidth, 44)];
    _itemControlView.tapAnimation = YES;
    _itemControlView.config = config;
    _itemControlView.titleArray = arr;
    
    __weak typeof (scroll)weakScrollView = scroll;
    [_itemControlView setTapItemWithIndex:^(NSInteger index,BOOL animation){
        
        
        [weakScrollView scrollRectToVisible:CGRectMake(index*weakScrollView.frame.size.width, 0.0, weakScrollView.frame.size.width,weakScrollView.frame.size.height) animated:animation];
        
    }];
    [self.bgScrollView addSubview:_itemControlView];

    

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
        self.listArr = [ListModel mj_objectArrayWithKeyValuesArray:dataArr];
        
        
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


- (void)setListArr:(NSMutableArray *)listArr{
    
    _listArr = listArr;
    NSMutableArray *titles = [[NSMutableArray alloc]init];
    for (ListModel *model in listArr) {
        
        [titles addObject:model.nav_name];
    }
    //商品视图
    [self createGoodsViewWithTitleArr:titles];

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

      
    }else{
        
        CGFloat offset = offsetX/CGRectGetWidth(scrollView.frame);
        [_itemControlView moveToIndex:offset];

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
        
    }else{
        
        float offset = scrollView.contentOffset.x;
        offset = offset/CGRectGetWidth(scrollView.frame);
        [_itemControlView endMoveToIndex:offset];

    }
    
    
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
