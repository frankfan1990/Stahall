//
//  StarHallViewController.m
//  Stahall
//
//  Created by frankfan on 14/12/14.
//  Copyright (c) 2014年 Rching. All rights reserved.
//
//FIXME: 艺人堂模块-frankfan

#import "StarHallViewController.h"
#import "StaHallCollectionReusableView.h"
#import "StaHallCollectionViewCell.h"

@interface StarHallViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation StarHallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *staurBar =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    staurBar.backgroundColor = [UIColor colorWithRed:76/255.0 green:60/255.0 blue:136/255.0 alpha:1];
    [[[[UIApplication sharedApplication].keyWindow subviews]lastObject]addSubview:staurBar];
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"StaHallBackImage"].CGImage;
    
    /*title*/
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:76/255.0 green:60/255.0 blue:136/255.0 alpha:1]];
    self.navigationController.navigationBar.clipsToBounds = YES;
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    title.text = @"艺人堂";
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    /*回退*/
    UIButton *searchButton0 =[UIButton buttonWithType:UIButtonTypeCustom];
    searchButton0.tag = 10006;
    searchButton0.frame = CGRectMake(0, 0, 30, 30);
    [searchButton0 setImage:[UIImage imageNamed:@"朝左箭头icon"] forState:UIControlStateNormal];
    [searchButton0 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftitem =[[UIBarButtonItem alloc]initWithCustomView:searchButton0];
    self.navigationItem.leftBarButtonItem = leftitem;

    
#pragma mark - 创建collectionView模块
    /**
     *  @author frankfan, 14-12-15 08:12:52
     *
     *  开始创建collectionView模块
     */
    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    flowLayout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width-20, 50);
    
    flowLayout.itemSize = CGSizeMake(60, 60);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 5;
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width-20, self.view.bounds.size.height-50) collectionViewLayout:flowLayout];
    
    [self.collectionView registerClass:[StaHallCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[StaHallCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];

    self.collectionView.backgroundColor =[UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.showsVerticalScrollIndicator = NO;
    
}


#pragma mark - 创建section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    
    return 3;
}

#pragma mark - 创建cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 6;
}




#pragma mark - 创建headerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
   StaHallCollectionReusableView *reusableView = (StaHallCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    if(!reusableView){
    
        reusableView =[[StaHallCollectionReusableView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
        
    }
    
    if(indexPath.section==0){
    
        reusableView.nameLabel.text = @"热门艺人";
        
    }else if (indexPath.section==1){
        
        reusableView.nameLabel.text = @"本地艺人";
        
    }else{
    
        reusableView.nameLabel.text = @"推荐艺人";
    }
    
    
    
    return reusableView;

}


#pragma mark - 创建collectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    StaHallCollectionViewCell *cell =(StaHallCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor =[UIColor orangeColor];


    return cell;
}






#pragma mark - 导航栏事件触发
- (void)buttonClicked:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
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
