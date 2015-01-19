//
//  Left_MyAccountViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-29.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "Left_MyAccountViewController.h"
#import "UIImageView+WebCache.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "EditInformationViewController.h"
#import "SecondAccountsViewController.h"
#import "AttestationMessageViewController.h"
#import "MainViewController.h"
#import "RESideMenu.h"
#import "Marcos.h"
#pragma mark - 我的账户
@interface Left_MyAccountViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
    NSArray *arrOfTitle;
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
}
@property (nonatomic,strong)TPKeyboardAvoidingScrollView *tpscrollerView;
@end

@implementation Left_MyAccountViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    [self setTabBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.tpscrollerView =[[TPKeyboardAvoidingScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.tpscrollerView];
    [self CreateHeadView];
    
    arrOfTitle = @[@"手机号码",@"所在地址",@"QQ号码",@"邮箱地址"];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 450/2, Mywidth, Myheight-64-450/2) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:114/255.0 green:190/255.0 blue:222/255.0 alpha:1];
    _tableView.sectionFooterHeight = 0.01;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tpscrollerView addSubview:_tableView];
}

-(void)CreateHeadView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 450/2)];
    headView.backgroundColor = [UIColor colorWithRed:136/255.0 green:185/255.0 blue:163/255.0 alpha:1];
    [_tpscrollerView addSubview:headView];
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.frame = CGRectMake(Mywidth/2-40, 5, 80, 80);
    imageV.backgroundColor = [UIColor clearColor];
    imageV.layer.cornerRadius = imageV.frame.size.width/2;
    imageV.layer.masksToBounds = YES;
    imageV.layer.borderWidth = 3;
    imageV.image = [UIImage imageNamed:@"lc汪峰头像"];
    imageV.layer.borderColor = [UIColor colorWithRed:23/255.0 green:175/255.0 blue:238/255.0 alpha:1].CGColor;
    imageV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    [imageV addGestureRecognizer:tap];
    [headView addSubview:imageV];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageV.frame.size.height+imageV.frame.origin.y+10, Mywidth, 20)];
    [self Customlable:nameLabel text:@"超级无敌美少女" fontSzie:15 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter adjustsFontSizeToFitWidth:NO numberOfLines:1];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    nameLabel.layer.shadowOffset = CGSizeMake(2,7);
    nameLabel.layer.shadowOpacity = 0.5;
    [headView addSubview:nameLabel];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(Mywidth/2-42, nameLabel.frame.size.height+nameLabel.frame.origin.y+20, 84, 19)];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = view.frame.size.height/2;
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    [headView addSubview:view];
    
    UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(8, 3, 13, 13)];
    imageV2.backgroundColor = [UIColor yellowColor];
    [view addSubview:imageV2];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 84-25, 19)];
    [self Customlable:label2 text:@"认证用户" fontSzie:12 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
    [view addSubview:label2];
    
    
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, headView.frame.size.height-55, Mywidth/4, 55);
    btn1.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    btn1.selected = NO;
    btn1.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn1 setTitle:@"二级账户" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headView addSubview:btn1];
    
    btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(Mywidth/4, headView.frame.size.height-55, Mywidth/4, 55);
    btn2.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    btn2.selected = NO;
    btn2.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn2 setTitle:@"认证信息" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headView addSubview:btn2];
    
    btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(Mywidth/2, headView.frame.size.height-55, Mywidth/4, 55);
    btn3.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    btn3.selected = NO;
    btn3.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn3 setTitle:@"我的金币" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headView addSubview:btn3];
    
    btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(Mywidth/4*3, headView.frame.size.height-55, Mywidth/4, 55);
    btn4.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    btn4.selected = NO;
    btn4.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn4 setTitle:@"我的信用" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [headView addSubview:btn4];
    
    [btn1 addTarget:self action:@selector(didMyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(didMyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(didMyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn4 addTarget:self action:@selector(didMyBtn:) forControlEvents:UIControlEventTouchUpInside];

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
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:136/255.0 green:185/255.0 blue:163/255.0 alpha:1]];
    
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
    title.text = @"我的账户";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}
#pragma mark-tableVIew  cell个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
#pragma mark-tableVIew  cell个高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        return 80;
    }
    return 40;
}

#pragma mark-tableVIew  底部高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
#pragma mark-tableVIew cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 4) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(60, 30, Mywidth-120, 35);
        btn.backgroundColor = [UIColor colorWithRed:78/255.0 green:218/255.0 blue:68/255.0 alpha:1];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = btn.frame.size.height/2;
        [btn setTitle:@"编辑资料" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(didEdit) forControlEvents:UIControlEventTouchUpInside];
             [cell.contentView addSubview:btn];
        return cell;
    }
    
    static NSString *str = @"mycellother";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 10,120, 25)];
        [self Customlable:label text:@"" fontSzie:15 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
        label.tag = 112;
        
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, Mywidth-135, 25)];
        
        field.userInteractionEnabled = NO;
        field.textAlignment = NSTextAlignmentRight;
        field.font = [UIFont systemFontOfSize:15];
        field.tag = 113;
        field.textColor = [UIColor whiteColor];
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:field];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 0.5)];
        line.tag = 11111;
        line.backgroundColor = [UIColor colorWithWhite:1 alpha:0.01];
        [cell.contentView addSubview:line];
        
        if (indexPath.row != 0) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 0.5)];
            line.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
            [cell.contentView addSubview:line];
        }
        
    }
    
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:112];
    label.text = arrOfTitle[indexPath.row];
    UITextField *field = (UITextField *)[cell.contentView viewWithTag:113];
    if (indexPath.row == 0) {
        field.text = @"18812341234";
    }else if (indexPath.row == 1) {
        field.text = @"湖南长沙";
    }else if (indexPath.row == 2) {
        field.text = @"123456";
    }else if (indexPath.row == 3) {
        field.text = @"xxxxxx@qq.com";
    }
    return cell;
}
#pragma mark - 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(void)didMyBtn:(UIButton *)sender
{
    
    btn1.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    btn1.selected = NO;
    btn3.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    btn3.selected = NO;
    btn2.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    btn2.selected = NO;
    btn4.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    btn4.selected = NO;
    
    sender.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    sender.selected = YES;
    
    if (btn1.selected) {
        SecondAccountsViewController *sendCtrl = [[SecondAccountsViewController alloc] init];
        [self.navigationController pushViewController:sendCtrl animated:YES];
    }else if (btn2.selected){
        AttestationMessageViewController *attserCtrl = [[AttestationMessageViewController alloc] init];
        [self.navigationController pushViewController:attserCtrl animated:YES];
    }else if (btn3.selected){
        
    }else if (btn4.selected){
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)didTap:(UITapGestureRecognizer *)tap
{
    NSLog(@"%@",tap.view);
}

#pragma mark - 返回上一页
-(void)didGoBack
{
    MainViewController *mainViewController =[MainViewController new];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:mainViewController] animated:YES];
    [self.sideMenuViewController presentLeftMenuViewController];
}

#pragma mark - 编辑资料
-(void)didEdit
{
    EditInformationViewController *editCtrl = [[EditInformationViewController alloc] init];
    [self.navigationController pushViewController:editCtrl animated:YES];
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
