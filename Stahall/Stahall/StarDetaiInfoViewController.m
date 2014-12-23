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
#import "FXBlurView.h"
/********/



@interface StarDetaiInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
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

    UIView *mainView;//用于承载没有复用的那部分view

    /***********************/
    
    UIWebView *webView;
    NSMutableArray *beforeSelectedButton;//记录之前选中的button
    
    UIButton *introductionButton;
    UIButton *priceButton;
    UIButton *dateButton;
    UIButton *requireButton;
}
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation StarDetaiInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  @author frankfan, 14-12-23 17:12:36
     *
     *  日历相关
     */
    
    mainView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 330)];
    mainView.backgroundColor =[UIColor colorWithWhite:0 alpha:0];
    mainView.backgroundColor =[UIColor clearColor];
    
    
    strYear = [[Datetime GetYear] intValue];
    strMonth = [[Datetime GetMonth] intValue];
    _dayArray = [Datetime GetDayArrayByYear:strYear andMonth:strMonth];
    
    
    
    NSString *todayString =[NSString stringWithFormat:@"%@",[NSDate date]];
    self.today = [@[todayString]mutableCopy];
    
    self.travelDay = [@[@"2014-11-11",@"2014-12-1",@"2014-12-3",@"2014-11-20"]mutableCopy];//旷课
    self.showDay = [@[@"2014-11-7",@"2014-11-26",@"2014-12-2"]mutableCopy];
    
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
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-44) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:self.tableView];
    
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
    
    //创建button
    
    introductionButton =[self createButtonWithTag:1001 andTitle:@"简介" andBackGroundImage:nil andFrame:CGRectMake(0, 150,320.0/4 , 50)];
    priceButton =[self createButtonWithTag:1002 andTitle:@"价格" andBackGroundImage:nil andFrame:CGRectMake(320.0/4, 150, 320.0/4, 50)];
    
    dateButton =[self createButtonWithTag:1003 andTitle:@"档期" andBackGroundImage:nil andFrame:CGRectMake(320.0/4*2, 150, 320.0/4, 50)];
    
    requireButton =[self createButtonWithTag:1004 andTitle:@"要求" andBackGroundImage:nil andFrame:CGRectMake(320.0/4*3, 150, 320.0/4, 50)];
 
    
    
    
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
    
    static NSString *cellName =@"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellName];
    if(!cell){
    
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.selectionStyle = NO;
        
        if(indexPath.section==0){
        
            [cell.contentView addSubview:webView];
            
            [cell.contentView addSubview:introductionButton];
            [cell.contentView addSubview:priceButton];
            [cell.contentView addSubview:dateButton];
            [cell.contentView addSubview:requireButton];
        }
        
        if(indexPath.section==1){
        
            cell.backgroundColor =[UIColor clearColor];
            [cell.contentView addSubview:mainView];
        }
        
    }
    
    
    
    return cell;
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
    
        return 330;
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
    
    //
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
                [button setImage:[UIImage imageNamed:@"请假64.png"] forState:UIControlStateNormal];
            }
            if ([self overTimeYear:myYear Month:myMonth Day:(int)[_dayArray[i] integerValue] With:2]) {
                [button setImage:[UIImage imageNamed:@"旷课64.png"] forState:UIControlStateNormal];
            }
            if ([self overTimeYear:myYear Month:myMonth Day:(int)[_dayArray[i] integerValue] With:3]) {
                [button setImage:[UIImage imageNamed:@"有课64.png"] forState:UIControlStateNormal];
            }
            if ([_dayArray[i + 1] integerValue] == 1) {
                before = NO;
            }
#pragma mark - 修改颜色
            label.textColor = [UIColor blackColor];
        }
        else if (normal){
            if ([self overTimeYear:strYear Month:strMonth Day:(int)[_dayArray[i] integerValue] With:1]) {
                [button setImage:[UIImage imageNamed:@"请假64.png"] forState:UIControlStateNormal];
            }
            if ([self overTimeYear:strYear Month:strMonth Day:(int)[_dayArray[i] integerValue] With:2]) {
                [button setImage:[UIImage imageNamed:@"旷课64.png"] forState:UIControlStateNormal];
            }
            if ([self overTimeYear:strYear Month:strMonth Day:(int)[_dayArray[i] integerValue] With:3]) {
                [button setImage:[UIImage imageNamed:@"有课64.png"] forState:UIControlStateNormal];
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
