//
//  Left_HelpCenterViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-29.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "Left_HelpCenterViewController.h"
#import "MainViewController.h"
#import "RESideMenu.h"
#import "Marcos.h"
#pragma mark - 帮助中心
@interface Left_HelpCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *btnLeft;
    UIButton *btnRight;
    UITableView *_tableView;
}
@end

@implementation Left_HelpCenterViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1]];
    
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
    btnRight.backgroundColor = [UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1];
    
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
        return 300;
    }else{
        return 150;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        UITableViewCell *cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else{
        UITableViewCell *cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        cell.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(60, 40, Mywidth-120, 35);
        [btn setTitle:@"联系我们" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor greenColor];
        btn.layer.masksToBounds = YES;
        btn.alpha = 0.8;
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

#pragma mark -点击 我的项目 我的估价 事件
-(void)didLeftBtn{
    btnLeft.selected  = YES;
    btnRight.selected = NO;
    btnRight.backgroundColor = [UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1];
    [UIView animateWithDuration:0.3 animations:^{
        btnLeft.backgroundColor = [UIColor whiteColor];
        
    }];
    [_tableView reloadData];
    
}
-(void)didRightBtn{
    btnLeft.selected  = NO;
    btnRight.selected = YES;
    btnLeft.backgroundColor = [UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1];
    [UIView animateWithDuration:0.3 animations:^{
        btnRight.backgroundColor = [UIColor whiteColor];
        
    }];
    [_tableView reloadData];
}

-(void)didCall:(UIButton *)sender{
    
}

@end
