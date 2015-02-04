//
//  Lef_MyMessageViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-29.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "Lef_MyMessageViewController.h"
#import "MainViewController.h"
#import "RESideMenu.h"
#import "Marcos.h"
#pragma mark - 我的消息
@interface Lef_MyMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *arr;
}

@end

@implementation Lef_MyMessageViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arr = [NSMutableArray array];
   
    for (int i=0; i<20; i++) {
       NSMutableArray *arrother = [NSMutableArray array];
        [arr addObject:arrother];
    }
    [self.view setBackgroundColor:[UIColor colorWithRed:98/255.0 green:192/255.0 blue:225/255.0 alpha:1]];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:98/255.0 green:192/255.0 blue:225/255.0 alpha:1];
    [self.view addSubview:_tableView];
}

#pragma mark - tableVIew的代理
#pragma mark - 组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr.count;
}
#pragma mark - cell个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arr[section] count];
}
#pragma mark - cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
#pragma mark - 底部高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
#pragma mark - 头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
#pragma mark - headView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIButton *headView =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 45)];
    headView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    headView.tag = section+2222;
  
    [headView addTarget:self action:@selector(didHeadView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 250, 45)];
    namelabel.text = @"@我的@消息@";
    namelabel.textAlignment = NSTextAlignmentLeft;
    namelabel.font = [UIFont systemFontOfSize:16];
    [headView addSubview:namelabel];
    
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(Mywidth - 35, 10, 30, 30)];
    headImage.image = [UIImage imageNamed:@"lc向右灰"];
    headImage.tag = headView.tag+100;
    [headView addSubview:headImage];
    
    
    if ([arr[section] count]) {
        headView.selected = YES;
        headImage.transform =  CGAffineTransformMakeRotation(M_PI_2);
    }else{
        headImage.transform =  CGAffineTransformMakeRotation(0);
        headView.selected = NO;
    }
    
    
    return headView;

    
}


#pragma mark - UITableViewCell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cellOther";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 点击头部
-(void)didHeadView:(UIButton *)sender
{
    
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:0 inSection:sender.tag-2222];
    UIImageView *image = (UIImageView *)[sender viewWithTag:sender.tag+100];
     sender.selected = !sender.selected;
    if (!sender.selected) {
        [UIView animateWithDuration:0.35 animations:^{
            image.transform =  CGAffineTransformMakeRotation(0);
        }];
        
        [arr[sender.tag-2222] removeAllObjects];
        [_tableView beginUpdates];
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [_tableView endUpdates];
        
        
    }else{
        [UIView animateWithDuration:0.35 animations:^{
            image.transform =  CGAffineTransformMakeRotation(M_PI_2);
        }];
        
        // 在这里把 数据加入到cell里面
        [arr[sender.tag-2222] addObject:@"one"];
        [_tableView beginUpdates];
        [_tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [_tableView endUpdates];
    }
   
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
    title.text = @"我的消息";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}

-(void)didGoBack
{
    MainViewController *mainViewController =[MainViewController new];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:mainViewController] animated:YES];
    [self.sideMenuViewController presentLeftMenuViewController];
}

@end
