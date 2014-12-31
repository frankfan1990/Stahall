//
//  Left_CustomerServiceViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-29.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "Left_CustomerServiceViewController.h"
#import "MainViewController.h"
#import "RESideMenu.h"
#import "Marcos.h"
#pragma mark - 我的客服
@interface Left_CustomerServiceViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *arroftitle;
    NSArray *arrOfconent;
}
@end

@implementation Left_CustomerServiceViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    arroftitle = @[@"姓名:",@"工号:",@"从业年限:",@"服务等级:"];
    arrOfconent = @[@"小龙包",@"10001",@"2年",@"五星"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1];
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
    title.text = @"专属客服";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}


#pragma mark- tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 150;
    }else if (indexPath.row == 5){
        return 150;
    }
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell0 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        cell0.backgroundColor = [UIColor clearColor];
        UIImageView  *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 140)];
        imageV.backgroundColor = [UIColor redColor];
        
        UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake( Mywidth/2-105/2,45/2,95, 95)];
        imageV2.backgroundColor = [UIColor whiteColor];
        imageV2.layer.masksToBounds = YES;
        imageV2.layer.cornerRadius = imageV2.frame.size.width/2;
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.backgroundColor = [UIColor greenColor];
        btn1.frame = CGRectMake(25, 140/2-25, 50, 50);
        btn1.layer.masksToBounds = YES;
        btn1.layer.cornerRadius = btn1.frame.size.width/2;
        [btn1 addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.backgroundColor = [UIColor greenColor];
        btn2.frame = CGRectMake(Mywidth-25-50, 140/2-25, 50, 50);
        btn2.layer.masksToBounds = YES;
        btn2.layer.cornerRadius = btn2.frame.size.width/2;
        [btn2 addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell0.contentView addSubview:imageV];
        [cell0.contentView addSubview:imageV2];
        [cell0.contentView addSubview:btn2];
        [cell0.contentView addSubview:btn1];
        
        return cell0;
    }else if (indexPath.row == 5){
        UITableViewCell *cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.backgroundColor = [UIColor clearColor];
        UIButton *callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        callBtn.frame = CGRectMake(60, 60, Mywidth-120, 38);
        callBtn.layer.masksToBounds = YES;
        callBtn.layer.cornerRadius = callBtn.frame.size.height/2;
        callBtn.backgroundColor = [UIColor greenColor];
        [callBtn setTitle:@"呼叫客服" forState:UIControlStateNormal];
        [callBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [callBtn addTarget:self action:@selector(didCallBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell1.contentView addSubview:callBtn];
        return cell1;
        
    }else{
       static NSString *str = @"mycell";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.5, 0, Mywidth, 44)];
            view.backgroundColor = [UIColor blackColor];
            view.alpha = 0.1;
            UILabel *labelOfTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 25)];
            [self Customlable:labelOfTitle text:@"" fontSzie:14 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:YES numberOfLines:1];
            
            UILabel *labelOfContent = [[UILabel alloc] initWithFrame:CGRectMake(Mywidth-210, 10, 200, 25)];
            [self Customlable:labelOfContent text:@"" fontSzie:14 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentRight adjustsFontSizeToFitWidth:YES numberOfLines:1];
            labelOfTitle.tag = 10001;
            labelOfContent.tag = 10002;
            [cell.contentView addSubview:view];
            [cell.contentView addSubview:labelOfTitle];
            [cell.contentView addSubview:labelOfContent];
        }
        UILabel *label1 = (UILabel *)[cell.contentView viewWithTag:10001];
        UILabel *label2 = (UILabel *)[cell.contentView viewWithTag:10002];
        label1.text = arroftitle[indexPath.row-1];
        label2.text = arrOfconent[indexPath.row-1];
        
        return cell;
    }
}
#pragma mark- 赞
-(void)didBtn:(UIButton *)sender
{
    
}
#pragma mark - 呼叫客服
-(void)didCallBtn:(UIButton *)sender
{
    
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
