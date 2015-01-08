//
//  MyShowDetailsViewController.m
//  Stahall
//
//  Created by JM_Pro on 15-1-8.
//  Copyright (c) 2015年 Rching. All rights reserved.
//

#import "MyShowDetailsViewController.h"
#import "Marcos.h"
@interface MyShowDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableView;
    NSMutableArray *arrOfTitle;
    
}
@end

@implementation MyShowDetailsViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1];
    
    [arrOfTitle addObject:@"演出名称"];
    [arrOfTitle addObject:@"主办/承办单位"];
    [arrOfTitle addObjectsFromArray:@[@"演出开始时间",@"演出结束时间",@"演出地点",@"演出场地",@"场馆名称"]];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.backgroundColor = [UIColor clearColor];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return arrOfTitle.count;
    }else{
        return 2;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 45;
    }else{
        return 120;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 20)];
    backView.backgroundColor = [UIColor clearColor];
    
    return backView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *str = @"mycell1";
        UITableViewCell *cell1 = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:str];
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            cell1.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10,120, 25)];
            [self Customlable:label text:@"" fontSzie:15 textColor:[UIColor colorWithRed:22/255.0 green:89/255.0 blue:134/255.0 alpha:1] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
            label.tag = 112;
            
            UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, Mywidth-155, 25)];
            field.textAlignment = NSTextAlignmentRight;
            field.font = [UIFont systemFontOfSize:15];
            field.tag = 113;
            field.userInteractionEnabled = NO;
            field.textColor = [UIColor whiteColor];
            [cell1.contentView addSubview:label];
            [cell1.contentView addSubview:field];
        }
        UILabel *label = (UILabel *)[cell1.contentView viewWithTag:112];
        label.text = arrOfTitle[indexPath.row];
        UITextField *feild = (UITextField *)[cell1.contentView viewWithTag:113];
        feild.text = @"111111";
        return cell1;
    }else{
        if (indexPath.row == 0) {
            UITableViewCell *cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell2.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
            return cell2;
        }else{
            UITableViewCell *cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell3.backgroundColor = [UIColor clearColor];
            UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn1.frame = CGRectMake(60, 15, Mywidth-120, 35);
            btn1.backgroundColor = [UIColor greenColor];
            btn1.layer.masksToBounds = YES;
            btn1.layer.cornerRadius = btn1.frame.size.height/2;
            btn1.titleLabel.text = @"发送邀约函";
            btn1.titleLabel.font = [UIFont systemFontOfSize:16];
            btn1.titleLabel.textColor = [UIColor whiteColor];
            [cell3.contentView addSubview:btn1];
            return cell3;
        }
    }
    
}
-(void)didGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
