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
#import "StahallValuationViewController.h"
#import "StahallFooterReusableView.h"
#import "ZSYPopoverListView.h"

@interface StarHallViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ZSYPopoverListDelegate,ZSYPopoverListDatasource,UITextFieldDelegate>
{

    UIButton *_arrowButton;
    
    
    NSMutableArray *recodeRotateExpend;//记录展开

    NSMutableArray *arrowButtonStatue;//记录arrowButton动画状态
    
    NSArray *popViewDateSource;
    
    UITextField *searchView;
    
}
@property (nonatomic,strong)ZSYPopoverListView *popView;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;//选择人数控件的参数
@end

@implementation StarHallViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    recodeRotateExpend =[NSMutableArray array];
    arrowButtonStatue =[NSMutableArray arrayWithObjects:@0,@0,@0, nil];
    
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"StaHallBackImage"].CGImage;

    
    /*title*/
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    title.text = @"艺人堂";
    title.textColor = [UIColor whiteColor];
    
    if(!self.isSearchMode){
    
        self.navigationItem.titleView = title;
        
    }else{//搜索模式
    
        searchView =[[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-120, 30)];
        searchView.layer.cornerRadius = 13;
      
        searchView.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"搜索艺人" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithWhite:0.65 alpha:0.8]}];
       
        searchView.backgroundColor =[UIColor whiteColor];
        self.navigationItem.titleView = searchView;
    }
    
    
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
    flowLayout.footerReferenceSize = CGSizeMake(self.view.bounds.size.width-20, 35);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    flowLayout.itemSize = CGSizeMake(65, 70);
 
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width-20, self.view.bounds.size.height-50-20-50) collectionViewLayout:flowLayout];
    
    [self.collectionView registerClass:[StaHallCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[StaHallCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[StahallFooterReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];

    self.collectionView.backgroundColor =[UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    
    //堂估价按钮455
    UIButton *Hallvaluation =[UIButton buttonWithType:UIButtonTypeCustom];
    Hallvaluation.frame = CGRectMake(10,self.view.bounds.size.height-115, self.view.bounds.size.width-20, 45);
    Hallvaluation.layer.cornerRadius = 3;
    [Hallvaluation setTitle:@"堂估价" forState:UIControlStateNormal];
    [Hallvaluation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Hallvaluation setBackgroundColor:[UIColor purpleColor]];
    [self.view addSubview:Hallvaluation];
    [Hallvaluation setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
    [Hallvaluation addTarget:self action:@selector(stahallValueButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}




#pragma mark - 创建section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    
    return [arrowButtonStatue count];
}

#pragma mark - 创建cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 18;
}




#pragma mark - 创建headerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    

   StaHallCollectionReusableView *reusableView = (StaHallCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    StahallFooterReusableView *reusableFooterView =(StahallFooterReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];

    if([kind isEqualToString:UICollectionElementKindSectionHeader]){//头部
    
        if(indexPath.section==0){
            
            reusableView.nameLabel.text = @"热门艺人";
            
        }else if (indexPath.section==1){
            
            reusableView.nameLabel.text = [NSString stringWithFormat:@"本地艺人【%@】",@"长沙"];
            
        }else{
            
            reusableView.nameLabel.text = @"推荐艺人";
            
        }
        
        reusableView.arrowButton.tag = indexPath.section+1000;
        
        if([arrowButtonStatue[indexPath.section] integerValue]){//展开
            
            [UIView animateWithDuration:0 animations:^{
                
                reusableView.arrowButton.transform = CGAffineTransformMakeRotation(M_PI_2);
            }];
            
        }else{//收起
            
            [UIView animateWithDuration:0 animations:^{
                
                reusableView.arrowButton.transform = CGAffineTransformMakeRotation(0);
            }];
            
        }
        
        [reusableView.arrowButton addTarget:self action:@selector(threeButtonsClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        /**
         *  @author frankfan, 14-12-18 14:12:17
         *
         *  分类按钮触发
         */
        
        
        reusableView.sortButton1.tag = indexPath.section+3000;
        reusableView.sortButton2.tag = indexPath.section+3001;
        reusableView.sortButton3.tag = indexPath.section+3002;
        
        [reusableView.sortButton1 addTarget:self action:@selector(sortButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [reusableView.sortButton2 addTarget:self action:@selector(sortButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [reusableView.sortButton3 addTarget:self action:@selector(sortButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if(indexPath.section==0){
        
            reusableView.sortButton1.hidden = YES;
            
            [reusableView.sortButton2 setTitle:@"热门1" forState:UIControlStateNormal];
            [reusableView.sortButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            reusableView.sortButton2.titleLabel.font =[UIFont systemFontOfSize:12];
            
            [reusableView.sortButton3 setTitle:@"热门2" forState:UIControlStateNormal];
            [reusableView.sortButton3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            reusableView.sortButton3.titleLabel.font =[UIFont systemFontOfSize:12];

        }else if (indexPath.section==1){
        
            [reusableView.sortButton1 setTitle:@"本地1" forState:UIControlStateNormal];
            [reusableView.sortButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            reusableView.sortButton1.titleLabel.font =[UIFont systemFontOfSize:12];

            
            [reusableView.sortButton2 setTitle:@"本地2" forState:UIControlStateNormal];
            [reusableView.sortButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            reusableView.sortButton2.titleLabel.font =[UIFont systemFontOfSize:12];
            
            [reusableView.sortButton3 setTitle:@"本地3" forState:UIControlStateNormal];
            [reusableView.sortButton3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            reusableView.sortButton3.titleLabel.font =[UIFont systemFontOfSize:12];
        
        }else{
        
            reusableView.sortButton1.hidden = YES;
            
            [reusableView.sortButton2 setTitle:@"推荐1" forState:UIControlStateNormal];
            [reusableView.sortButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            reusableView.sortButton2.titleLabel.font =[UIFont systemFontOfSize:12];
            
            [reusableView.sortButton3 setTitle:@"推荐2" forState:UIControlStateNormal];
            [reusableView.sortButton3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            reusableView.sortButton3.titleLabel.font =[UIFont systemFontOfSize:12];

        }
        
        
        return reusableView;
        
    }else{//尾部
    
        reusableFooterView.loadMoreButton.tag = indexPath.section+2000;
        
        
        [reusableFooterView.loadMoreButton addTarget:self action:@selector(loadMoreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        return reusableFooterView;
        
    }
    
    
    return nil;
    
}


#pragma mark - 显示POPView
- (void)showThePopViewWithTitle:(NSString *)titleString andDataSource:(NSArray *)dataSource{

    self.selectedIndexPath = nil;
    
    self.popView =[[ZSYPopoverListView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.popView.delegate = self;
    self.popView.datasource = self;

    
    [self.popView show];
    self.popView.titleName.text =titleString;
    popViewDateSource = dataSource;
    [self.popView reloadData];

}



#pragma mark 分类查询按钮触发
- (void)sortButtonClicked:(UIButton *)sender{

    if([sender.currentTitle isEqualToString:@"热门1"]){
    
        NSLog(@"热门1");
        popViewDateSource = @[@"热门1-1",@"热门1-1",@"热门1-3",@"热门1-4"];
       

        
    }else if ([sender.currentTitle isEqualToString:@"热门2"]){
    
        NSLog(@"热门2");
        popViewDateSource = @[@"热门1-2",@"热门1-2",@"热门1-2",@"热门1-2"];
      
        
    }else if ([sender.currentTitle isEqualToString:@"本地1"]){
    
        NSLog(@"本地1");
        popViewDateSource = @[@"本地1-1",@"本地1-2",@"本地1-3",@"热门1-4"];
       
        
    }else if ([sender.currentTitle isEqualToString:@"本地2"]){

        NSLog(@"本地2");
        popViewDateSource = @[@"本地2-1",@"本地2-2",@"本地2-3",@"本地2-4"];
       
        
    }else if ([sender.currentTitle isEqualToString:@"本地3"]){
        
        NSLog(@"本地3");
        popViewDateSource = @[@"本地3-1",@"本地3-2",@"本地3-3",@"本地3-4"];
    

        
    }else if([sender.currentTitle isEqualToString:@"推荐1"]){
    
        NSLog(@"推荐1");
        popViewDateSource = @[@"推荐1-1",@"推荐1-2",@"推荐1-3",@"推荐1-4"];
    
        
    }else{
    
        NSLog(@"推荐2");
        popViewDateSource = @[@"推荐2-1",@"推荐2-2",@"推荐2-3",@"推荐2-4"];
       

    }
   
    [self showThePopViewWithTitle:sender.currentTitle andDataSource:popViewDateSource];


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



#pragma mark - 堂估价按钮触发
- (void)stahallValueButtonClicked{

    StahallValuationViewController *stahallvaluation =[StahallValuationViewController new];
    [self.navigationController pushViewController:stahallvaluation animated:YES];

}

bool isExpand;
#pragma mark - 三个箭头button被点击
- (void)threeButtonsClicked:(UIButton *)sender{
    
    NSInteger index = sender.tag-1000;
    
    if(![arrowButtonStatue[index] integerValue]){//展开
        
        [arrowButtonStatue removeObjectAtIndex:index];
        [arrowButtonStatue insertObject:@1 atIndex:index];
        
        [UIView animateWithDuration:0.35 animations:^{
            
            sender.transform = CGAffineTransformMakeRotation(M_PI_2);
        }];
        
        isExpand = YES;
        
    }else{//收起
        
        [arrowButtonStatue removeObjectAtIndex:index];
        [arrowButtonStatue insertObject:@0 atIndex:index];
        
        [UIView animateWithDuration:0.35 animations:^{
            
            sender.transform = CGAffineTransformMakeRotation(0);
        }];

        isExpand = NO;
    }
    
    switch (sender.tag) {
        case 1000://热门艺人
            
            if(isExpand){//执行展开执行方法
            
            NSLog(@"热门艺人展开");
            }else{//展开收起执行方法
                
            NSLog(@"热门艺人收起");
            }
            
            
            
            
            break;
            
        case 1001://本地艺人
           
            if(isExpand){//执行展开执行方法
                
                NSLog(@"本地艺人展开");
            }else{//展开收起执行方法
                
                NSLog(@"本地艺人收起");
            }

            break;
            
        case 1002://推荐艺人
            
            if(isExpand){//执行展开执行方法
                
                NSLog(@"推荐艺人展开");
            }else{//展开收起执行方法
                
                NSLog(@"推荐艺人收起");
            }

            break;
            
    }
    
    
   
}


#pragma mark - 加载更多按钮触发
- (void)loadMoreButtonClicked:(UIButton *)sender{
    
    NSInteger indexTag = sender.tag;
    switch (indexTag) {
        case 2000://热门艺人加载
            
            NSLog(@"热门艺人加载更多");
            break;
            
        case 2001://本地艺人加载更多
            NSLog(@"本地艺人加载更多");
            break;
        case 2002://推荐艺人加载更多
            NSLog(@"推荐艺人加载更多");
            break;
    }


}

#pragma mark 弹出视图的相关代理
- (void)popoverListView:(ZSYPopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //fs_main_login_selected.png
    UITableViewCell *cell = [tableView popoverCellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"fs_main_login_selected.png"];
    self.selectedIndexPath = indexPath;
    [self.popView dismiss];
}

- (void)popoverListView:(ZSYPopoverListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{

   
    UITableViewCell *cell = [tableView popoverCellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"fs_main_login_normal.png"];

}



- (NSInteger)popoverListView:(ZSYPopoverListView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    return [popViewDateSource count];
}

- (UITableViewCell *)popoverListView:(ZSYPopoverListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusablePopoverCellWithIdentifier:identifier];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if ( self.selectedIndexPath && NSOrderedSame == [self.selectedIndexPath compare:indexPath])
    {
        cell.imageView.image = [UIImage imageNamed:@"fs_main_login_selected.png"];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"fs_main_login_normal.png"];
    }
    
    
    cell.textLabel.font =[UIFont systemFontOfSize:14];
    cell.textLabel.text = popViewDateSource[indexPath.row];
    return cell;
 


}





#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:76/255.0 green:60/255.0 blue:136/255.0 alpha:1]];
    

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
