//
//  StarDetailInfoViewController.m
//  Stahall
//
//  Created by frankfan on 15/2/27.
//  Copyright (c) 2015年 Rching. All rights reserved.
//
//FIXME: 艺人详情【改版】
#import "StarDetailInfoViewController.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+AddTitle.h"

@interface StarDetailInfoViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{

    UIImageView *_backStarImage;
    @private
    UIView *_bottomBlackView;
    NSArray *_itemTitleList1;
    NSArray *_itemTitleList2;
    
    
}

@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation StarDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    //
    /*title*/
    [self setTheTitle:@"艺人姓名"];
    
    /*回退按钮*/
    [self setTheBackArrow];
    //
    _backStarImage =[[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_backStarImage];
    
    //demo
    _backStarImage.image =[UIImage imageNamed:@"汪峰"];
    _itemTitleList1 = @[@"Rock",@"资料",@"影像",@"演出",@"音乐",@"视频"];
    _itemTitleList2 = @[@"首支单曲",@"自由 摇滚 先锋",@"一些照片",@"perform",@"music",@"video"];
    
    //
    _bottomBlackView =[[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-300, self.view.bounds.size.width, 300)];
    _bottomBlackView.backgroundColor =[UIColor colorWithWhite:0.1 alpha:0.89];
    [self.view addSubview:_bottomBlackView];
    
    //创建collectionview
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width/3.0-20, 80);
    flowLayout.minimumLineSpacing = 35;
    
    self.collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(10, 20, self.view.bounds.size.width-20, 280) collectionViewLayout:flowLayout];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
  
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor =[UIColor clearColor];
    [_bottomBlackView addSubview:self.collectionView];
    
    
    
    // Do any additional setup after loading the view.
}


#pragma mark - collectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 6;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *collcetionCell =[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];

    collcetionCell.backgroundColor =[UIColor clearColor];
    if(indexPath.row==1 || indexPath.row==4){
    
        UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 10, 1, 60)];
        lineView.backgroundColor =[UIColor whiteColor];
        
        UIView *lineView2 =[[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/3.0-20-1, 10, 1, 60)];
        lineView2.backgroundColor =[UIColor whiteColor];
        
        [collcetionCell addSubview:lineView];
        [collcetionCell addSubview:lineView2];
    }
    
    //大标题
    UILabel *itemLable1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 16,self.view.bounds.size.width/3.0-40, 30)];
    itemLable1.textAlignment = NSTextAlignmentCenter;
    itemLable1.textColor =[UIColor whiteColor];
    itemLable1.font =[UIFont systemFontOfSize:14];
    [collcetionCell.contentView addSubview:itemLable1];
    itemLable1.text = _itemTitleList1[indexPath.row];
    
    
    //小标题
    UILabel *itemLable2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 16+20,self.view.bounds.size.width/3.0-40, 30)];
    itemLable2.textAlignment = NSTextAlignmentCenter;
    itemLable2.textColor =[UIColor whiteColor];
    itemLable2.font =[UIFont systemFontOfSize:9];
    [collcetionCell.contentView addSubview:itemLable2];
    itemLable2.text = _itemTitleList2[indexPath.row];
    
    
    return collcetionCell;

}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    self.comebackStatu = @"comeBack";
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
