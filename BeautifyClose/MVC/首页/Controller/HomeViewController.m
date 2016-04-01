 //
//  HomeViewController.m
//  BeautifyClose
//
//  Created by ios on 15/12/6.
//  Copyright (c) 2015年 陈若男. All rights reserved.
//

#import "HomeViewController.h"
#import "NewsViewCell.h"
#import "BaseFlowLAyout.h"
#import "ListModel.h"
#import "BaseHeaderView.h"

#import "HeadModel.h"
#import "ListModel.h"




@interface HomeViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
       HMSegmentedControl *_hMItemCtrl;
    
}

@property (strong,nonatomic)UICollectionView *baseCollection;

//轮播图数据
@property (strong,nonatomic)NSArray *headerArr;
//标签栏数据
@property (nonatomic,strong)NSArray *navArr;

//商品列表数据
@property (strong,nonatomic)NSMutableArray *listArr;


@end

static NSString * const reuseIdentifier = @"Cell";
static NSString * const Header = @"baseHeader";
static NSString * const Segment = @"SegmentHeader";


@implementation HomeViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"descript" : @"description"
                 };
    }];
    
    //初始化背景collectionview
    [self _creatBGCollectionView];
    
    //加载网络数据
    [self loadData];
    
}



- (void)_creatBGCollectionView{
    
    BaseFlowLAyout *layout = [[BaseFlowLAyout alloc]initWithItem:CGSizeMake(160, 230) withScrollDirection:UICollectionViewScrollDirectionVertical withMinSpace:10 withMinLine:10];
    _baseCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
    
    _baseCollection.delegate = self;
    _baseCollection.dataSource = self;
    _baseCollection.backgroundColor = [UIColor whiteColor];
    
    [_baseCollection registerNib:[UINib nibWithNibName:@"NewsViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    [_baseCollection registerClass:[BaseHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:Header];
    
    [_baseCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:Segment];
    
    _baseCollection.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_baseCollection];


    
    
}


- (void)createGoodsViewWithTitleArr:(NSMutableArray *)arr{
    
    
    //头部控制的segMent
    _hMItemCtrl = [[HMSegmentedControl alloc]initWithSectionTitles:arr];
    _hMItemCtrl.frame = CGRectMake(0, 0, kScreenWidth, 44);
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
    

}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    
    NSInteger index = segmentedControl.selectedSegmentIndex;
    NSArray *arr = self.navArr[index][@"nav_cat_ids"];
    [self loadGoodsListWithPara:arr];
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}

#pragma mark --加载网络数据
- (void)loadData{
    
    NSMutableArray *arr = [NSMutableArray array];
    
    //轮播图
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api2.hichao.com/mall/banner" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        //解析网络数据
        NSArray *dataArr = responseObject[@"data"][@"items"];
        
        for(NSDictionary *dic in dataArr){
            
            HeadModel *model = [HeadModel mj_objectWithKeyValues:dic[@"component"]];
            [arr addObject:model];
        }
        
        self.headerArr = arr;
       

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"获取失败");
       
    }];
    
    //选项卡数据
    AFHTTPSessionManager *manager1 = [AFHTTPSessionManager manager];
    [manager1 GET:@"http://api2.hichao.com/region/recommend/tag" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.navArr = responseObject[@"data"][@"items"];
//        //加载今日上新的列表
//        _listArr = [NSMutableArray array];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"manager1:获取失败");
        

    }];
    
    
    
}

- (void)loadGoodsListWithPara:(NSArray *)paraArr{
    
    AFHTTPSessionManager *manager2 = [AFHTTPSessionManager manager];
    NSMutableArray *lists = [NSMutableArray array];
    NSDictionary *para = @{@"gv":@660,
                           @"category_ids":paraArr,
                           @"gf":@"android"
                           };
    
    [manager2 GET:@"http://api2.hichao.com/items" parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *dataArr = responseObject[@"data"][@"items"];
        for (NSDictionary *dic in dataArr) {
            
            ListModel *model = [ListModel mj_objectWithKeyValues: dic[@"component"]];
            [lists addObject:model];
            
        }
        self.listArr = lists;
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"manager2:获取失败");
        
        
    }];

}
//复写data方法
- (void)setHeaderArr:(NSMutableArray *)headerArr{
    
    if (_headerArr != headerArr) {
        _headerArr = headerArr;
    }
    [self.baseCollection reloadData];
    
}

//商品种类标题
- (void)setNavArr:(NSArray *)navArr{
    
      _navArr = navArr;
    //取出标题 , 创建选项卡
     NSMutableArray *titles = [[NSMutableArray alloc]init];
     for (NSDictionary *dic in navArr) {
        
        [titles addObject:dic[@"nav_name"]];
    }
    
    [self createGoodsViewWithTitleArr:titles];
    [self loadGoodsListWithPara:_navArr[0][@"nav_cat_ids"]];
    [self.baseCollection reloadData];


    
}


- (void)setListArr:(NSMutableArray *)listArr{
    
    _listArr = listArr;
    [self.baseCollection reloadData];
    
    
}

#pragma mark --<UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 0;
    }
    
    return _listArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ListModel *model = self.listArr[indexPath.item];
    cell.model = model;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item == 0) {
        BaseHeaderView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:Header forIndexPath:indexPath];
        headView.headimgArr = (NSMutableArray *)self.headerArr;
        
        
        return headView;
    }
        UICollectionReusableView *segmentView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:Segment forIndexPath:indexPath];
        segmentView.backgroundColor = [UIColor redColor];
        [segmentView addSubview:_hMItemCtrl];
        
        
        return segmentView;
   
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return CGSizeMake(self.view.width, 180);

    }
    return CGSizeMake(self.view.width, _hMItemCtrl.height);
    
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    UIEdgeInsets edge = UIEdgeInsetsMake(5, 10, 5, 10);
    return edge;
    
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
