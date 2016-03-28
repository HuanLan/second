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

@interface HomeViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic)HeadScrollView *headScrollView;

@property (strong,nonatomic)UICollectionView *newsCollection;

@property (strong, nonatomic)UIPageControl *HpageCtrl;
@property (nonatomic,strong)NSTimer *timer;


@end

@implementation HomeViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    [self.view addSubview:_bgScrollView];
    
    [self createHeadView];
    [self createNewView];
    // Do any additional setup after loading the view.
    [self loadData];
    
}



- (void)createHeadView{
    
//    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kheadViewHeight)];
//    [self.bgScrollView addSubview:_headView];
//
    //滑动视图
    _headScrollView = [[HeadScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kheadViewHeight)];
    _headScrollView.delegate = self ;
    _headScrollView.backgroundColor = [UIColor yellowColor];
    
    //分页
    _HpageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake((kScreenWidth-150)/2.0, _headScrollView.bottom-20, 150, 20)];
    [_bgScrollView addSubview:_headScrollView];
    [_bgScrollView addSubview:_HpageCtrl];

    
    
}


- (void)createNewView{
    
    BaseFlowLAyout *flow = [[BaseFlowLAyout alloc]initWithItem:CGSizeMake(80, 100) withScrollDirection:UICollectionViewScrollDirectionHorizontal withMinSpace:0 withMinLine:10];
    
    _newsCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _headScrollView.bottom, kScreenWidth, 100) collectionViewLayout:flow];
    
    [_bgScrollView addSubview:_newsCollection];
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
    
}

//复写data方法
- (void)setData:(NSMutableArray *)data{
    if (_data != data) {
        _data = data;
    }
    
    [_headScrollView createWithPageCount:_data.count];
    [self loadDataWithHeadScrollView];

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
    int page = (offsetX +kScreenWidth/2)/kScreenWidth;
    _HpageCtrl.currentPage = page;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self addTimer];
    
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
