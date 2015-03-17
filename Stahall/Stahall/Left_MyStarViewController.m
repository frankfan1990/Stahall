//
//  Left_MyStarViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-29.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "Left_MyStarViewController.h"
#import "MySegmentCtrol.h"
#import "MainViewController.h"
#import "RESideMenu.h"
#import "Marcos.h"
#pragma mark - 我的艺人
@interface Left_MyStarViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    MySegmentCtrol *mysegmentView;
}
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)UITableView *tableView;@end

@implementation Left_MyStarViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _index = 0;
    [self.view setBackgroundColor:[UIColor colorWithRed:98/255.0 green:192/255.0 blue:225/255.0 alpha:1]];
    mysegmentView = [[MySegmentCtrol alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 45)];
    mysegmentView.items = @[@"我推荐",@"我需要"];
    mysegmentView.selecedIndex = 0;
    mysegmentView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
    __weak typeof (self)Myself = self;
    mysegmentView.didselecedAtIndex = ^(MySegmentCtrol *seg,NSInteger index){
        Myself.index = index;
        [Myself.tableView reloadData];
        
    };
    [self.view addSubview:mysegmentView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, Mywidth, Myheight-45-64) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
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
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:115/255.0 green:199/255.0 blue:228/255.0 alpha:1]];
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLeft.layer.masksToBounds = YES;
    btnLeft.layer.cornerRadius = 20;
    [btnLeft setFrame:CGRectMake(0, 0, 30, 30)];
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
    title.text = @"我的艺人";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}

#pragma mark - tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_index == 0) {
        static NSString *str = @"Mycell_1";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 60)];
            bgView.tag = 10000;
            [cell.contentView addSubview:bgView];
            
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(11, 7.5, 45, 45)];
            imageV.tag = 10001;
            imageV.layer.masksToBounds = YES;
            imageV.layer.cornerRadius = imageV.frame.size.width/2;
            [cell.contentView addSubview:imageV];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70, 17.5, Mywidth-110, 25)];
            label.tag = 10002;
            [self Customlable:label text:@"" fontSzie:17 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:YES numberOfLines:1];
            [cell.contentView addSubview:label];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"朝右箭头icon"] forState:UIControlStateNormal];
            btn.frame = CGRectMake(Mywidth - 35, 17.5, 25, 25);
            [cell.contentView addSubview:btn];
            
        }
        UIImageView *imageV = (UIImageView *)[cell.contentView viewWithTag:10001];
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:10002];
        UIView *bgView = (UIView *)[cell.contentView viewWithTag:10000];
        if (indexPath.row%2) {
            bgView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
            
        }else{
            bgView.backgroundColor = [UIColor blackColor];
            bgView.alpha = 0.03;
            
        }
        imageV.image = [UIImage imageNamed:@"lc汪峰头像"];
        label.text = @"汪峰";
        return cell;
        
    }else{
        static NSString *str_2 = @"Mycell_2";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:str_2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"朝右箭头icon"] forState:UIControlStateNormal];
            btn.frame = CGRectMake(Mywidth - 35, 17.5, 25, 25);
            [cell.contentView addSubview:btn];
            
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 60)];
            bgView.tag = 10003;
            [cell.contentView addSubview:bgView];
            
            
            UILabel *labelOftitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, Mywidth-50, 25)];
            labelOftitle.tag = 10004;
            [self Customlable:labelOftitle text:@"" fontSzie:16 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
            [cell.contentView addSubview:labelOftitle];
            
            UILabel *labelOfdate = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, Mywidth-50, 20)];
            labelOfdate.tag = 10005;
            [self Customlable:labelOfdate text:@"" fontSzie:12 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
            [cell.contentView addSubview:labelOfdate];
            
        }
        
        UIView *bgView = (UIView *)[cell.contentView viewWithTag:10003];
        if (indexPath.row%2) {
            bgView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.05];
            
        }else{
            bgView.backgroundColor = [UIColor blackColor];
            bgView.alpha = 0.03;
            
        }
        
        UILabel *labelOfTitle = (UILabel *)[cell.contentView viewWithTag:10004];
        UILabel *labelOfDate = (UILabel *)[cell.contentView viewWithTag:10005];
        
        labelOfTitle.text = @"伟建 全国巡回超级演唱会劲爆来袭！";
        labelOfDate.text = @"2015-01-22";
        
        
        return cell;
    }
    
}



-(void)didGoBack
{
    MainViewController *mainViewController =[MainViewController new];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:mainViewController] animated:YES];
    [self.sideMenuViewController presentLeftMenuViewController];
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
