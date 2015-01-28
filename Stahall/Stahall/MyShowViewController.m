//
//  MyShowViewController.m
//  Stahall
//
//  Created by frankfan on 14/12/14.
//  Copyright (c) 2014年 Rching. All rights reserved.
//
//FIXME: 我的演出

#import "MyShowViewController.h"
#import "RESideMenu.h"
#import "Marcos.h"
#import "MainViewController.h"
#import "CreateShowFirstViewController.h"
#import "ProgressHUD.h"
#import "AFNetworking.h"
#import "StahallEvalutionDetailInfoViewController.h"
#import "MyShowDetailsViewController.h"
@interface MyShowViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView *_tableView;
    UIButton *btnLeft;
    UIButton *btnRight;
    NSArray *arrOfHeadTitleOne;
    NSArray *arrOfHeadTitleTwo;
    
    //三个数组对应 三个我的演出状态的数据
    NSMutableArray *data1;
    NSMutableArray *data2;
    NSMutableArray *data3;
    
    //两个数组 对应 我的估价两个状态
    NSMutableArray *dataOther1;
    NSMutableArray *dataOther2;
 
}
@end
@implementation MyShowViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [ProgressHUD dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self Variableinitialization];
    [self getData];
    [self.view setBackgroundColor:[UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1]];
    btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLeft.selected = YES;
    btnRight.selected = NO;
    
    [btnLeft setTitle:@"我的项目" forState:UIControlStateNormal];
    [btnLeft setTitleColor:[UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1] forState:UIControlStateSelected];
    [btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(didLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [btnRight setTitle:@"我的估价" forState:UIControlStateNormal];
    [btnRight setTitleColor:[UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1] forState:UIControlStateSelected];
    [btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(didRightBtn) forControlEvents:UIControlEventTouchUpInside];
    btnLeft.backgroundColor = [UIColor whiteColor];
    btnRight.backgroundColor = [UIColor clearColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight-64-45) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionFooterHeight = 0.001;
    [self.view addSubview:_tableView];
    
    UIButton *addNewShowBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    addNewShowBtn.frame = CGRectMake(0, Myheight-45-64,Mywidth, 45);
    [addNewShowBtn setTitle:@"新建演出" forState:UIControlStateNormal];
    [addNewShowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addNewShowBtn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    
    [addNewShowBtn addTarget:self action:@selector(didAddNewShow) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addNewShowBtn];
    
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
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1]];
    
    UIButton *btnLeft2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLeft2.layer.masksToBounds = YES;
    btnLeft2.layer.cornerRadius = 20;
    [btnLeft2 setFrame:CGRectMake(0, 0, 35, 35)];
    [btnLeft2 setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateNormal];
    [btnLeft2 setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateHighlighted];
    [btnLeft2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft2 addTarget:self action:@selector(didGoBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft2];
    
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
    }
    
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    title.text = @"我的演出";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}
#pragma mark - 变量的初始化
-(void)Variableinitialization
{
    data1 = [NSMutableArray array];
    data2 = [NSMutableArray array];
    data3 = [NSMutableArray array];
    dataOther1 = [NSMutableArray array];
    dataOther2 = [NSMutableArray array];
    arrOfHeadTitleOne = @[@"待审核",@"进行中",@"已完成"];
    arrOfHeadTitleTwo = @[@"估价中",@"已完成"];
    
}


-(void)getData{

    [dataOther1 removeAllObjects];
    [dataOther2 removeAllObjects];
    [data1 removeAllObjects];
    [data2 removeAllObjects];
    [data3 removeAllObjects];
    [ProgressHUD show:@"正在加载" Interaction:NO];
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/plain",@"text/html"]];
    manger.requestSerializer.timeoutInterval = 10;
    __block int count = 0;
    __block int isfailure = 0;
        /*
         
         我的演出的数据
          
         */
//    __weak typeof (self)mySelf = self;
    NSDictionary *dic1 = @{@"businessId":@"47e92fdc-d546-46c9-af66-436568094d5c"};
    [manger GET:MyShowsIP parameters:dic1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        count++;
        if (count == 2) {
            [ProgressHUD showSuccess:@"加载完成"];
        }
            
        NSDictionary *datadic = (NSDictionary *)responseObject;
        for (NSDictionary *dd in datadic[@"results"]) {
                
            if ([dd[@"status"] intValue] == 0) {
                [data1 addObject:dd];
            }else if ([dd[@"status"] intValue] == 3) {
                [data2 addObject:dd];
            }else if ([dd[@"status"] intValue] == 4) {
                [data3 addObject:dd];
            }
        }
            [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        isfailure++;
        NSLog(@"%@",error);
        if (isfailure == 1) {
            [ProgressHUD showError:@"加载失败"];
        }
    }];
    /*
     
     我的估价的数据
     
     */
    
    [manger GET:MyValuationIP parameters:dic1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        count++;
        if (count == 2) {
            [ProgressHUD showSuccess:@"加载完成"];
        }
        
        NSDictionary *datadic = (NSDictionary *)responseObject;
        for (NSDictionary *dd in datadic[@"results"]) {
            if ([dd[@"status"] intValue] == 0) {
                [dataOther1 addObject:dd];
            }else if ([dd[@"status"] intValue] == 1) {
                [dataOther2 addObject:dd];
            }
        }
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        isfailure++;
        if (isfailure == 1) {
            [ProgressHUD showError:@"加载失败"];
           
        }
        
    }];

}

#pragma mark - UIAlertView代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self getData];
    }
}

#pragma mark - tableView 好多分组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (btnLeft.selected) {
        return arrOfHeadTitleOne.count+1;
    }else{
        return arrOfHeadTitleTwo.count+1;
    }
}

#pragma mark - tableView的 每一组有几个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (btnLeft.selected) {
        if (section == 1) {
            return data1.count;
        }else if (section == 2){
            return data2.count;
        }else if (section == 3){
            return data3.count;
        }
    }else{
        if (section == 1) {
            return dataOther1.count;
        }else if (section == 2){
            return dataOther2.count;
        }
    }
    return  0;
}

#pragma mark - tableView———headView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    if (section == 0) {
        UIView *myView = [[UIView alloc] init];
        UIView *bakcView = [[UIView alloc] initWithFrame:CGRectMake(10, 8, Mywidth-20, 35)];
        bakcView.layer.masksToBounds = YES;
        bakcView.layer.cornerRadius = 5;
        bakcView.layer.borderWidth = 0.5;
        bakcView.layer.borderColor = [UIColor whiteColor].CGColor;
       
        btnLeft.frame = CGRectMake(0, 0, bakcView.frame.size.width/2, bakcView.frame.size.height);
        btnRight.frame = CGRectMake(bakcView.frame.size.width/2, 0, bakcView.frame.size.width/2, bakcView.frame.size.height);
        
        [bakcView addSubview:btnLeft];
        [bakcView addSubview:btnRight];
        [myView addSubview:bakcView];
        
        return myView;
    }
    else{
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 45)];
        backView.backgroundColor = [UIColor clearColor];
        
        UIView *myview = [[UIView alloc] initWithFrame:CGRectMake(0, 5, Mywidth, 40)];
        myview.backgroundColor = [UIColor blackColor];
        myview.alpha = 0.2;
        [backView addSubview:myview];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(8, 15, 20, 20)];
        imageV.layer.masksToBounds = YES;
        imageV.layer.cornerRadius = 10;
        
        UILabel *labeilOfTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 15, 60, 20)];
        
        if (btnLeft.selected) {
            
            if (section == 1) {
                imageV.backgroundColor = [UIColor orangeColor];
            }else if (section == 2){
                imageV.backgroundColor = [UIColor redColor];
            }else if(section == 3){
                imageV.backgroundColor = [UIColor greenColor];
            }
            
            [self Customlable:labeilOfTitle text:arrOfHeadTitleOne[section-1] fontSzie:15 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter adjustsFontSizeToFitWidth:NO numberOfLines:1];
            labeilOfTitle.textColor = [UIColor whiteColor];
            
        }else{
            
            [self Customlable:labeilOfTitle text:arrOfHeadTitleTwo[section-1] fontSzie:15 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter adjustsFontSizeToFitWidth:NO numberOfLines:1];
            labeilOfTitle.textColor = [UIColor whiteColor];
            if (section == 1) {
                imageV.backgroundColor = [UIColor orangeColor];
            }else if (section == 2){
                imageV.backgroundColor = [UIColor greenColor];
            }
        }
        [backView addSubview:imageV];
        [backView addSubview:labeilOfTitle];
       
        return backView;
    }
   
}
#pragma mark - tableView的 headView的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 55;
    }else{
        return 45;
    }
}

#pragma mark - tableView的 每一个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 0.01;
    }
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"Mycell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *labelOfConten = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, Mywidth-20-120, 20)];
        UILabel *labelOfDate = [[UILabel alloc] initWithFrame:CGRectMake(Mywidth-120, 10, 110, 20)];

        labelOfConten.tag = 10000;
        labelOfDate.tag = 100000;
        [self Customlable:labelOfConten text:nil fontSzie:14 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
         [self Customlable:labelOfDate text:nil fontSzie:12 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentRight adjustsFontSizeToFitWidth:NO numberOfLines:1];
        [cell.contentView addSubview:labelOfConten];
        [cell.contentView addSubview:labelOfDate];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,0, Mywidth, 0.5)];
        lineView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        lineView.tag = 10003;
        [cell.contentView addSubview:lineView];
        
    }
    UILabel *labelContent = (UILabel *)[cell.contentView viewWithTag:10000];
    UILabel *labelOfDate = (UILabel *)[cell.contentView viewWithTag:100000];
    labelOfDate.textColor = [UIColor whiteColor];
    labelContent.textColor = [UIColor whiteColor];
    UIView *view = (UIView *)[cell.contentView viewWithTag:10003];
    if (indexPath.row == 0 ) {
        view.hidden = YES;
    }else{
        view.hidden = NO;
    }
    
    
    if (btnLeft.selected) {
        if (indexPath.section == 1) {
            labelContent.text = data1[indexPath.row][@"showName"];
            labelOfDate.text = [data1[indexPath.row][@"createTime"] substringToIndex:16];
        }else if (indexPath.section == 2){
            labelContent.text = data2[indexPath.row][@"showName"];
            labelOfDate.text = [data2[indexPath.row][@"createTime"] substringToIndex:16];
        }else if (indexPath.section == 3){
            labelContent.text = data3[indexPath.row][@"showName"];
            labelOfDate.text = [data3[indexPath.row][@"createTime"] substringToIndex:16];
        }
    }else{
        if (indexPath.section == 1) {
            labelContent.text = dataOther1[indexPath.row][@"showName"];
            labelOfDate.text = [dataOther1[indexPath.row][@"createTime"] substringToIndex:16];
        }else if (indexPath.section == 2){
            labelContent.text = dataOther2[indexPath.row][@"showName"];
            labelOfDate.text = [dataOther2[indexPath.row][@"createTime"] substringToIndex:16];
        }
    }
   
    
    return cell;
}

#pragma mark - 导航栏按钮触发
- (void)didGoBack{

    MainViewController *mainViewController =[MainViewController new];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:mainViewController] animated:YES];
    [self.sideMenuViewController presentLeftMenuViewController];
  
}


#pragma mark -点击 我的项目 我的估价 事件
-(void)didLeftBtn{
    btnLeft.selected  = YES;
    btnRight.selected = NO;
      btnRight.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        btnLeft.backgroundColor = [UIColor whiteColor];
      
    }];
    [_tableView reloadData];

}
-(void)didRightBtn{
    btnLeft.selected  = NO;
    btnRight.selected = YES;
    btnLeft.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        btnRight.backgroundColor = [UIColor whiteColor];
        
    }];
    [_tableView reloadData];
}

-(void)didAddNewShow{
    CreateShowFirstViewController *createCtrl = [[CreateShowFirstViewController alloc] init];
    [self.navigationController pushViewController:createCtrl animated:YES];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - cell被点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if(btnRight.selected){//我的估价
    
        StahallEvalutionDetailInfoViewController *starhallEvalutionCV =[StahallEvalutionDetailInfoViewController new];
        NSDictionary *dict = nil;
        
        if(indexPath.section==1){//估价中
            
            dict = dataOther1[indexPath.row];
            starhallEvalutionCV.isCouldSpeedModle = YES;
            
            
            
        }else{//估价完
            
            dict = dataOther2[indexPath.row];
            starhallEvalutionCV.isCouldSpeedModle = NO;
        }
        
        starhallEvalutionCV.showName = dict[@"showName"];
        starhallEvalutionCV.showAddress = dict[@"showAddress"];
        starhallEvalutionCV.showTime = dict[@"showTime"];
        starhallEvalutionCV.showAnotherTime = dict[@"alternativeTime"];
        starhallEvalutionCV.airPlane = dict[@"directArport"];
        starhallEvalutionCV.showPlace = dict[@"showVenues"];
        
        starhallEvalutionCV.valuationId = dict[@"valuationId"];
        starhallEvalutionCV.isFirstPort = NO;


        [self.navigationController pushViewController:starhallEvalutionCV animated:YES];

    }else{
        MyShowDetailsViewController *detailCtrl = [[MyShowDetailsViewController alloc] init];
        if (indexPath.section == 1) {
            detailCtrl.dicData = data1[indexPath.row];
        }else if (indexPath.section == 2) {
            detailCtrl.dicData = data2[indexPath.row];
        }else if (indexPath.section == 3) {
            detailCtrl.dicData = data3[indexPath.row];
        }
        
        detailCtrl.hasEvationStars = dataOther2;
        [self.navigationController pushViewController:detailCtrl animated:YES];
       
    }
    
}


@end
