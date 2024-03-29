//
//  Left_HelpCenterViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-29.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "Left_HelpCenterViewController.h"
#import "AFNetworking.h"
#import "MainViewController.h"
#import "ProgressHUD.h"
#import "RESideMenu.h"
#import "Marcos.h"
#pragma mark - 帮助中心
@interface Left_HelpCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *btnLeft;
    UIButton *btnRight;
    UITableView *_tableView;
    NSString *data1;
    NSString *data2;
    NSString *number;
}
@end

@implementation Left_HelpCenterViewController
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
    [self.view setBackgroundColor:[UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1]];
    [self getData];
    btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLeft.selected = YES;
    btnRight.selected = NO;
    
    [btnLeft setTitle:@"公司简介" forState:UIControlStateNormal];
    [btnLeft setTitleColor:[UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1] forState:UIControlStateSelected];
    [btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(didLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    [btnRight setTitle:@"帮助中心" forState:UIControlStateNormal];
    [btnRight setTitleColor:[UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1] forState:UIControlStateSelected];
    [btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(didRightBtn) forControlEvents:UIControlEventTouchUpInside];
    btnLeft.backgroundColor = [UIColor whiteColor];
    btnRight.backgroundColor = [UIColor clearColor];
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 45)];
     myView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:myView];
    UIView *bakcView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, Mywidth-20, 35)];
   
    bakcView.backgroundColor = [UIColor clearColor];
    bakcView.layer.masksToBounds = YES;
    bakcView.layer.cornerRadius = 5;
    bakcView.layer.borderWidth = 0.5;
    bakcView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    btnLeft.frame = CGRectMake(0, 0, bakcView.frame.size.width/2, bakcView.frame.size.height);
    btnRight.frame = CGRectMake(bakcView.frame.size.width/2, 0, bakcView.frame.size.width/2, bakcView.frame.size.height);
    
    [bakcView addSubview:btnLeft];
    [bakcView addSubview:btnRight];
    [myView addSubview:bakcView];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, Mywidth, Myheight-64-45) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getData
{
    [ProgressHUD show:nil];
    __block int i = 0;
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/plain",@"text/html"]];
    [manger GET:HelpCenterIP parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        i++;
        if (i==2) {
            [ProgressHUD showSuccess:@"加载成功"];
        }
        NSDictionary *dic = (NSDictionary *)responseObject;
        data2 = [NSString stringWithFormat:@"%@",dic[@"data"][@"helpCenter"]];
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD showError:@"网络异常"];
    }];
    
    [manger GET:CompanyProfileIP parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        i++;
        if (i==2) {
            [ProgressHUD showSuccess:@"加载成功"];
        }
        NSDictionary *dic = (NSDictionary *)responseObject;
        data1 = dic[@"data"][@"aboutContent"];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD showError:@"网络异常"];
    }];

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
    [btnLeft2 setFrame:CGRectMake(0, 0, 30, 30)];
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
    title.text = @"帮助中心";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}


#pragma mark - tableView的代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (btnLeft.selected) {
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if (btnLeft.selected) {
            return 370;
        }else{
            return 455;
        }
       
    }else{
        return 50;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        UITableViewCell *cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        UIWebView *webView =[[UIWebView alloc] init];
        if (btnLeft.selected) {
            webView.frame = CGRectMake(0, 0, Mywidth, 370);
            [webView loadHTMLString:data1 baseURL:nil];
        }else{
            webView.frame = CGRectMake(0, 0, Mywidth, 455);
            [webView loadHTMLString:data2 baseURL:nil];
        }
        webView.backgroundColor = [UIColor clearColor];
        webView.opaque = NO;
        
        [cell.contentView addSubview:webView];
        
        return cell;
    }else{
        UITableViewCell *cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        cell.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(60, 20, Mywidth-120, 35);
        [btn setTitle:@"联系我们" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithRed:78/255.0 green:218/255.0 blue:68/255.0 alpha:1];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = btn.frame.size.height/2;
        [btn addTarget:self action:@selector(didCall:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn];
        return cell;
    }
 
}


-(void)didGoBack
{
    MainViewController *mainViewController =[MainViewController new];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:mainViewController] animated:YES];
    [self.sideMenuViewController presentLeftMenuViewController];
}

#pragma mark -点击事件
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

-(void)didCall:(UIButton *)sender{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:13212341234"]]];
}

@end
