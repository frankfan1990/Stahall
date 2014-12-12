//
//  MainViewController.m
//  Stahall
//
//  Created by frankfan on 14/12/9.
//  Copyright (c) 2014年 Rching. All rights reserved.
//
#pragma mark - 这里是首页

#import "MainViewController.h"
#import "CycleScrollView.h"
#import "Marcos.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    NSArray *arrOfTitle;
    NSArray *arrOfTitleOther;
    int a;
    CycleScrollView *headScrollView;
}

@property (nonatomic,strong)UITableView *tableView;//主页骨架
@property (nonatomic,strong)NSMutableArray *arrOfimages_one; // 第一个cell里的图片
@property (nonatomic,strong) NSMutableArray *arrOfLabelContent_one;//第一个cell里的图片里的label的内容
@end

@implementation MainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBar];
    [self Variableinitialization];
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"MainViewBackImage"].CGImage;
    
    //导航头部-在这里添加导航栏UI
    //    UIView *navigationHeaderView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    //    navigationHeaderView.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:navigationHeaderView];
    
    /**
     *  @author frankfan, 14-12-12 00:12:20
     *
     *  开始创建tableView,构建骨架，5个section
     */
    
    headScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(20, 20, Mywidth-40, 220) animationDuration:-1];
    headScrollView.backgroundColor = [UIColor clearColor];
    __weak typeof (self)Myself = self;
    headScrollView.totalPagesCount = ^NSInteger(void){
        return Myself.arrOfimages_one.count;
    };
    headScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Myself.view.frame.size.width-40, 180)];
        imageV.image = [UIImage imageNamed:Myself.arrOfimages_one[pageIndex]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, Myself.view.frame.size.width-40, 40)];
        label.text = Myself.arrOfLabelContent_one[pageIndex];

        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        label.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
        label.textColor = [UIColor whiteColor];
        label.adjustsFontSizeToFitWidth = YES;
        [imageV addSubview:label];
        return imageV;
    };
    headScrollView.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"%ld",(long)pageIndex);
    };
    
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =[UIColor clearColor];
    self.tableView.sectionHeaderHeight = 0.1;
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark - 变量的初始化
-(void)Variableinitialization
{
    _arrOfimages_one = [NSMutableArray arrayWithObjects:@"七夕",@"七夕",@"七夕",@"七夕",nil];
    _arrOfLabelContent_one = [NSMutableArray arrayWithObjects:@"《七夕恋爱》电影选角艺人堂专场",@"《七夕恋爱》电影选角艺人堂专场",@"《七夕恋爱》电影选角艺人堂专场",@"《七夕恋爱》电影选角艺人堂专场", nil];
    arrOfTitle = @[@"预告",@"案例",@"行程"];
    arrOfTitleOther = @[@"PREVUE",@"SHOW",@"SHOW"];
    a = 0;
    
}
#pragma mark - TabBar的设置
-(void)setTabBar
{
    self.navigationController.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    self.navigationController.navigationBar.translucent = YES;
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLeft.layer.masksToBounds = YES;
    btnLeft.layer.cornerRadius = 20;
    [btnLeft setFrame:CGRectMake(0, 0, 40, 40)];
    [btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"拍照.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"拍照.png"] forState:UIControlStateHighlighted];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(didGoLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"面包"]  forState:UIControlStateNormal];
    
    
    [btn2 setFrame:CGRectMake(0, 5, 40, 45)];;
    [btn2 addTarget:self action:@selector(didSearch) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    UIBarButtonItem *btnright = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        self.navigationItem.rightBarButtonItems= @[negativeSpacer, btnright];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
        self.navigationItem.rightBarButtonItem = btnright;
    }
    
    CGRect rect = CGRectMake(0, 7, 210, 30);
    UIView *topview=[[UIView alloc] initWithFrame:rect];
    topview.layer.masksToBounds=YES;
    topview.backgroundColor = [UIColor blackColor];
    topview.layer.cornerRadius=15;
    self.navigationItem.titleView = topview;
    self.navigationItem.titleView.alpha = 0.2;
    
}

#pragma mark - 创建分段个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

#pragma mark - 每个分段里的cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

#pragma mark - 每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 220;
    }else if(indexPath.section == 1){
        return 80;
    }else if(indexPath.section == 2){
        return 180;
    }
    return 100;
}
#pragma mark - 每个section的headView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section > 1) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 53)];
        headView.backgroundColor = [UIColor clearColor];
        UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 45, 20)];
        labelTitle.text = arrOfTitle[section-2];
        labelTitle.textColor = [UIColor whiteColor];
        labelTitle.font = [UIFont systemFontOfSize:19];
        labelTitle.textAlignment = NSTextAlignmentLeft;
        [headView addSubview:labelTitle];
        
        UILabel *labelTitleOther = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 100, 15)];
        labelTitleOther.text = arrOfTitleOther[section-2];
        labelTitleOther.textColor = [UIColor whiteColor];
        labelTitleOther.font = [UIFont systemFontOfSize:11];
        labelTitleOther.textAlignment = NSTextAlignmentLeft;
        [headView addSubview:labelTitleOther];
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"向右灰"]];
        imageV.frame = CGRectMake(labelTitle.frame.origin.x + labelTitle.frame.size.width, 12, 17, 17);
        imageV.layer.masksToBounds = YES;
        imageV.layer.cornerRadius = imageV.frame.size.width/2;
        imageV.backgroundColor = [UIColor whiteColor];
        imageV.alpha = 0.6;
        [headView addSubview:imageV];
        return headView;
    }else{
        return nil;
    }
}
#pragma mark - 每个headView的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section >1) {
        return 53;
    }else{
        return 0.1;
    }
}

#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        UITableViewCell *cell_One = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell_One.backgroundColor =[UIColor clearColor];
        cell_One.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell_One addSubview:headScrollView];
        return cell_One;
    }
    else if (indexPath.section == 1) {
        UITableViewCell *cell_two = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell_two.backgroundColor = [UIColor clearColor];
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
        btn1.frame = CGRectMake(10, 10, (Mywidth - 50)/3, 80);
        btn2.frame = CGRectMake(btn1.frame.origin.x+15 + (Mywidth - 50)/3, 10, (Mywidth - 50)/3, 80);
        btn3.frame = CGRectMake(btn2.frame.origin.x+15 + (Mywidth - 50)/3, 10, (Mywidth - 50)/3, 80);
        
        btn1.backgroundColor = [UIColor colorWithRed:20/255.0 green:148/255.0 blue:255/255.0 alpha:1];
        btn2.backgroundColor = [UIColor colorWithRed:116/255.0 green:74/255.0 blue:230/255.0 alpha:1];
        btn3.backgroundColor = [UIColor colorWithRed:84/255.0 green:214/255.0 blue:154/255.0 alpha:1];
        
        btn1.layer.masksToBounds = YES;
        btn1.layer.cornerRadius  = 3;
        btn2.layer.masksToBounds = YES;
        btn2.layer.cornerRadius  = 3;
        btn3.layer.masksToBounds = YES;
        btn3.layer.cornerRadius  = 3;
        
        [btn1 addTarget:self action:@selector(didBtn1:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 addTarget:self action:@selector(didBtn2:) forControlEvents:UIControlEventTouchUpInside];
        [btn3 addTarget:self action:@selector(didBtn3:) forControlEvents:UIControlEventTouchUpInside];
        [cell_two.contentView addSubview:btn1];
        [cell_two.contentView addSubview:btn2];
        [cell_two.contentView addSubview:btn3];
        return cell_two;
    }
    else if (indexPath.section == 2){
        
        UITableViewCell *cell_there = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell_there.selectionStyle = UITableViewCellSelectionStyleNone;
        cell_there.backgroundColor = [UIColor clearColor];
        UICollectionViewFlowLayout *layoutView = [[UICollectionViewFlowLayout alloc] init];
        layoutView.itemSize = CGSizeMake(Mywidth-10, 160);
    
        [layoutView setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        
        UICollectionView *collectionView= [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, Mywidth, 160) collectionViewLayout:layoutView];
        collectionView.pagingEnabled = YES;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionViewCell_One"];
        [cell_there addSubview:collectionView];
        return cell_there;
    }
    
    static NSString *cellName = @"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellName];
    if(!cell){
        
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.backgroundColor =[UIColor clearColor];
        cell.selectionStyle = NO;
        
    }
    
    return cell;
    
}


#pragma mark - UICollectionView的代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell_one = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionViewCell_One" forIndexPath:indexPath];

    UIImageView *imageV = [[UIImageView alloc] init];
    
    if (indexPath.row == 3) {
        [cell_one.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        imageV.frame = CGRectMake(0, 0,Mywidth-20, 160);
    }else{
         [cell_one.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
         imageV.frame = CGRectMake(10, 0,Mywidth-20, 160);
    }
    
    imageV.image = [UIImage imageNamed:@"陈奕迅"];
    [cell_one addSubview:imageV];

    return cell_one;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
}
#pragma mark - 左上角按钮 跳到侧滑栏
-(void)didGoLeftMenu
{
    
}

#pragma mark - 右上角按钮 跳到搜索艺人的页面
-(void)didSearch
{
    
}
#pragma mark - 去 堂汇页面 按钮
-(void)didBtn1:(UIButton *)sender{
    NSLog(@"去 堂汇页面 按钮");
}
#pragma mark - 去 艺人堂页面 按钮
-(void)didBtn2:(UIButton *)sender{
    NSLog(@"去 艺人堂页面 按钮");
}
#pragma mark - 去 秀MALL页面 按钮
-(void)didBtn3:(UIButton *)sender{
    NSLog(@"去 秀MALL页面 按钮");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 根据字长算 高度或宽度
- (CGFloat)caculateTheTextHeight:(NSString *)string andFontSize:(int)fontSize andDistance:(int)distance{
    
    /*非彻底性封装*/
    CGSize constraint = CGSizeMake(self.view.bounds.size.width-distance, CGFLOAT_MAX);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:string
     attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    return size.height;
}
- (CGFloat)caculateTheTextWidth:(NSString *)string andFontSize:(int)fontSize andDistance:(int)distance{
    
    /*非彻底性封装*/
    CGSize constraint = CGSizeMake( CGFLOAT_MAX,distance);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:string
     attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    return size.width;
}

@end
