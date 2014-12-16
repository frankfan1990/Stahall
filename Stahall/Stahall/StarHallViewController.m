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
{

    UIButton *arrowButton1;
    UIButton *arrowButton2;
    UIButton *arrowButton3;
    
    
    NSMutableArray *recodeRotateExpend;//记录展开
//    NSMutableArray *recodeColla;//记录收起
}
@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation StarHallViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    recodeRotateExpend =[NSMutableArray array];
//    recodeColla =[NSMutableArray array];
    
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"StaHallBackImage"].CGImage;

    
    /*title*/
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:76/255.0 green:60/255.0 blue:136/255.0 alpha:1]];
    
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
    
    flowLayout.itemSize = CGSizeMake(65, 70);
 
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width-20, self.view.bounds.size.height-50-20-50) collectionViewLayout:flowLayout];
    
    [self.collectionView registerClass:[StaHallCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[StaHallCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];

    self.collectionView.backgroundColor =[UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    
    //堂估价按钮
    UIButton *Hallvaluation =[UIButton buttonWithType:UIButtonTypeCustom];
    Hallvaluation.frame = CGRectMake(10,455, self.view.bounds.size.width-20, 45);
    Hallvaluation.layer.cornerRadius = 3;
    [Hallvaluation setTitle:@"堂估价" forState:UIControlStateNormal];
    [Hallvaluation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Hallvaluation setBackgroundColor:[UIColor purpleColor]];
    [self.view addSubview:Hallvaluation];
    [Hallvaluation setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
  
}




#pragma mark - 创建section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    
    return 3;
}

#pragma mark - 创建cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 18;
}




#pragma mark - 创建headerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
   StaHallCollectionReusableView *reusableView = (StaHallCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];

    
    
    if(indexPath.section==0){
    
        reusableView.nameLabel.text = @"热门艺人";
        
        
    }else if (indexPath.section==1){
        
        reusableView.nameLabel.text = @"本地艺人";
        
    }else{
    
        reusableView.nameLabel.text = @"推荐艺人";
        
    }
    
    [reusableView.arrowButton addTarget:self action:@selector(threeButtonsClicked:) forControlEvents:UIControlEventTouchUpInside];
    
  
    
    return reusableView;

}


#pragma mark - reusableView将要出现
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    
    UIButton *arrowButton = (UIButton *)[[[view subviews]firstObject] subviews][0];
    UIView *superView = [arrowButton superview];
    
    
    
}




#pragma mark - 创建collectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    StaHallCollectionViewCell *cell =(StaHallCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
#warning fake date
    
    if(indexPath.row%2==0){
        
        cell.zoneDot.backgroundColor =[UIColor magentaColor];
        cell.starImage.image =[UIImage imageNamed:@"七夕"];
        cell.starName.text = @"汪峰";
        
        
    }else{
    
        cell.zoneDot.backgroundColor =[UIColor greenColor];
        cell.starImage.image =[UIImage imageNamed:@"张杰"];
        cell.starName.text = @"刘德华";
    }

    

    
    return cell;
}



#pragma mark - 三个箭头button被点击
- (void)threeButtonsClicked:(UIButton *)sender{

    sender.selected = !sender.selected;

  
    if(sender.tag==3001){
        
        
        if(sender.selected){//展开
            
        }else{//收起

        }
        NSLog(@"热门艺人");
        
      
    }else if (sender.tag==3002){
    
        if(sender.selected){//展开
           
            
        }else{//收起
        
            
        }
        
        NSLog(@"本地艺人");
        
    }else{
    
        if(sender.selected){//展开
        
        
        }else{//收起
        
         
        
        }
        
        NSLog(@"推荐艺人");
    }

}





#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = NO;
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
