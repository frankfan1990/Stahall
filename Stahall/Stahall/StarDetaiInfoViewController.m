//
//  StarDetaiInfoViewController.m
//  Stahall
//
//  Created by frankfan on 14/12/23.
//  Copyright (c) 2014年 Rching. All rights reserved.
//
//FIXME: 艺人详情


#import "StarDetaiInfoViewController.h"

//日历相关
#import "Datetime.h"
#import "DetailDayCell.h"
#import "RTLabel.h"
#import "StarDetailCollectionViewCell.h"
/********/



@interface StarDetaiInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,UIScrollViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{

   /*****日历相关-垃圾代码****/
    NSArray *_dayArray;
    
    NSInteger chooseDay;
    int strMonth;
    int strYear;
    
    UIImageView *_backgroundView;
    UIView *_calendarHead;
    UIView *_calendarView;

    
    UIView *_bottomView;
    
    UIButton *_truantButton;
    UIButton *_classButton;
    UIButton *_leaveButton;
    
    UILabel *_dayLabel;
    UITextView *_noticeLabel;
    
    UITableView *_detailDayTableView;
    NSArray *_detailDayArr;


    /***********************/
    
    UIWebView *webView;
    NSMutableArray *beforeSelectedButton;//记录之前选中的button
    
    UIButton *introductionButton;
    UIButton *priceButton;
    UIButton *dateButton;
    UIButton *requireButton;
    
    UIButton *stahallEvalutionButton;//堂估价Button
    
    
    UIView *mainView;//档期模块
    UIView *introductionBackView;//简介模块
    UIView *priceBackView;//价格模块
    UIView *requireBackView;//要求模块
    
    NSMutableArray *selectedButtonArray;//记录选中的那个button
    NSMutableArray *olderBackViewArray;//记录之前的backView
    
//    UIWebView *introductionWebView;//简介webView
    RTLabel *introductionWebView;//简介webView
    UILabel *touchView;//让用户可以滑动的触点
    
    CGFloat sectionSecondCellHeight;//cell的高度
}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation StarDetaiInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  @author frankfan, 14-12-23 17:12:36
     *
     *  日历相关
     */

    //档期模块
    mainView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 330)];
    mainView.backgroundColor =[UIColor colorWithWhite:0 alpha:0];
    mainView.backgroundColor =[UIColor clearColor];
    mainView.tag = 3003;
 
    strYear = [[Datetime GetYear] intValue];
    strMonth = [[Datetime GetMonth] intValue];
    _dayArray = [Datetime GetDayArrayByYear:strYear andMonth:strMonth];
    
    
    
    NSString *todayString =[NSString stringWithFormat:@"%@",[NSDate date]];
    self.today = [@[todayString]mutableCopy];
    
    self.travelDay = [@[@"2014-11-11",@"2014-12-1",@"2014-12-3",@"2014-11-20"]mutableCopy];//行程
    self.showDay = [@[@"2014-11-7",@"2014-11-26",@"2014-12-2"]mutableCopy];//演出
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 330-44, self.view.frame.size.width, 44)];
    _bottomView.backgroundColor = [UIColor colorWithRed:204 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1.0];
    //    [[[UIApplication sharedApplication] keyWindow] addSubview:_bottomView];
    [mainView addSubview:_bottomView];
    
    
    UIView *truantView = [[UIView alloc] initWithFrame:CGRectMake(20, 12, 20, 20)];
    truantView.backgroundColor = [UIColor clearColor];
    truantView.layer.masksToBounds = YES;
    truantView.layer.cornerRadius = 10;
    truantView.layer.borderColor = [[UIColor whiteColor] CGColor];
    truantView.layer.borderWidth = 2;
    [_bottomView addSubview:truantView];
    
    UIView *classView = [[UIView alloc] initWithFrame:CGRectMake(120, 12, 20, 20)];
    classView.backgroundColor = [UIColor colorWithRed:85/255.0 green:218/255.0 blue:225/255.0 alpha:1];
    classView.layer.cornerRadius = 10;
    [_bottomView addSubview:classView];
    
    UIView *leaveView = [[UIView alloc] initWithFrame:CGRectMake(220, 12, 20, 20)];
    leaveView.backgroundColor = [UIColor colorWithRed:254/255.0 green:102/255.0 blue:122/255.0 alpha:1];
    leaveView.layer.cornerRadius = 10;
    [_bottomView addSubview:leaveView];
    
    
    
    _truantButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_truantButton setTitle:@"今天" forState:UIControlStateNormal];
    [_truantButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _truantButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _truantButton.frame = CGRectMake(40, 5, 40, 34);
    [_bottomView addSubview:_truantButton];
    
    _classButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_classButton setTitle:@"行程" forState:UIControlStateNormal];
    [_classButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _classButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _classButton.frame = CGRectMake(140, 5, 40, 34);
    [_bottomView addSubview:_classButton];
    
    _leaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leaveButton setTitle:@"演出" forState:UIControlStateNormal];
    [_leaveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _leaveButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _leaveButton.frame = CGRectMake(240, 5, 40, 34);
    [_bottomView addSubview:_leaveButton];
    
    
    [self addBackgroundImage];
    [self addCalendarHeadView];
    [self AddDayButtonToCalendarWatch];
    
    
    /*********************************/
    
    /**
     *  @author frankfan, 14-12-24 09:12:30
     *
     *  数据初始化
     */
    
    selectedButtonArray =[NSMutableArray array];
    olderBackViewArray =[NSMutableArray array];
    sectionSecondCellHeight = 330;

    
    //简介模块
    introductionBackView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 330)];
    introductionBackView.backgroundColor =[UIColor colorWithWhite:0 alpha:0];
    introductionBackView.backgroundColor =[UIColor clearColor];
    introductionBackView.backgroundColor =[UIColor whiteColor];
    [olderBackViewArray addObject:introductionBackView];//默认选中简介模块
    introductionBackView.backgroundColor =[UIColor clearColor];
    introductionBackView.tag = 3001;
    
    introductionWebView =[[RTLabel alloc]initWithFrame:CGRectMake(10, 5, self.view.bounds.size.width-20, 0)];
    introductionWebView.opaque = NO;
    introductionWebView.backgroundColor =[UIColor clearColor];
    [introductionBackView addSubview:introductionWebView];

    NSString *originString = @"小龙女是包子龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子是包子小龙女是包子小龙女是包子小龙女是包龙女是包子龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是<p>包子小龙女是</p>包子小龙女是包子小龙女是包子小龙女是包子是包子小龙女是包子小龙女是包子小龙女是包龙女是包子龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子是包子小龙女是包子小龙女是包龙女是包子小龙女是包子小龙女是包子小龙女是包子是包子小龙女是包子小龙女是包子小龙女是包龙女是包子龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子小龙女是包子";
    introductionWebView.text = [self handleStringForRTLabel:originString];
    if(introductionWebView.optimumSize.height<330){
        
        sectionSecondCellHeight = 330;
    }else{
    
        sectionSecondCellHeight = introductionWebView.optimumSize.height;
    }

    introductionWebView.frame = CGRectMake(0, 0, self.view.bounds.size.width, introductionWebView.optimumSize.height);
    
    
    //价格模块
    priceBackView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 330)];
    priceBackView.backgroundColor =[UIColor colorWithWhite:0 alpha:0];
    priceBackView.backgroundColor =[UIColor clearColor];
    priceBackView.backgroundColor =[UIColor whiteColor];
    priceBackView.backgroundColor =[UIColor clearColor];
    priceButton.tag = 3002;

    //要求模块
    requireBackView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 330)];
    requireBackView.backgroundColor =[UIColor colorWithWhite:0 alpha:0];
    requireBackView.backgroundColor =[UIColor clearColor];
    requireBackView.backgroundColor =[UIColor whiteColor];
    requireBackView.backgroundColor =[UIColor blueColor];
    requireBackView.tag = 3004;
    
    
    /*title*/
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:69/255.0 green:174/255.0 blue:215/255.0 alpha:1]];
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    title.text = self.starName;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    /*回退*/
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.tag = 10006;
    backButton.frame = CGRectMake(0, 0, 30, 30);
    [backButton setImage:[UIImage imageNamed:@"朝左箭头icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClickeda:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftitem =[[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftitem;
    
    //背景
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"fz艺人详情背景"].CGImage;
    
    /**
     *  @author frankfan, 14-12-23 15:12:43
     *
     *  创建主界面
     */
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-90) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:self.tableView];
    self.tableView.userInteractionEnabled = YES;
    
    CGRect rect = CGRectZero;
    UIView *footerView =[[UIView alloc]initWithFrame:rect];
    self.tableView.tableFooterView = footerView;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor =[UIColor clearColor];
    
    //创建webView
    webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
    webView.opaque = NO;
    webView.backgroundColor =[UIColor orangeColor];
    webView.scrollView.scrollEnabled = NO;
    
    //创建button
    
    introductionButton =[self createButtonWithTag:1001 andTitle:@"简介" andBackGroundImage:nil andFrame:CGRectMake(0, 150,320.0/4 , 50)];
    [introductionButton addTarget:self action:@selector(fourItemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [introductionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    priceButton =[self createButtonWithTag:1002 andTitle:@"价格" andBackGroundImage:nil andFrame:CGRectMake(320.0/4, 150, 320.0/4, 50)];
    [priceButton addTarget:self action:@selector(fourItemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    dateButton =[self createButtonWithTag:1003 andTitle:@"档期" andBackGroundImage:nil andFrame:CGRectMake(320.0/4*2, 150, 320.0/4, 50)];
    [dateButton addTarget:self action:@selector(fourItemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    requireButton =[self createButtonWithTag:1004 andTitle:@"要求" andBackGroundImage:nil andFrame:CGRectMake(320.0/4*3, 150, 320.0/4, 50)];
    [requireButton addTarget:self action:@selector(fourItemButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [selectedButtonArray addObject:introductionButton];
    
    //堂估价按钮
    stahallEvalutionButton =[UIButton buttonWithType:UIButtonTypeCustom];
    stahallEvalutionButton.backgroundColor =[UIColor greenColor];
    stahallEvalutionButton.frame = CGRectMake(0, self.view.bounds.size.height-50, self.view.bounds.size.width, 50);
    [stahallEvalutionButton setTitle:@"堂估价" forState:UIControlStateNormal];
    [[UIApplication sharedApplication].keyWindow addSubview:stahallEvalutionButton];
    

    //创建价格模块控件-collectionView
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(80, 35);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    
    self.collectionView =[[UICollectionView alloc]initWithFrame:priceBackView.bounds collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[StarDetailCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [priceBackView addSubview:self.collectionView];
    self.collectionView.backgroundColor =[UIColor clearColor];
    
    
    //创建要求模块控件
    CGFloat width = self.view.bounds.size.width;
    UIButton *ticketButton =[self createButtonWithTag:9000 andTitle:@"机票" andBackGroundImage:nil andFrame:CGRectMake(10, 15,width/2.0-15, 330/2.0-20)];
    ticketButton.layer.cornerRadius = 2;
    [requireBackView addSubview:ticketButton];
    
    UIButton *aboutCarButton =[self createButtonWithTag:9001 andTitle:@"用车" andBackGroundImage:nil andFrame:CGRectMake(width/2.0-15+20, 15, width/2.0-15, 330/2.0-20)];
    aboutCarButton.layer.cornerRadius = 2;
    [requireBackView addSubview:aboutCarButton];
    
    UIButton *hotelButton =[self createButtonWithTag:9002 andTitle:@"酒店" andBackGroundImage:nil andFrame:CGRectMake(10, 15+330/2.0-20+10, width/2.0-15, 330/2.0-20)];
    
    hotelButton.layer.cornerRadius = 2;
    [requireBackView addSubview:hotelButton];
    
    
    UIButton *aboutFoodButton =[self createButtonWithTag:9003 andTitle:@"用餐" andBackGroundImage:nil andFrame:CGRectMake(width/2.0-15+20, 15+330/2.0-20+10, width/2.0-15, 330/2.0-20)];
    aboutCarButton.layer.cornerRadius = 2;
    [requireBackView addSubview:aboutFoodButton];
    
}


#pragma mark - collectionCell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    StarDetailCollectionViewCell *cell = (StarDetailCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 2;
    cell.layer.masksToBounds = YES;
    
    cell.itemTitle.text = @"测试";
    cell.backgroundColor =[UIColor orangeColor];
    return cell;

}



#pragma mark - section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

#pragma mark - cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    


    UITableViewCell *cell =nil;
    UITableViewCell *cell2 = nil;
    UITableViewCell *cell3 = nil;
    if(!cell || !cell2 || !cell3){
    
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = NO;
        
        cell2 =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = NO;
       
        cell3 =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = NO;
    }
    
    
    if(indexPath.section==0){
        
        [cell.contentView addSubview:webView];
        
        [cell.contentView addSubview:introductionButton];
        [cell.contentView addSubview:priceButton];
        [cell.contentView addSubview:dateButton];
        [cell.contentView addSubview:requireButton];
        cell.selected  =NO;
        return cell;
    }
    
    if(indexPath.section==1){
        
        cell2.backgroundColor =[UIColor clearColor];
        cell2.selected = NO;
        
        //
        UIButton *selectedButton =[selectedButtonArray firstObject];
        
        UIView *olderView =[olderBackViewArray firstObject];
        [olderView removeFromSuperview];
        if(olderView.tag==3001){
        
            [introductionBackView removeFromSuperview];
        }else if (olderView.tag==3002){
        
            [priceBackView removeFromSuperview];
        }else if (olderView.tag==3003){
        
            [mainView removeFromSuperview];
        }else{
        
            [requireBackView removeFromSuperview];
        }
        
        
   

        if(selectedButton.tag==1001){//简介
            
        
            [cell2.contentView addSubview:introductionBackView];
            
        }else if (selectedButton.tag==1003){//档期
            
     
            [cell2.contentView addSubview:mainView];

        }else if (selectedButton.tag==1002){//价格
        
            [cell2.contentView addSubview:priceBackView];
        
        }else{//要求
        
            [cell2.contentView addSubview:requireBackView];
        }
        
        return cell2;
        
    }
    
    if(indexPath.section==2){
        
        UILabel *addShows =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
        addShows.font =[UIFont systemFontOfSize:14];
        addShows.textColor =[UIColor whiteColor];
        addShows.backgroundColor =[UIColor blueColor];
        addShows.text =@"增加场次";
        addShows.textAlignment = NSTextAlignmentCenter;
        [cell3.contentView addSubview:addShows];
        cell3.selected = NO;
        
        return cell3;
    }

    
    
    
    return nil;
}

#pragma mark - 控制头部的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section==0){
        
        return 0.1;
        
    }else if (section==1){
        
        return 5;
        
    }else{
    
        return 5;
    }


}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.section==0){
    
        return 200;

        
    }else if (indexPath.section==1){
    
        return sectionSecondCellHeight;
    }else{
        
        return 60;
    }
    
}



#pragma mark- 创建button
- (UIButton *)createButtonWithTag:(NSInteger)tag andTitle:(NSString *)title andBackGroundImage:(UIImage *)image andFrame:(CGRect)frame{

    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor =[UIColor purpleColor];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = tag;
    [button setImage:image forState:UIControlStateNormal];
    
    return button;
}


#pragma mark - 四个主button被点击
- (void)fourItemButtonClicked:(UIButton *)sender{

    UIButton *selectedButton = [selectedButtonArray firstObject];//之前选中的按钮
    if(sender.tag == selectedButton.tag){
    
        return;
        
    }else{
    
        [selectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [olderBackViewArray removeAllObjects];
        
        if(selectedButton.tag==1001){//简介
        
            
            [olderBackViewArray addObject:introductionBackView];
            
        }else if (selectedButton.tag==1003){//档期
        
            
            [olderBackViewArray addObject:mainView];
            
        }else if (selectedButton.tag==1002){//价格
        
            [olderBackViewArray addObject:priceBackView];
            
        }else{//要求
        
            [olderBackViewArray addObject:requireBackView];
        
        }
        
        
        
        [selectedButtonArray removeAllObjects];
        [selectedButtonArray addObject:sender];
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        if(sender.tag==1001){
        
            if(introductionWebView.optimumSize.height<=330){
            
                sectionSecondCellHeight = 330;
            }else{
            
                sectionSecondCellHeight = introductionWebView.optimumSize.height;
            }
            
        }else{
        
            sectionSecondCellHeight = 330;
        }
        
        [self.tableView reloadData];
        
    }
    
    

}


#pragma mark - 处理富文本格式字符串，使之适配RTLabel的使用
- (NSString *)handleStringForRTLabel:(NSString *)htmlString{
    
    NSString *tempString = [htmlString stringByReplacingOccurrencesOfString:@"<br>" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [htmlString length])];
    
    NSString *resultString =[tempString stringByReplacingOccurrencesOfString:@"div" withString:@"br" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [tempString length])];
    
    return resultString;
}






#pragma mark - viewWillDisappear
- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [stahallEvalutionButton removeFromSuperview];
}


#pragma mark - 回退
- (void)buttonClickeda:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    


}








/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



//添加背景图
- (void)addBackgroundImage
{
    _backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 320, 240)];
    
    _backgroundView.userInteractionEnabled = YES;
    
    [self.view addSubview:_backgroundView];
    
}

#pragma mark - 日历头部创建
//添加日历的头部
- (void)addCalendarHeadView
{
    
    [_calendarHead removeFromSuperview];
    _calendarHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 75)];
    _calendarHead.userInteractionEnabled = YES;
    _calendarHead.backgroundColor =[UIColor clearColor];
    [mainView addSubview:_calendarHead];
    
    //星期的背景view
    UIView *someDayBackView =[[UIView alloc]initWithFrame:CGRectMake(0, 38, self.view.bounds.size.width, 35)];
    someDayBackView.backgroundColor =[UIColor blueColor];
    [_calendarHead addSubview:someDayBackView];
    
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
    [_leftButton addTarget:self action:@selector(didClickLeft:) forControlEvents:UIControlEventTouchUpInside];
    [_leftButton setImage:[UIImage imageNamed:@"日历切换left@2x"] forState:UIControlStateNormal];
    [_calendarHead addSubview:_leftButton];
    
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(320 - 10 - 24, _leftButton.frame.origin.y, 24, 24)];
    [_rightButton addTarget:self action:@selector(didClickRight:) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton setImage:[UIImage imageNamed:@"日历切换right@2x"] forState:UIControlStateNormal];
    [_calendarHead addSubview:_rightButton];
    [self addTimeTitle];
    [self addWeekLabelToCalenadrWatch];//头部 周一 周二
    
}

//在日历头部添加时间标题
- (void)addTimeTitle
{
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(320 / 2 - 100, 10, 200, 24)];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.text = [NSString stringWithFormat:@"%ld年%ld月",(long)strYear,(long)strMonth];
    [_calendarHead addSubview:timeLabel];
    
}


- (void)addWeekLabelToCalenadrWatch
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    for (int i = 0; i < 7; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithString:array[i]];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(10 + i * 45, 40, 30, 30);
        [_calendarHead addSubview:label];
    }
}

- (void)AddDayButtonToCalendarWatch
{
    BOOL before = NO;
    BOOL next = NO;
    BOOL normal = YES;
    
    if ([_dayArray[0] integerValue] > 1) {
        before = YES;
    }
    
    if ([[_dayArray lastObject] integerValue] < 20) {
        next = YES;
    }
    
#pragma mark - 控制日历主体的frame
    _calendarView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, 320, 6 * 35)];
//    [self.view addSubview:_calendarView];
      [mainView addSubview:_calendarView];
    [_calendarView addSubview:_detailDayTableView];

    
    //
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 80, 320, 6 * 35)];
    [mainView addSubview:view];
    
    
    
#pragma mark - 修改背景色
    _calendarView.backgroundColor =[UIColor clearColor];

    
    for (int i = 0; i < 42; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10 + (i%7)*45, (i/7)*35, 32, 32)];
        [button setTag:i + 301];
        button.layer.cornerRadius = 32 / 2.0;
        //        [button addTarget:self action:@selector(buttonTouchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
        button.showsTouchWhenHighlighted = YES;
        
        UILabel *label = [[UILabel alloc] init];
        label.text = [_dayArray[i] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        label.backgroundColor = [UIColor clearColor];
        label.frame = CGRectMake(0, 0, 32, 32);
        label.textAlignment = NSTextAlignmentCenter;
        
        if (before) {
            int myMonth = 1;
            int myYear = 1900;
            if (strMonth == 1) {
                myYear = strYear - 1;
                myMonth = 12;
            }
            else if (strMonth >1){
                
                myMonth = strMonth - 1;
                myYear = strYear;
            }
            if ([self overTimeYear:myYear Month:myMonth Day:(int)[_dayArray[i] integerValue] With:1]) {
                [button setImage:[UIImage imageNamed:@"演出.png"] forState:UIControlStateNormal];
            }
            if ([self overTimeYear:myYear Month:myMonth Day:(int)[_dayArray[i] integerValue] With:2]) {
                [button setImage:[UIImage imageNamed:@"今天.png"] forState:UIControlStateNormal];
            }
            if ([self overTimeYear:myYear Month:myMonth Day:(int)[_dayArray[i] integerValue] With:3]) {
                [button setImage:[UIImage imageNamed:@"行程.png"] forState:UIControlStateNormal];
            }
            if ([_dayArray[i + 1] integerValue] == 1) {
                before = NO;
            }
#pragma mark - 修改颜色
            label.textColor = [UIColor blackColor];
        }
        else if (normal){
            if ([self overTimeYear:strYear Month:strMonth Day:(int)[_dayArray[i] integerValue] With:1]) {
                [button setImage:[UIImage imageNamed:@"演出.png"] forState:UIControlStateNormal];
            }
            if ([self overTimeYear:strYear Month:strMonth Day:(int)[_dayArray[i] integerValue] With:2]) {
                [button setImage:[UIImage imageNamed:@"今天.png"] forState:UIControlStateNormal];
            }
            if ([self overTimeYear:strYear Month:strMonth Day:(int)[_dayArray[i] integerValue] With:3]) {
                [button setImage:[UIImage imageNamed:@"行程.png"] forState:UIControlStateNormal];
            }
            if (next && [_dayArray[i + 1] integerValue] == 1) {
                normal = NO;
            }
#pragma mark - 修改文字颜色
            label.textColor = [UIColor whiteColor];
        }
        else{
            int myMonth = 1;
            int myYear = 1900;
            if (strMonth == 12) {
                myYear = strYear +1;
                myMonth = 1;
            }
            else if (strMonth < 12){
                myMonth = strMonth + 1;
                myYear = strYear;
            }
            
            if ([self overTimeYear:myYear Month:myMonth Day:(int)[_dayArray[i] integerValue] With:1]) {
                [button setImage:[UIImage imageNamed:@"请假64.png"] forState:UIControlStateNormal];
            }
            if ([self overTimeYear:myYear Month:myMonth Day:(int)[_dayArray[i] integerValue] With:2]) {
                [button setImage:[UIImage imageNamed:@"旷课64.png"] forState:UIControlStateNormal];
            }
            if ([self overTimeYear:myYear Month:myMonth Day:(int)[_dayArray[i] integerValue] With:3]) {
                [button setImage:[UIImage imageNamed:@"有课64.png"] forState:UIControlStateNormal];
            }
            
            label.textColor = [UIColor grayColor];
        }
        
        [button addSubview:label];
        [_calendarView addSubview:button];
        [_calendarView addSubview:_detailDayTableView];
    }
}

- (void)backTodayAction
{
    strYear = [[Datetime GetYear] intValue];
    strMonth = [[Datetime GetMonth] intValue];
    [self reloadDateForCalendarWatch];
    
}

//把时间以“-”分割
- (NSArray *)splitTime:(NSString *)time
{
    NSArray *arr = [time componentsSeparatedByString:@"-"];
    return arr;
}

//比对时间 flag 为1 表示请假 2 表示旷课 3表示有课
- (BOOL)overTimeYear:(int)year Month:(int)month Day:(int)day With:(NSInteger)flag
{
    BOOL has = NO;
    NSArray *temporArray =nil;
    switch (flag) {
        case 1:
            temporArray = self.showDay;
            break;
        case 2:
            temporArray = self.today;
            break;
        case 3:
            temporArray = self.travelDay;
            break;
        default:
            break;
    }
    for (NSString *time in temporArray) {
        NSArray *timeArr = [self splitTime:time];
        if (( year == [timeArr[0] integerValue]) && (month == [timeArr[1] integerValue]) && (day == [timeArr[2] integerValue])) {
            has = YES;
        }
    }
    return has;
}

- (void)reloadDayButtonToCalendarWatch
{
    for (int i = 0; i < 42; i++) {
        [[self.view viewWithTag:i + 301] removeFromSuperview];
    }
    [_calendarHead removeFromSuperview];
    [_calendarView removeFromSuperview];
    [self AddDayButtonToCalendarWatch];
    [self addCalendarHeadView];
}



- (void)reloadDateForCalendarWatch
{
    _dayArray = nil;
    _dayArray = [Datetime GetDayArrayByYear:strYear andMonth:strMonth];
    [self reloadDayButtonToCalendarWatch];
    [self addCalendarHeadView];
}

- (void)buttonClicked:(UIButton *)button{
    
    if(button.tag==1001){
        
        [self didClickRight:button];
    }else{
        
        [self didClickLeft:button];
    }
    
}



#pragma mark - 右侧箭头点击
- (void)didClickRight:(UIButton *)button
{
    if (_backgroundView.frame.origin.y < 60) {
        return;
    }
    
    strMonth = strMonth + 1;
    if (strMonth == 13) {
        strYear++;strMonth = 1;
    }
    
    [self reloadDateForCalendarWatch];
}

#pragma mark - 左侧箭头点击
- (void)didClickLeft:(UIButton *)button
{
    if (_backgroundView.frame.origin.y < 60) {
        return;
    }
    
    strMonth = strMonth - 1;
    if (strMonth == 0) {
        strYear--;strMonth = 12;
    }
    
    [self reloadDateForCalendarWatch];
}


@end
