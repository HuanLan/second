//
//  GoodsViewController.m
//  BeautifyClose
//
//  Created by 陈 on 16/3/28.
//  Copyright © 2016年 陈若男. All rights reserved.
//

#import "GoodsViewController.h"
#import "NewsViewCell.h"
#import "BaseFlowLAyout.h"
#import "ListModel.h"
#import <CoreText/CoreText.h>

@interface GoodsViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectionView;

@end

static NSString * const reuseIdentifier = @"Cell";


@implementation GoodsViewController

- (instancetype)initWithFrame:(CGRect)frame{
    
    BaseFlowLAyout *flow = [[BaseFlowLAyout alloc]initWithItem:CGSizeMake(160, 230) withScrollDirection:UICollectionViewScrollDirectionVertical withMinSpace:0 withMinLine:10];
    //
    if (self = [super initWithFrame:frame collectionViewLayout:flow]) {
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerNib:[UINib nibWithNibName:@"NewsViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];    }
    return self;
    
    
    
   
    
}


- (void)setParaArr:(NSArray *)paraArr{
    
    _paraArr = paraArr;
    
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
        self.data = lists;
        
    
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"manager2:获取失败");
        
        
    }];


}

- (void)setData:(NSMutableArray *)data{
    
    _data = data;
    [self reloadData];
}

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ListModel *model = self.data[indexPath.item];
    cell.goodName.text = model.descript;
    cell.goodPrice.attributedText = [self joinStr:model.price withStr:model.origin_price ];
    [cell.goodImgView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    
//    cell.backgroundColor = [UIColor redColor];
    return cell;
}



- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    UIEdgeInsets edge = UIEdgeInsetsMake(5, 10, 5, 10);
    return edge;
    
}

- (NSMutableAttributedString *)joinStr:(NSString *)price withStr:(NSString *)origin_str{
    
    NSDictionary *priceDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               [UIFont systemFontOfSize:16.0],NSFontAttributeName,
                               [UIColor magentaColor],NSForegroundColorAttributeName,
                               nil];
    NSDictionary *originDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont systemFontOfSize:13.0],NSFontAttributeName,
                                [UIColor grayColor],NSForegroundColorAttributeName,
                                @(NSUnderlinePatternSolid | NSUnderlineStyleSingle) ,NSStrikethroughStyleAttributeName,

                                nil];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"$%@", price] attributes:priceDict];
    NSAttributedString *str2 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"$%@",origin_str] attributes:originDict];
    
  
    
    [attrStr appendAttributedString:str2];
    
    return attrStr;
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
