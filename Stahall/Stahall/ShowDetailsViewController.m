//
//  ShowDetailsViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-16.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "ShowDetailsViewController.h"
#import "Marcos.h"
#pragma mark -  轮播海报  堂汇 艺人堂 内容详情
@interface ShowDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *arrOfTitle;
    NSMutableArray *arrOfcontent;
}
@end

@implementation ShowDetailsViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrOfTitle = @[@"活动名称:",@"时       间:",@"地       点:",@"场       馆:",@"出场艺人:",@"主办单位:"];
    arrOfcontent = [NSMutableArray arrayWithObjects:@"2014许巍长沙演唱会",@"2014-12-30 08:00",@"湖南长沙",@"湖南大剧院",@"许巍、张三、李四",@"艺人堂文化传媒", nil];
    
    
    [self setTabBar];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,Mywidth, Myheight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark tabBar的设置
-(void)setTabBar{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0/255.0 green:180/255.0 blue:204/255.0 alpha:1]];
    
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
    title.text = _titleViewStr;
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOfTitle.count+3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 230;
    }else if (indexPath.row == arrOfTitle.count+1){
        return 150;
    }else if (indexPath.row == arrOfTitle.count +2){
        return 150;
    }
    return 25;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        UITableViewCell *cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.backgroundColor = [UIColor whiteColor];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, Mywidth-20, 30)];
        [self Customlable:label1 text:@"《七夕之恋》选角" fontSzie:19 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter adjustsFontSizeToFitWidth:NO numberOfLines:1];
        [cell1.contentView addSubview:label1];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, Mywidth-20, 170)];
        imageV.image = [UIImage imageNamed:@"七夕"];
        [cell1.contentView addSubview:imageV];
        return cell1;
        
    }else if (indexPath.row == arrOfTitle.count+1){
        
        UITableViewCell *cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.backgroundColor = [UIColor whiteColor];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, Mywidth-20,20)];
        [self Customlable:label1 text:@"活动介绍:" fontSzie:17 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
        [cell2.contentView addSubview:label1];
        return cell2;
        
    }else if (indexPath.row == arrOfTitle.count+2){
        UITableViewCell *cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        cell3.backgroundColor = [UIColor whiteColor];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, Mywidth-20, 20)];
        [self Customlable:label1 text:@"活动介绍:" fontSzie:17 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
        [cell3.contentView addSubview:label1];
        return cell3;
    }
    

    static NSString *str = @"mycell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
        UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 110, 25)];
        lable1.tag = 1000;
        
        [self  Customlable:lable1 text:nil fontSzie:13 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentRight adjustsFontSizeToFitWidth:NO numberOfLines:1];
        [cell.contentView addSubview:lable1];
        
        UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(120+15, 0, Mywidth-130-15, 25)];
        lable2.tag = 10000;
        [self  Customlable:lable2 text:nil fontSzie:13 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
        [cell.contentView addSubview:lable2];
        
    }
    UILabel *label1 = (UILabel *)[cell.contentView viewWithTag:1000];
     UILabel *label2 = (UILabel *)[cell.contentView viewWithTag:10000];
    if (indexPath.row>0 && indexPath.row<arrOfTitle.count+1) {
        label1.text = arrOfTitle[indexPath.row-1];
        label2.text = arrOfcontent[indexPath.row-1];
    }
   
    return cell;
}

-(void)didGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
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
    // Dispose of any resources that can be recreated.
}



@end
