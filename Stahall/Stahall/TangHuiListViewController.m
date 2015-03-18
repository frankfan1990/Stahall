//
//  TangHuiListViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-18.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "TangHuiListViewController.h"
#import "TangHuiListTableViewCell.h"
#import "ShowDetailsViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "TravelDetailViewController.h"
#import "Marcos.h"
//#import <objc/runtime.h>
#pragma mark -  堂汇 列表
@interface TangHuiListViewController()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UITableView *_tableViewOther;
    UIButton *categoryBtn;
//    NSArray *arrData;
    
    NSMutableArray *arrOfdataOther;
    NSArray *arrOfTag;
}

@end
@implementation TangHuiListViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBar];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    _tableViewOther.alpha = 0;
    categoryBtn.selected = YES;
}
-(void)viewDidLoad
{
 
    [super viewDidLoad];
    if (_index == 100) {
        arrOfTag = @[@"演唱会  ",@"舞台剧  ",@"企业活动  "];
    }else{
         arrOfTag = @[@"分类一  ",@"分类二  ",@"分类三  "];
    }
    
    arrOfdataOther = [[NSMutableArray alloc] initWithArray:_arrOfdata];
    [self.view setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1]];
    
    //取数据
    [self getData];
    
    [self createHeadView];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 38,Mywidth, Myheight -64 -38) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    _tableView.delegate = self;
    _tableView.tag = 1200;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    
    _tableViewOther = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _tableViewOther.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableViewOther.delegate = self;
    _tableViewOther.dataSource = self;
    _tableViewOther.backgroundColor = [UIColor whiteColor];
    _tableViewOther.alpha = 0;
    _tableViewOther.tag = 2000;
//    [[UIApplication sharedApplication].keyWindow addSubview:_tableViewOther];
    [self.view addSubview:_tableViewOther];
}

-(void)createHeadView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 38)];
    headView.backgroundColor = [UIColor clearColor];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 38/2.0-2.5, 5, 5)];
    label1.backgroundColor = [UIColor blackColor];
    label1.layer.cornerRadius = 2.5;
    label1.layer.masksToBounds = YES;
    [headView addSubview:label1];
    
    UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    allBtn.backgroundColor = [UIColor clearColor];
    allBtn.frame = CGRectMake(20, (38-25)/2.0, 55, 25);
    [allBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [allBtn setTitle:@"全部" forState:UIControlStateNormal];
    [allBtn setTitleColor:UIColorFromRGB(0x6B6B6B) forState:UIControlStateNormal];
    [allBtn addTarget:self action:@selector(didAllBtn) forControlEvents:UIControlEventTouchUpInside];
    [headView  addSubview:allBtn];
    
    categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    categoryBtn.selected = YES;
    categoryBtn.frame = CGRectMake(Mywidth-90-3, (38-25)/2.0, 85, 25);
    categoryBtn.backgroundColor = [UIColor whiteColor];
    categoryBtn.layer.cornerRadius = 3;
    [categoryBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [categoryBtn setTitle:@"选择分类   " forState:UIControlStateNormal];
    [categoryBtn setTitleColor:UIColorFromRGB(0x6B6B6B) forState:UIControlStateNormal];
    [categoryBtn addTarget:self action:@selector(didCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
    [headView  addSubview:categoryBtn];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(85-20, 5, 15, 15)];
    imageV.image = [UIImage imageNamed:@"lc向下灰"];
    [categoryBtn addSubview:imageV];
    [self.view addSubview:headView];
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
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:142/255.0 green:95/255.0 blue:198/255.0 alpha:1]];
    
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
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
}

-(void)getData
{
//    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
//    manger.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/plain"]];
//    //秀mall数据
//    NSDictionary *parameterdic = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"start",@"20",@"limit",@"堂汇",@"query",nil];
//    [manger GET:MALLListIP parameters:parameterdic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        arrData = (NSArray *)responseObject[@"results"];
//        [_tableView reloadData];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"error:%@",error);
//    }];
    
}

#pragma mark - tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1200) {
        return arrOfdataOther.count;
    }
    return arrOfTag.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1200) {
        return 98;
    }
    return 25;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 1200) {
        static NSString *cellStr = @"mycell";
        TangHuiListTableViewCell *cell = (TangHuiListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell == nil) {
            cell = [[TangHuiListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:arrOfdataOther[indexPath.row][@"cover"]] placeholderImage:[UIImage imageNamed:@"LCTEST1"]];
        cell.titleOfLabel.text = arrOfdataOther[indexPath.row][@"travelName"];
        cell.keyOfLabel.text = [NSString stringWithFormat:@"关键词:%@",arrOfdataOther[indexPath.row][@"keyword"]];
        cell.stahallOfLabel.text = [NSString stringWithFormat:@"艺人：%@",arrOfdataOther[indexPath.row][@"artistName"]];
        
        
        return cell;
    }else{
        static NSString *str = @"mycellTwo";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = YES;
            UILabel *label  = [[UILabel alloc] init];
            label.tag = 101;
            [self Customlable:label text:@"" fontSzie:13 textColor:UIColorFromRGB(0x6B6B6B) textAlignment:NSTextAlignmentCenter adjustsFontSizeToFitWidth:YES numberOfLines:1];
            label.frame = CGRectMake(0, 0, _tableViewOther.frame.size.width, 25);
            [cell.contentView addSubview:label];
        }
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:101];
        label.text = arrOfTag[indexPath.row];
         return cell;
    }
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1200) {
        
        TravelDetailViewController *details = [[TravelDetailViewController alloc] init];
        [self.navigationController pushViewController:details animated:YES];
        
    }else{
        [categoryBtn setTitle:arrOfTag[indexPath.row] forState:UIControlStateNormal];
        categoryBtn.selected =  YES;
        [UIView animateWithDuration:0.2 animations:^{
            _tableViewOther.alpha = 0;
        }];
        
        [arrOfdataOther removeAllObjects];
        for (NSDictionary *dd in _arrOfdata) {
            if (indexPath.row == 0) {
                if ([dd[@"typeId"] intValue] == 2) {
                    [arrOfdataOther addObject:dd];
                }
            }else if (indexPath.row == 1){
                if ([dd[@"typeId"] intValue] == 1) {
                    [arrOfdataOther addObject:dd];
                }
            }else{
                if ([dd[@"typeId"] intValue] == 3) {
                    [arrOfdataOther addObject:dd];
                }
            }
        }
        [_tableView reloadData];
    }
    
}

-(void)didAllBtn
{
    
    [UIView animateWithDuration:0.4 animations:^{
            _tableViewOther.alpha = 0;
    }];
    [arrOfdataOther removeAllObjects];
    [categoryBtn setTitle:@"选择分类   " forState:UIControlStateNormal];
    categoryBtn.selected = YES;
    [arrOfdataOther addObjectsFromArray:_arrOfdata];
    [_tableView reloadData];
    NSLog(@"点击全部");
}

-(void)didCategoryBtn:(UIButton *)sender
{
    
    CGFloat height = arrOfTag.count*25;
    if (arrOfTag.count>5) {
        height = 5*25;
    }
    _tableViewOther.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y+sender.frame.size.height, sender.frame.size.width, height);
    
    [UIView animateWithDuration:0.4 animations:^{
        if (sender.selected) {
            _tableViewOther.alpha = 1;
            sender.selected = NO;
        }else{
            _tableViewOther.alpha = 0;
            sender.selected = YES;
        }
    }];
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
@end