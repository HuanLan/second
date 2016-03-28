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

@interface GoodsViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectionView;

@end

static NSString * const reuseIdentifier = @"Cell";


@implementation GoodsViewController

- (instancetype)initWithFrame:(CGRect)frame{
    
    BaseFlowLAyout *flow = [[BaseFlowLAyout alloc]initWithItem:CGSizeMake(130, 180) withScrollDirection:UICollectionViewScrollDirectionVertical withMinSpace:0 withMinLine:10];
    //
    if (self = [super initWithFrame:frame collectionViewLayout:flow]) {
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    return self;
    
    
    //    [self.collectionView registerNib:[UINib nibWithNibName:@"NewsViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
   
    
}

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
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
