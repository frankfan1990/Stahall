//
//  ShowMallDetailsViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-29.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "ShowMallDetailsViewController.h"
#import "UIImageView+WebCache.h"
#import "Marcos.h"
@interface ShowMallDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *arrOfTitle;
    NSMutableArray *arrOfcontent;
}

@end

@implementation ShowMallDetailsViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1]];
    arrOfTitle = @[@"活动名称:",@"时       间:",@"地       点:",@"场       馆:",@"出场艺人:",@"主办单位:",@"活动介绍",@"艺人简介"];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
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
    title.text = @"XXX演唱会";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOfTitle.count +1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 160;
    }else if (indexPath.row > arrOfTitle.count-2){
        return 170;
    }else{
        return 50;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell0 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 160)];
        [imageV  sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"七夕"]];
        [cell0.contentView addSubview:imageV];
        return cell0;
    }else if (indexPath.row > arrOfTitle.count-2){
        
        static NSString *str = @"mycell1";
        UITableViewCell *cell1 = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:str];
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            cell1.backgroundColor = [UIColor clearColor];
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 15, 15)];
            imageV.backgroundColor = [UIColor whiteColor];
            
            UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(23+7, 8, 200, 15)];
            [self Customlable:labelTitle text:nil fontSzie:13 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
            labelTitle.backgroundColor = [UIColor clearColor];
            labelTitle.tag = 10001;
            
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(8, 28, Mywidth-16, 170-35)];
            webView.backgroundColor = [UIColor clearColor];
            webView.opaque = NO;
            webView.tag = 10002;
            
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 170)];
            if (indexPath.row%2) {
                 bgView.backgroundColor = [UIColor clearColor];
            }else{
                bgView.backgroundColor = [UIColor blackColor];
                bgView.alpha = 0.03;
               
            }
            [cell1.contentView addSubview:bgView];
            [cell1.contentView addSubview:webView];
            [cell1.contentView addSubview:labelTitle];
            [cell1.contentView addSubview:imageV];

        }
        UILabel *label = (UILabel *)[cell1.contentView viewWithTag:10001];
        label.text = arrOfTitle[indexPath.row-1];
       
        
        return cell1;
    }else{
        static NSString *cellStr = @"mycell2";
        UITableViewCell *cell2 = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell2 == nil) {
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            cell2.backgroundColor = [UIColor clearColor];
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25-2.5, 5, 5)];
            imageV.layer.masksToBounds = YES;
            imageV.layer.cornerRadius = imageV.frame.size.width/2;
            imageV.backgroundColor = [UIColor greenColor];
            
            UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(23+7, 8, 200, 15)];
            [self Customlable:labelTitle text:nil fontSzie:14 textColor:[UIColor yellowColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
            labelTitle.backgroundColor = [UIColor clearColor];
            labelTitle.tag = 10003;
            
            UILabel *labelContent = [[UILabel alloc] initWithFrame:CGRectMake(labelTitle.frame.origin.x, 25, Mywidth-40, 20)];
            [self Customlable:labelContent text:@"" fontSzie:12 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
            labelContent.tag = 10004;
            
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 50)];
            if (indexPath.row%2) {
                bgView.backgroundColor = [UIColor clearColor];
            }else{
                bgView.backgroundColor = [UIColor blackColor];
                bgView.alpha = 0.03;
                
            }
            [cell2.contentView addSubview:bgView];
            [cell2.contentView addSubview:labelContent];
            [cell2.contentView addSubview:imageV];
            [cell2.contentView addSubview:labelTitle];
            
            
        }
        UILabel *label = (UILabel *)[cell2.contentView viewWithTag:10003];
        label.text = arrOfTitle[indexPath.row-1];
        UILabel *label2 = (UILabel *)[cell2.contentView viewWithTag:10004];
        label2.text = @"长沙贺龙体育馆";
        return cell2;
        
    }
    
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

-(void)didGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
