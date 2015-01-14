//
//  SecondAccountsViewController.m
//  Stahall
//
//  Created by JM_Pro on 15-1-13.
//  Copyright (c) 2015年 Rching. All rights reserved.
//

#import "SecondAccountsViewController.h"
#import "AddSecondAccoutsViewController.h"
#import "DetailsSecondAccountViewController.h"
#import "AFNetworking.h"
#import "Marcos.h"
#import "ProgressHUD.h"
#pragma mark - 二级账号列表

@interface SecondAccountsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *arrOfdata;
}
@end

@implementation SecondAccountsViewController

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
    self.view.backgroundColor = [UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1];
    [self.view addSubview:_tableView];
    [self getData];
}


#pragma mark - 得到数据
-(void)getData
{
    [ProgressHUD show:@"正在加载" Interaction:NO];
    
//    __weak typeof (self)Myself = self;
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/plain",@"text/html"]];
    [manger GET:SecondAccountListIP parameters:@{@"parentId":@"78955a4c-6b00-4999-96eb-1b2334b4f7b5"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ProgressHUD dismiss];
        arrOfdata = responseObject[@"results"];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD showError:@"网络异常"];
    }];
}
#pragma mark - tabBar的设置
-(void)setTabBar
{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:115/255.0 green:199/255.0 blue:228/255.0 alpha:1]];
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLeft.layer.masksToBounds = YES;
    btnLeft.layer.cornerRadius = 20;
    [btnLeft setFrame:CGRectMake(0, 0, 35, 35)];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateHighlighted];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(didGoBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    UIButton*  btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"增加" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 10, 40, 45)];;
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(didAdd) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnright = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -5;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        self.navigationItem.rightBarButtonItems= @[negativeSpacer, btnright];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
        self.navigationItem.rightBarButtonItem = btnright;
    }
    
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    title.text = @"二级账号";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
}



#pragma mark - tableVIew的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOfdata.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label1 = [[UILabel alloc] init];
        label1.frame = CGRectMake(15, 5, Mywidth-30, 20);
        [self Customlable:label1 text:nil fontSzie:15 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:YES numberOfLines:1];
        label1.tag = 10001;
        [cell.contentView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.frame = CGRectMake(15, 30, Mywidth-30, 20);
        [self Customlable:label2 text:nil fontSzie:15 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:YES numberOfLines:1];
        label2.tag = 10002;
        [cell.contentView addSubview:label2];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 54.5, Mywidth, 0.5)];
        line.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
        [cell.contentView addSubview:line];
        
        
    }
    UILabel *label1 = (UILabel *)[cell.contentView viewWithTag:10001];
    UILabel *label2 = (UILabel *)[cell.contentView viewWithTag:10002];
    
 
    
    label1.text = [NSString stringWithFormat:@"姓名：%@",arrOfdata[indexPath.row][@"nickName"]];
    label2.text = [NSString stringWithFormat:@"账户名：%@",arrOfdata[indexPath.row][@"userAccount"]];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsSecondAccountViewController *detatlCtrl = [[DetailsSecondAccountViewController alloc] init];
    detatlCtrl.data = arrOfdata[indexPath.row];
    [self.navigationController pushViewController:detatlCtrl animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 增加二级账号
-(void)didAdd{
    AddSecondAccoutsViewController *addCtrl = [[AddSecondAccoutsViewController alloc] init];
    [self.navigationController pushViewController:addCtrl animated:YES];
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
@end
