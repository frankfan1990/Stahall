//
//  TangHuiListViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-18.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "TangHuiListViewController.h"
#import "ShowMallsTableViewCell.h"
#import "ShowDetailsViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "Marcos.h"

#pragma mark -  堂汇 列表
@interface TangHuiListViewController()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *arrData;
}

@end
@implementation TangHuiListViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)viewDidLoad
{
    [self setTabBar];
    [self.view setBackgroundColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]];
    
    //取数据
    [self getData];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,Mywidth, Myheight -64) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
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
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLeft.layer.masksToBounds = YES;
    btnLeft.layer.cornerRadius = 20;
    [btnLeft setFrame:CGRectMake(0, 0, 35, 35)];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateHighlighted];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(didGoBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
    }
    
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    title.text = @"堂汇";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}

-(void)getData
{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/plain"]];
    //秀mall数据
    NSDictionary *parameterdic = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"start",@"20",@"limit",@"堂汇",@"query",nil];
    [manger GET:MALLListIP parameters:parameterdic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        arrData = (NSArray *)responseObject[@"results"];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
    }];
    
}

#pragma mark - tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    return 200;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    static NSString *cellStr = @"mycell";
    ShowMallsTableViewCell *cell = (ShowMallsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[ShowMallsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        cell.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.imageV.image = [UIImage imageNamed:@"七夕"];
    if (arrData.count != 0) {
        cell.labelOfTitle.text = arrData[indexPath.row][@"title"];
        cell.labelOfDate.text = arrData[indexPath.row][@"timer"];
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:arrData[indexPath.row][@"titlePage"]] placeholderImage:[UIImage imageNamed:@""]];
    }
   
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowDetailsViewController *details = [[ShowDetailsViewController alloc] init];
    details.titleViewStr  = @"堂汇详情";
    [self.navigationController pushViewController:details animated:YES];
}

-(void)didGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end