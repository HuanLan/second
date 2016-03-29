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
@property (nonatomic,strong)NSArray *navArr;
@property (strong,nonatomic)NSMutableArray *listArr;
@property (strong,nonatomic)GoodsViewController *newsCollection;
@property (nonatomic,strong)NSMutableArray *collections;


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
    
//    NSArray * titleArr = @[@"今日上新",@"上装",@"裙装",@"裤装"];
    _collections = [NSMutableArray array];
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _headScrollView.bottom+44, kScreenWidth, kScreenHeight-44-64)];
    scroll.delegate = self;
    scroll.pagingEnabled = YES;
    scroll.contentSize = CGSizeMake(kScreenWidth*arr.count, kScreenHeight-44-64);
    scroll.backgroundColor = [UIColor yellowColor];
    
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.bounces = NO;
    
    for (int i=0; i<arr.count; i++) {
                
        GoodsViewController *collectionView = [[GoodsViewController alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, scroll.height)];
        collectionView.scrollEnabled = NO;
        collectionView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(10)*0.1 green:arc4random_uniform(10)*0.1  blue:arc4random_uniform(10)*0.1  alpha:1];
        [scroll addSubview:collectionView];
        [_collections addObject:collectionView];
    }
    _newsCollection = _collections[0];
    [self.bgScrollView addSubview:scroll];

    //头部控制的segMent
    WJItemsConfig *config = [[WJItemsConfig alloc]init];
    config.itemWidth = kScreenWidth/4.0;
    
    _itemControlView = [[WJItemsControlView alloc]initWithFrame:CGRectMake(0, _headScrollView.bottom, kScreenWidth, 44)];
    _itemControlView.tapAnimation = YES;
    _itemControlView.config = config;
    _itemControlView.titleArray = arr;
    
    __weak typeof (scroll)weakScrollView = scroll;
    __weak typeof(self)weakSelf = self;
    [_itemControlView setTapItemWithIndex:^(NSInteger index,BOOL animation){
        
        
        [weakScrollView scrollRectToVisible:CGRectMake(index*weakScrollView.frame.size.width, 0.0, weakScrollView.frame.size.width,weakScrollView.frame.size.height) animated:animation];
        
        
        AFHTTPSessionManager *manager2 = [AFHTTPSessionManager manager];
        NSArray *arr = weakSelf.navArr[index][@"nav_cat_ids"];
        NSMutableArray *lists = [NSMutableArray array];
        NSDictionary *para = @{
                               @"category_id":arr,
                               };
        
        [manager2 GET:@"http://api2.hichao.com/items" parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSArray *dataArr = responseObject[@"data"][@"items"];
            for (NSDictionary *dic in dataArr) {
                if ([dataArr indexOfObject:dic] == 0) {
                    
                    continue;
                }
                ListModel *model = [ListModel mj_objectWithKeyValues: dic[@"component"]];
                [lists addObject:model];
                
            }
            _newsCollection = weakSelf.collections[index];
            weakSelf.newsCollection.data = lists;
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            NSLog(@"manager2:获取失败");
            
            
        }];

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
        self.navArr = dataArr;
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"manager1:获取失败");
        

    }];
    AFHTTPSessionManager *manager2 = [AFHTTPSessionManager manager];

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
        GoodsViewController *collView = _collections[0];
        collView.data = _listArr;
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
      
        NSLog(@"manager2:获取失败");
        
        
    }];

    
    
}
- (void)loadGoodsList{
    
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
    CGFloat offsetY = _bgScrollView.contentOffset.y;
    if (offsetY < 140) {
        
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
