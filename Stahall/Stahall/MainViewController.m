//
//  MainViewController.m
//  Stahall
//
//  Created by frankfan on 14/12/9.
//  Copyright (c) 2014年 Rching. All rights reserved.
//
#pragma mark - 这里是首页

#import "MainViewController.h"
#import "LeftMenuViewController.h"
#import "LeftMenuViewController.h"
#import "StarHallViewController.h"
#import "AdvanceNoticeViewController.h"
#import "ShowDetailsViewController.h"
#import "ShowMallsViewController.h"
#import "CCSegmentedControl.h"
#import "CycleScrollView.h"
#import "RESideMenu.h"
#import "Marcos.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    NSArray *arrOfTitle;
    NSArray *arrOfTitleOther;
    NSArray *arrOfSegmentTitle;
    CycleScrollView *headScrollView;
    CCSegmentedControl *segmentCtrl;
    UICollectionView *collectionViewOther;
    NSInteger _type;
    
}

@property (nonatomic,strong)UITableView *tableView;//主页骨架
@property (nonatomic,strong)NSMutableArray *arrOfimages_one; // 第一个cell里的图片
@property (nonatomic,strong) NSMutableArray *arrOfLabelContent_one;//第一个cell里的图片里的label的内容
@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBar];
    [self Variableinitialization];
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"MainViewBackImage"].CGImage;
    
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
    
#pragma mark - 点击轮播图
    headScrollView.TapActionBlock = ^(NSInteger pageIndex){
        
        ShowDetailsViewController *details = [[ShowDetailsViewController alloc] init];
        details.titleViewStr  = @"海报详情";
        details.type = 1;
        [Myself.navigationController pushViewController:details animated:YES];
        NSLog(@"%ld",(long)pageIndex);
    };
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height-65) style:UITableViewStyleGrouped];
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
    _type = 0;
    _arrOfimages_one = [NSMutableArray arrayWithObjects:@"七夕",@"七夕",@"七夕",@"七夕",nil];
    _arrOfLabelContent_one = [NSMutableArray arrayWithObjects:@"《七夕恋爱》电影选角艺人堂专场",@"《七夕恋爱》电影选角艺人堂专场",@"《七夕恋爱》电影选角艺人堂专场",@"《七夕恋爱》电影选角艺人堂专场", nil];
    arrOfSegmentTitle = @[@"演唱会",@"舞台剧",@"企业活动"];
    arrOfTitle = @[@"预告",@"案例",@"行程"];
    arrOfTitleOther = @[@"PREVUE",@"SHOW",@"SHOW"];
    
}

#pragma mark - TabBar的设置
-(void)setTabBar
{
    UIView *tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 65)];
    tabBarView.backgroundColor = [UIColor clearColor];
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLeft.layer.masksToBounds = YES;
    [btnLeft setFrame:CGRectMake(10, 17, 48, 48)];
     btnLeft.layer.cornerRadius = btnLeft.frame.size.width/2;
    [btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"lc汪峰头像.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"lc汪峰头像.png"] forState:UIControlStateHighlighted];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(didGoLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:btnLeft];
    
    CGRect rect = CGRectMake(Mywidth/2-95+2,25, 200, 30);
    UIView *topview=[[UIView alloc] initWithFrame:rect];
    topview.layer.masksToBounds=YES;
    topview.backgroundColor = [UIColor purpleColor];
    topview.alpha = 0.4;
    topview.layer.cornerRadius=15;
    [tabBarView addSubview:topview];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"面包"]  forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(Mywidth-45, 15, 40, 45)];
    [btn2 addTarget:self action:@selector(didSearch) forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:btn2];
    [self.view  addSubview:tabBarView];
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
        return 90;
    }else{
        return 175;
    }
}
#pragma mark - 每个section的headView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section > 1) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 53)];
        headView.backgroundColor = [UIColor clearColor];
        
        UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 45, 20)];
        [self Customlable:labelTitle text:arrOfTitle[section-2] fontSzie:19 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:YES numberOfLines:1];
        
        [headView addSubview:labelTitle];
        
        UILabel *labelTitleOther = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 100, 15)];
        
        [self Customlable:labelTitleOther text:arrOfTitleOther[section-2] fontSzie:11 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:YES numberOfLines:1];
        
        [headView addSubview:labelTitleOther];
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lc向右灰"]];
        imageV.frame = CGRectMake(labelTitle.frame.origin.x + labelTitle.frame.size.width, 12, 17, 17);
        imageV.layer.masksToBounds = YES;
        imageV.layer.cornerRadius = imageV.frame.size.width/2;
        imageV.backgroundColor = [UIColor whiteColor];
        imageV.alpha = 0.6;
        [headView addSubview:imageV];
        if (section == 4) {
            segmentCtrl = [[CCSegmentedControl alloc] initWithItems:arrOfSegmentTitle];
            segmentCtrl.frame = CGRectMake(imageV.frame.origin.x+imageV.frame.size.width +40, 10, Mywidth-(imageV.frame.origin.x+imageV.frame.size.width +50), 30);
            segmentCtrl.segmentTextColor = [UIColor whiteColor];
            segmentCtrl.selectedSegmentTextColor = [UIColor orangeColor];
            segmentCtrl.backgroundColor = [UIColor clearColor];
            UIImageView *selecImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lc2"]];
            [segmentCtrl addTarget:self action:@selector(didSegment:) forControlEvents:UIControlEventValueChanged];
            segmentCtrl.selectedStainView = selecImageView;
            [headView addSubview:segmentCtrl];
        }
        
        UIButton *headBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, imageV.frame.size.width+imageV.frame.origin.x+20, 53)];
        headBtn.tag = 66666+section;
        headBtn.backgroundColor = [UIColor clearColor];
        [headBtn addTarget:self action:@selector(didHeadBtn:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:headBtn];
        return headView;
    }else{
        return nil;
    }
}
#pragma mark - 每个headView的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section >1) {
        return 45;
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
        cell_two.selectionStyle = UITableViewCellSelectionStyleNone;
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
        
        [btn1 setTitle:@"堂汇" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn2 setTitle:@"艺人堂" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn3 setTitle:@"秀MALL" forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [btn1.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn2.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn3.titleLabel setFont:[UIFont systemFontOfSize:15]];
        
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
        layoutView.itemSize = CGSizeMake(Mywidth-10, 165);
        [layoutView setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        UICollectionView *_collectionView= [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, Mywidth, 165) collectionViewLayout:layoutView];
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.tag = 10002;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"My_collectionViewCell_One"];
        [cell_there addSubview:_collectionView];
        return cell_there;
    }
    else if (indexPath.section == 3){
        
        UITableViewCell *cell_four = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell_four.selectionStyle = UITableViewCellSelectionStyleNone;
        cell_four.backgroundColor = [UIColor clearColor];
        UICollectionViewFlowLayout *layoutView = [[UICollectionViewFlowLayout alloc] init];
        layoutView.itemSize = CGSizeMake(130, 170);
        [layoutView setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        UICollectionView *_collectionView= [[UICollectionView alloc] initWithFrame:CGRectMake(10, 10, Mywidth-20, 170) collectionViewLayout:layoutView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.tag = 10003;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"My_collectionViewCell_Two"];
        [cell_four addSubview:_collectionView];
        return cell_four;
    }
    else{
        UITableViewCell *cell_five = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell_five.selectionStyle = UITableViewCellSelectionStyleNone;
        cell_five.backgroundColor = [UIColor clearColor];
        UICollectionViewFlowLayout *layoutView = [[UICollectionViewFlowLayout alloc] init];
        layoutView.itemSize = CGSizeMake(Mywidth-10, 175);
        [layoutView setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        UICollectionView *_collectionView= [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, Mywidth, 175) collectionViewLayout:layoutView];
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.tag = 10004;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"My_collectionViewCell_There"];
        [cell_five addSubview:_collectionView];
        return cell_five;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - UICollectionView的代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 10002) {
        
        UICollectionViewCell *cell_one = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"My_collectionViewCell_One" forIndexPath:indexPath];
        
        UIImageView *imageV = [[UIImageView alloc] init];
        if (indexPath.row == 3) {
            [cell_one.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            imageV.frame = CGRectMake(0, 0,Mywidth-20, 165);
        }else{
            [cell_one.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            imageV.frame = CGRectMake(10, 0,Mywidth-20, 165);
        }
        imageV.image = [UIImage imageNamed:@"陈奕迅"];
        UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(0,165-73, Mywidth-20, 73)];
        labelView.backgroundColor = [UIColor blackColor];
        labelView.alpha = 0.8;
        
        UILabel *labelOfName = [[UILabel alloc] initWithFrame:CGRectMake(15, 5+3, Mywidth-20-15, 25)];
        UILabel *labelOfAddress = [[UILabel alloc] initWithFrame:CGRectMake(15, 30+3, Mywidth-20-15, 15)];
        UILabel *labelOfDate = [[UILabel alloc] initWithFrame:CGRectMake(15, 45+3, Mywidth-20-15, 20)];
        
        [self Customlable:labelOfName text:@"陈奕迅 EASON'S LIFE" fontSzie:15 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:YES numberOfLines:1];
        [self Customlable:labelOfAddress text:@"湖南 长沙  贺龙体育馆" fontSzie:12 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:YES numberOfLines:1];
        [self Customlable:labelOfDate text:@"12月25日 8:30" fontSzie:12 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:YES numberOfLines:1];
        
        [labelView addSubview:labelOfName];
        [labelView addSubview:labelOfAddress];
        [labelView addSubview:labelOfDate];
        
        [imageV addSubview:labelView];
        [cell_one addSubview:imageV];
        return cell_one;
        
    }
    else if (collectionView.tag == 10003) {
        UICollectionViewCell *cell_two = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"My_collectionViewCell_Two" forIndexPath:indexPath];
        
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.frame = CGRectMake(0, 0,120, 170);
        imageV.image = [UIImage imageNamed:@"张杰"];
        [cell_two addSubview:imageV];
        
        return cell_two;
    }
    else{
        UICollectionViewCell *cell_one = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"My_collectionViewCell_There" forIndexPath:indexPath];
        
        UIView *view = [[UIView alloc] init];
        if (indexPath.row == 3) {
            [cell_one.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            view.frame = CGRectMake(0, 0,Mywidth-20, 175);
        }else{
            [cell_one.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            view.frame = CGRectMake(10, 0,Mywidth-20, 175);
        }
        view.backgroundColor = [UIColor colorWithRed:115/255.0 green:72/255.0 blue:241/255.0 alpha:1];
        [cell_one addSubview:view];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width/2-15, view.frame.size.height)];
        if (_type == 0) {
            imageV.image = [UIImage imageNamed:@"甲壳虫"];
        }else if (_type == 1){
            imageV.image = [UIImage imageNamed:@"汪峰"];
        }else if (_type == 2){
            imageV.image = [UIImage imageNamed:@"张杰"];
        }
        
        [view addSubview:imageV];
        
        NSString *titleStr = @"汪峰 2014-2015 ”峰暴来临“ 超级巡回演唱会";
        
        //固定高度不能超过 父视图的一半
        CGFloat height = [self caculateTheTextHeight:titleStr andFontSize:15 andDistance:view.frame.size.width-imageV.frame.size.width-30];
        CGFloat heigeh0 = 20;
        if (height > view.frame.size.height-100) {
            height = view.frame.size.height-100;
            heigeh0 = 10;
        }
        
        UILabel *labelOfTitle = [[UILabel alloc] initWithFrame:CGRectMake(imageV.frame.size.width+15, 10, view.frame.size.width-imageV.frame.size.width-30,height)];
        [self Customlable:labelOfTitle text:titleStr fontSzie:15 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:100];
        
        
        UILabel *labelOfDate = [[UILabel alloc] initWithFrame:CGRectMake(imageV.frame.size.width+15, 10+height+heigeh0, view.frame.size.width-imageV.frame.size.width-30,20)];
        
        [self Customlable:labelOfDate text:@"2014-11-15 20:00" fontSzie:12 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:YES numberOfLines:1];
        
        
        NSString *addresStr = @"长沙 贺龙体育馆";
        CGFloat height1 = [self caculateTheTextHeight:addresStr andFontSize:12 andDistance:view.frame.size.width-imageV.frame.size.width-30];
        if (height1 > 45) {
            height1 = 45;
        }
        UILabel *labelOfAddress = [[UILabel alloc] initWithFrame:CGRectMake(imageV.frame.size.width+15, labelOfDate.frame.origin.y+23, view.frame.size.width-imageV.frame.size.width-30,height1)];
        
        [self Customlable:labelOfAddress text:addresStr fontSzie:12 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:20];
        
        [view addSubview:labelOfTitle];
        [view addSubview:labelOfDate];
        [view addSubview:labelOfAddress];
        
        return cell_one;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AdvanceNoticeViewController *advanceCtrl = [[AdvanceNoticeViewController alloc] init];
    
    if (collectionView.tag == 10002) {
        advanceCtrl.titleViewStr = @"预告详情";
        advanceCtrl.type = 1;
        
    }else if (collectionView.tag == 10003){
        advanceCtrl.titleViewStr = @"案例详情";
        advanceCtrl.type = 2;
    }else if (collectionView.tag == 10004){
        advanceCtrl.titleViewStr = @"行程详情";
        advanceCtrl.type = 3;
    }
   [self.navigationController pushViewController:advanceCtrl animated:YES];
    NSLog(@"%@",indexPath);
}

#pragma mark - 左上角按钮 跳到侧滑栏
-(void)didGoLeftMenu
{
    LeftMenuViewController *leftCtrl = [[LeftMenuViewController alloc] init];
    [self.navigationController presentLeftMenuViewController:leftCtrl];
}

#pragma mark - 右上角按钮 跳到搜索艺人的页面
-(void)didSearch
{
    
}

#pragma mark - 去 堂汇页面 按钮
-(void)didBtn1:(UIButton *)sender{
    ShowMallsViewController *showCtrl = [[ShowMallsViewController alloc] init];
    showCtrl.titleViewStr = @"堂 汇";
    showCtrl.type = 1;
    [self.navigationController pushViewController:showCtrl animated:YES];
    NSLog(@"去 堂汇页面  按钮");
}

#pragma mark - 去 艺人堂页面 按钮
-(void)didBtn2:(UIButton *)sender{
    NSLog(@"去 艺人堂页面 按钮");
    StarHallViewController *starCtrl = [[StarHallViewController alloc] init];
    [self.navigationController pushViewController:starCtrl animated:YES];
}

#pragma mark - 去 秀MALL页面 按钮
-(void)didBtn3:(UIButton *)sender{
    ShowMallsViewController *showCtrl = [[ShowMallsViewController alloc] init];
     showCtrl.titleViewStr = @"秀MALL";
    showCtrl.type = 2;
    [self.navigationController pushViewController:showCtrl animated:YES];
    NSLog(@"去 秀MALL页面 按钮");
}

#pragma mark -点击cell头部
-(void)didHeadBtn:(UIButton *)sender
{
    NSLog(@"%ld",(long)sender.tag);
    
}

#pragma mark - 点击 分段控制器
-(void)didSegment:(CCSegmentedControl *)segmentCtr
{
    _type = segmentCtrl.selectedSegmentIndex;
    collectionViewOther = (UICollectionView *)[_tableView viewWithTag:10004];
    [collectionViewOther reloadData];
    [collectionViewOther scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    NSLog(@"%ld",(long)segmentCtrl.selectedSegmentIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UIlabel的方法
-(void)Customlable:(UILabel *)label text:(NSString *)textStr fontSzie:(CGFloat)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment adjustsFontSizeToFitWidth:(BOOL)state numberOfLines:(NSInteger)numberOfLines
{
    label.text = textStr;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.adjustsFontSizeToFitWidth = state;
    label.numberOfLines = numberOfLines;
}

#pragma mark - 根据字长算 高度或宽度
- (CGFloat)caculateTheTextHeight:(NSString *)string andFontSize:(int)fontSize andDistance:(CGFloat)distance{
    
    /*非彻底性封装*/
    CGSize constraint = CGSizeMake(distance, CGFLOAT_MAX);
    
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
