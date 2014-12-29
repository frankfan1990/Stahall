//
//  RZTimeSelectedViewController.m
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-11.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import "RZTimeSelectedViewController.h"
#import "CreateShowSecondViewController.h"
#import "NSDate+Utilities.h"
@interface RZTimeSelectedViewController ()
{
    CreateShowSecondViewController *addCtrl;
    NSString *_date;
    NSString *_time;
    CGFloat width,height;
    UIDatePicker *_datePicker;
    UIDatePicker *_timePicker;
    UILabel *lable;
    NSString *str;
    NSString *dateStr;
}
@end

@implementation RZTimeSelectedViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate *date1 = [NSDate date];
    self.view.backgroundColor = [UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1];
    dateStr=[NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld",(long)date1.year,(long)date1.month,(long)date1.day,(long)date1.hour,(long)date1.minute];
    width=self.view.frame.size.width;
    height=self.view.frame.size.height;
    addCtrl = self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
    [self setTabBar];
    [self createDate];
    [self createView];
}


#pragma mark - TabBar的设置
-(void)setTabBar
{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:115/255.0 green:199/255.0 blue:228/255.0 alpha:1]];
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLeft setFrame:CGRectMake(0, 0, 35, 35)];
    [btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateHighlighted];
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:17];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"完成" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 10, 40, 45)];;
    btn2.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(didBtn2) forControlEvents:UIControlEventTouchUpInside];
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
    

    
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    title.text = @"商业演出";
    
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}
-(void)createView
{
    lable=[[UILabel alloc] initWithFrame:CGRectMake(5, 10+200*height/667.0+20, width-10,60*height/667.0)];
    lable.layer.cornerRadius=10;
    lable.layer.masksToBounds = YES;
    

 
    if (![_date length]) {
        //获取当前时间
        NSDate *date1 = [NSDate date];
        str=[NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld",(long)date1.year,(long)date1.month,(long)date1.day,(long)date1.hour,(long)date1.minute];
        
    }else {
            str=[NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld",(long)_datePicker.date.year,(long)_datePicker.date.month,(long)_datePicker.date.day,(long)_timePicker.date.hour,(long)_timePicker.date.minute];
    }
    lable.text=str;
    lable.textColor=[UIColor whiteColor];
    lable.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    lable.font=[UIFont systemFontOfSize:30*height/667.0];
    lable.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:lable];
  
    
}
-(void)createDate
{
    
    UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(5, 20, width-10, 200*height/667.0)];
    
    view1.clipsToBounds=YES;
    [self.view addSubview:view1];
    _datePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, -35, 0, 0)];
    CGFloat height1 = _datePicker.frame.size.height;
    CGFloat y = (view1.frame.size.height - height1) / 2;
    
    if ([_date length]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        _datePicker.date = [dateFormatter dateFromString:_date];
    }
    
    _datePicker.frame = CGRectMake(0, y, 0, 0);
    _datePicker.datePickerMode=UIDatePickerModeDate;
    [_datePicker addTarget:self action:@selector(didDate) forControlEvents:UIControlEventValueChanged];
    [view1 addSubview:_datePicker];
    
    
    UIView *view2=[[UIView alloc] initWithFrame:CGRectMake(5, 10+200*height/667.0+20+60*height/667.0+10, width-10, 200*height/667.0)];
    view1.layer.cornerRadius=10;
    view2.layer.cornerRadius=10;
    view2.clipsToBounds=YES;
    [self.view addSubview:view2];
    
    _timePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, y, 0, 0)];
    if ([_time length]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        _timePicker.date = [dateFormatter dateFromString:_time];
    }
    _timePicker.datePickerMode=UIDatePickerModeTime;
    [_timePicker addTarget:self action:@selector(didDate) forControlEvents:UIControlEventValueChanged];
    [view2 addSubview:_timePicker];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)didDate
{
    lable.text= [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld",(long)_datePicker.date.year,(long)_datePicker.date.month,(long)_datePicker.date.day,(long)_timePicker.date.hour,(long)_timePicker.date.minute];
    
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)didBtn2
{
     NSDate *date1 = [NSDate date];
    NSString *nowDateStr = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld",(long)date1.year,(long)date1.month,(long)date1.day,(long)date1.hour,(long)date1.minute];
    if ([lable.text compare:nowDateStr] <= 0 ) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"\n请设置未来时间" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else {
        addCtrl.field1.text = lable.text;
        [addCtrl addData: lable.text];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)getDate:(NSString *)date Time:(NSString *)time
{
    _date = date;
    _time = time;
}
@end
