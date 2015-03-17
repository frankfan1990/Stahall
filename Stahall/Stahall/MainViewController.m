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
#import "HomeHeadDetailsViewController.h"
#import "UIImageView+WebCache.h"
#import "ListAdvanceViewController.h"
#import "AdvanceNoticeViewController.h"
#import "ShowDetailsViewController.h"
#import "SearchStarViewController.h"
#import "ShowMallsViewController.h"
#import "TangHuiListViewController.h"
#import "CaseDetailsViewController.h"
#import "TravelDetailViewController.h"
#import "CCSegmentedControl.h"
#import "AFNetworking.h"
#import "CycleScrollView.h"
#import "RESideMenu.h"
#import "Marcos.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
{
    UIButton *btnRight;
    UITextField *textField;
    NSArray *arrOfTitle;
    NSArray *arrOfTitleOther;
    NSArray *arrOfSegmentTitle;
    CycleScrollView *headScrollView;
    CCSegmentedControl *segmentCtrl;
    UICollectionView *collectionViewOther;
    
    NSInteger _type;
    
    NSArray *caseData;//案例数据
    
    NSArray *travelData;//行程数据
    NSMutableArray *travelDataOther;
}

@property (nonatomic,strong)UITableView *tableView;//主页骨架
@property (nonatomic,strong)NSMutableArray *arrOfimages_one; // 第一个cell里的图片
@property (nonatomic,strong) NSMutableArray *arrOfLabelContent_one;//第一个cell里的图片里的label的内容
@property (nonatomic,strong) NSString *strrr;
@end


@implementation MainViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBar];
    [self Variableinitialization];
    [self getData];
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"MainViewBackImage"].CGImage;
  
    /**
     *  @author frankfan, 14-12-12 00:12:20
     *
     *  开始创建tableView,构建骨架，5个section
     */
    
    headScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(10, 8, Mywidth-20, 220) animationDuration:3 andShowControlDot:YES];
    headScrollView.userInteractionEnabled = YES;
    headScrollView.scrollView.scrollEnabled = NO;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,Mywidth-20, 200)];
    imageV.image = [UIImage imageNamed:@"七夕"];
    [headScrollView.scrollView addSubview:imageV];
    
    headScrollView.backgroundColor = [UIColor clearColor];
  
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 62, self.view.bounds.size.width, self.view.bounds.size.height-70) style:UITableViewStyleGrouped];
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
    _arrOfimages_one = [NSMutableArray array];
    _arrOfLabelContent_one = [NSMutableArray array];
    travelDataOther = [NSMutableArray array];

    arrOfSegmentTitle = @[@"演唱会",@"舞台剧",@"企业活动"];
    arrOfTitle = @[@"预告",@"案例",@"行程"];
    arrOfTitleOther = @[@"PREVUE",@"SHOW",@"SHOW"];
    arrOfTitle = @[@"案例",@"行程"];
    arrOfTitleOther = @[@"SHOW",@"SHOW"];
    
}

#pragma mark - 数据获取
-(void)getData
{
    __weak typeof (self)Myself = self;
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/plain",@"text/html"]];
    
    /*
     
     头部轮播的数据
     
     */
    
    
    NSDictionary *dic2222 = @{@"driverNo":@"15111111111",@"":@""};
    [manger POST:@"http://192.168.13.116:8080/driver/driver" parameters:dic2222 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
   
    [manger GET:home_HeadIP parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *datadic = (NSDictionary *)responseObject;
        NSArray *arrData = datadic[@"results"];
        headScrollView.scrollView.scrollEnabled = YES;
        
        headScrollView.totalPagesCount = ^NSInteger(void){
            return arrData.count;
        };
        
        headScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Myself.view.frame.size.width-20, 190)];
            
            [imageV sd_setImageWithURL:[NSURL URLWithString:arrData[pageIndex][@"posterCover"]] placeholderImage:[UIImage imageNamed:@"七夕"]];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, Myself.view.frame.size.width-20, 50)];
            label.text = arrData[pageIndex][@"posterTitle"];
            
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:16];
            label.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.3];
            label.textColor = [UIColor whiteColor];
            label.adjustsFontSizeToFitWidth = YES;
            [imageV addSubview:label];
            return imageV;
        };
        
#pragma mark - 点击轮播图
        headScrollView.TapActionBlock = ^(NSInteger pageIndex){
            
            HomeHeadDetailsViewController *homedetails = [[HomeHeadDetailsViewController alloc] init];
            homedetails.dataStr = arrData[pageIndex][@"posterContent"];
            [Myself.navigationController pushViewController:homedetails animated:YES];
            NSLog(@"%ld",(long)pageIndex);
            
        };
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    /*
     
     获取案例数据
     
     */
    NSDictionary *dic2 = @{@"start":@"0",@"limit":@"20"};
    [manger GET:CaseIP parameters:dic2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictiondata = (NSDictionary *)responseObject;
        caseData = dictiondata[@"results"];
        UICollectionView *collec = (UICollectionView *)[_tableView viewWithTag:10003];
        [collec reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    /*
     
     获取行程数据
     
     */
    NSDictionary *dic3 = @{@"typeId":@"NULL",@"start":@"0",@"limit":@"20"};
    [manger GET:TravelIP parameters:dic3 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dictiondata = (NSDictionary *)responseObject;
        travelData = dictiondata[@"results"];
        [travelDataOther removeAllObjects];
        for (NSDictionary *dd in travelData) {
            
          if ([dd[@"typeId"] intValue] == 2) {
                [travelDataOther addObject:dd];
            }
        }

        UICollectionView *collec = (UICollectionView *)[_tableView viewWithTag:10004];
        [collec reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"行程数据:%@",error);
    }];
    
    
}

#pragma mark - TabBar的设置
-(void)setTabBar
{

    UIView *tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 65)];
    tabBarView.backgroundColor = [UIColor clearColor];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(14, 20, 40, 40)];
    view1.backgroundColor = [UIColor whiteColor];
    view1.layer.cornerRadius = view1.frame.size.width/2;
    [tabBarView addSubview:view1];
    
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLeft.layer.masksToBounds = YES;
    [btnLeft setFrame:CGRectMake(1, 1, 38, 38)];
     btnLeft.layer.cornerRadius = btnLeft.frame.size.width/2;
    [btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"lc汪峰头像.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"lc汪峰头像.png"] forState:UIControlStateHighlighted];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(didGoLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:btnLeft];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(view1.frame.origin.x+view1.frame.size.width+10, 27,Mywidth-(view1.frame.origin.x+view1.frame.size.width+10+40), 25)];
    view.backgroundColor = [UIColor purpleColor];
    view.layer.cornerRadius = 12.5;
    view.alpha = 0.7;
    
    [tabBarView addSubview:view];
    
    
    textField=[[UITextField alloc] initWithFrame:CGRectMake(10, 0, Mywidth-(view1.frame.origin.x+view1.frame.size.width+10+40)-10, 25)];
    textField.delegate = self;
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Serach.." attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"搜索白色"]];
    textField.leftView = image;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:15];
    textField.textColor = [UIColor whiteColor];
    [view addSubview:textField];
    
    btnRight = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnRight setFrame:CGRectMake(Mywidth-45, 17, 40, 45)];
    btnRight.hidden = YES;
    [btnRight setTitle:@"取消" forState:UIControlStateNormal];
    [btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnRight.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btnRight addTarget:self action:@selector(didSearch) forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:btnRight];
    [self.view  addSubview:tabBarView];
}

#pragma mark - textField的代理
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    btnRight.hidden = NO;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    btnRight.hidden = YES;
}

#pragma mark - 创建分段个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return arrOfTitle.count + 2;
}
 
#pragma mark - 每个分段里的cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark - 每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 230-5;
    }else if(indexPath.section == 1){
        return 85;
    }else{
        return 180;
    }
}

#pragma mark - 每个headView的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section >1) {
        return 35;
    }else{
        return 0.1;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


#pragma mark - 每个section的headView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section > 1) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 35)];
        headView.backgroundColor = [UIColor clearColor];
        
        UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 20)];
        [self Customlable:labelTitle text:arrOfTitle[section-2] fontSzie:19 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:YES numberOfLines:1];
        
        [headView addSubview:labelTitle];
        
        UILabel *labelTitleOther = [[UILabel alloc] initWithFrame:CGRectMake(53, 15, 35, 15)];
        
        [self Customlable:labelTitleOther text:arrOfTitleOther[section-2] fontSzie:11 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:YES numberOfLines:1];
        
        [headView addSubview:labelTitleOther];
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lc向右灰"]];
        imageV.frame = CGRectMake(labelTitleOther.frame.origin.x + labelTitleOther.frame.size.width+12, 12, 15, 15);
        imageV.layer.masksToBounds = YES;
        imageV.layer.cornerRadius = imageV.frame.size.width/2;
        imageV.backgroundColor = [UIColor whiteColor];
        imageV.alpha = 0.6;
        [headView addSubview:imageV];
        
        if (section == arrOfTitle.count+1) {
            segmentCtrl = [[CCSegmentedControl alloc] initWithItems:arrOfSegmentTitle];
            segmentCtrl.frame = CGRectMake(imageV.frame.origin.x+imageV.frame.size.width +20, 3, Mywidth-(imageV.frame.origin.x+imageV.frame.size.width +30), 30);
            segmentCtrl.segmentTextColor = [UIColor whiteColor];
            segmentCtrl.selectedSegmentTextColor = [UIColor orangeColor];
            segmentCtrl.backgroundColor = [UIColor clearColor];
            UIImageView *selecImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lc2"]];
            [segmentCtrl addTarget:self action:@selector(didSegment:) forControlEvents:UIControlEventValueChanged];
            segmentCtrl.selectedStainView = selecImageView;
            [headView addSubview:segmentCtrl];
        }
        
        UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        headBtn.frame = CGRectMake(0, 0, imageV.frame.size.width+imageV.frame.origin.x+20, 53);
        headBtn.tag = 66666+section;
        headBtn.backgroundColor = [UIColor clearColor];
        [headBtn addTarget:self action:@selector(didHeadBtn:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:headBtn];
        return headView;
    }else{
        return nil;
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
        btn1.frame = CGRectMake(10, 0, (Mywidth - 50)/3, 80);
        btn2.frame = CGRectMake(btn1.frame.origin.x+10 + (Mywidth - 40)/3, 0, (Mywidth - 40)/3, 80);
        btn3.frame = CGRectMake(btn2.frame.origin.x+10 + (Mywidth - 40)/3, 0, (Mywidth - 40)/3, 80);
        
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
        
        UITableViewCell *cell_four = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell_four.selectionStyle = UITableViewCellSelectionStyleNone;
        cell_four.backgroundColor = [UIColor clearColor];
        UICollectionViewFlowLayout *layoutView = [[UICollectionViewFlowLayout alloc] init];
        layoutView.itemSize = CGSizeMake(120, 170);
        [layoutView setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        UICollectionView *_collectionView= [[UICollectionView alloc] initWithFrame:CGRectMake(10, 5, Mywidth-20, 170) collectionViewLayout:layoutView];
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
        
        layoutView.itemSize = CGSizeMake(Mywidth, 175);
        layoutView.minimumLineSpacing = 0;
        layoutView.minimumInteritemSpacing = 0;
        layoutView.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        [layoutView setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        UICollectionView *_collectionView= [[UICollectionView alloc] initWithFrame:CGRectMake(0, 5, Mywidth, 175) collectionViewLayout:layoutView];
        _collectionView.bounces = NO;
        _collectionView.scrollsToTop = NO;
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

    if (collectionView.tag == 10003){
        return caseData.count;
    }else{
        return travelDataOther.count;
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

     if (collectionView.tag == 10003) {
         //案例
        UICollectionViewCell *cell_two = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"My_collectionViewCell_Two" forIndexPath:indexPath];
        
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.frame = CGRectMake(0, 0,120, 170);
        [imageV sd_setImageWithURL:[NSURL URLWithString:caseData[indexPath.row][@"cover"]] placeholderImage:[UIImage imageNamed:@""]];
        [cell_two addSubview:imageV];
        
        return cell_two;
    }
    else{
        //行程
        UICollectionViewCell *cell_one = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"My_collectionViewCell_There" forIndexPath:indexPath];
        
        UIView *view = [[UIView alloc] init];
        
        view.frame = CGRectMake(10, 0,Mywidth-20, 175);
        
        
        view.backgroundColor = [UIColor colorWithRed:115/255.0 green:72/255.0 blue:241/255.0 alpha:1];
        [cell_one.contentView addSubview:view];
        
        
        
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width/2-15, view.frame.size.height)];
        [imageV sd_setImageWithURL:[NSURL URLWithString:travelDataOther[indexPath.row][@"cover"]] placeholderImage:[UIImage imageNamed:@"张杰"]];

        NSString *titleStr = travelDataOther[indexPath.row][@"travelName"];
        
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
        [self Customlable:labelOfDate text:@"" fontSzie:12 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:YES numberOfLines:1];
        labelOfDate.text = travelDataOther[indexPath.row][@"startDate"];
        
        
        NSString *addresStr = travelDataOther[indexPath.row][@"venues"];;
        CGFloat height1 = [self caculateTheTextHeight:addresStr andFontSize:12 andDistance:view.frame.size.width-imageV.frame.size.width-30];
        if (height1 > 45) {
            height1 = 45;
        }
        UILabel *labelOfAddress = [[UILabel alloc] initWithFrame:CGRectMake(imageV.frame.size.width+15, labelOfDate.frame.origin.y+23, view.frame.size.width-imageV.frame.size.width-30,height1)];
        [self Customlable:labelOfAddress text:addresStr fontSzie:12 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:20];
        
        
        [view addSubview:imageV];
        [view addSubview:labelOfTitle];
        [view addSubview:labelOfDate];
        [view addSubview:labelOfAddress];
        
        return cell_one;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

     if (collectionView.tag == 10003){
        CaseDetailsViewController *caseCtrl = [[CaseDetailsViewController alloc] init];
        caseCtrl.caseId = caseData[indexPath.row][@"caseId"];
        caseCtrl.caseName = caseData[indexPath.row][@"caseName"];
        [self.navigationController pushViewController:caseCtrl animated:YES];
    }else if (collectionView.tag == 10004){
        TravelDetailViewController *traveCtrl = [[TravelDetailViewController alloc] init];
        [self.navigationController pushViewController:traveCtrl animated:YES];
    }
  
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
    [textField resignFirstResponder];
    
//    SearchStarViewController *seacrchCtrl = [[SearchStarViewController alloc] init];
//    [self.navigationController pushViewController:seacrchCtrl animated:YES];
}

#pragma mark - 去 堂汇页面 按钮
-(void)didBtn1:(UIButton *)sender{
    TangHuiListViewController *TangCtrl = [[TangHuiListViewController alloc] init];
    TangCtrl.index = 101;
    TangCtrl.title = @"堂汇";
    [self.navigationController pushViewController:TangCtrl animated:YES];
    NSLog(@"去 堂汇页面  按钮");
}

#pragma mark - 去 艺人堂页面 按钮
-(void)didBtn2:(UIButton *)sender{
    NSLog(@"去 艺人堂页面 按钮");
    StarHallViewController *starCtrl = [[StarHallViewController alloc] init];
    [self.navigationController pushViewController:starCtrl animated:YES];
    starCtrl.isSearchMode = NO;
}

#pragma mark - 去 秀MALL页面 按钮
-(void)didBtn3:(UIButton *)sender{
    ShowMallsViewController *showCtrl = [[ShowMallsViewController alloc] init];
    [self.navigationController pushViewController:showCtrl animated:YES];
    NSLog(@"去 秀MALL页面 按钮");
}

#pragma mark -点击cell头部
-(void)didHeadBtn:(UIButton *)sender
{
    if (sender.tag == 66669) {
        TangHuiListViewController *TangCtrl = [[TangHuiListViewController alloc] init];
        TangCtrl.index = 100;
        TangCtrl.arrOfdata = travelData;
        TangCtrl.title = @"行程";
        [self.navigationController pushViewController:TangCtrl animated:YES];
    }else if (sender.tag == 66668){
        ListAdvanceViewController *list = [[ListAdvanceViewController alloc] init];
//        list.arrOfdata = advanceData;
        [self.navigationController pushViewController:list animated:YES];
    }
   
}

#pragma mark - 点击 分段控制器
-(void)didSegment:(CCSegmentedControl *)segmentCtr
{
    _type = segmentCtrl.selectedSegmentIndex;
    
    [travelDataOther removeAllObjects];
    for (NSDictionary *dd in travelData) {
        if (_type == 0) {
            if ([dd[@"typeId"] intValue] == 2) {
                [travelDataOther addObject:dd];
            }
        }else if (_type == 1){
            if ([dd[@"typeId"] intValue] == 1) {
                [travelDataOther addObject:dd];
            }
        }else{
            if ([dd[@"typeId"] intValue] == 3) {
                [travelDataOther addObject:dd];
            }
        }
        
    }

    collectionViewOther = (UICollectionView *)[_tableView viewWithTag:10004];
    if ([travelDataOther count] == 0) {
        return;
    }
    [collectionViewOther reloadData];
    [collectionViewOther scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    NSLog(@"%ld",_type);
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
