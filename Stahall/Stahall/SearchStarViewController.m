//
//  SearchStarViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-16.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "SearchStarViewController.h"
#import "Marcos.h"
@interface SearchStarViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
    UITextField *_textField;
    NSMutableArray *arrOfTableData;
    UIButton *MyBtn;
}
@end

@implementation SearchStarViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        _tableView.alpha = 0;
    }];
    [_textField resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTaBar];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [view addGestureRecognizer:tap];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 15, Mywidth-40, 35)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.font = [UIFont systemFontOfSize:14];
    _textField.delegate = self;
    _textField.placeholder = @" 请输入关键字查找";
    [self.view addSubview:_textField];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 15+35+20, 200, 20)];
    [self Customlable:lable text:@"搜索条件:" fontSzie:15 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
    [self.view addSubview:lable];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self CustomButton:btn1 frame:CGRectMake(30, lable.frame.size.height+lable.frame.origin.y+15, Mywidth/2-60, 25) title:@"热门" buttonTag:10001 fontSize:13 titleColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor]];
    [btn1 addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self CustomButton:btn2 frame:CGRectMake(30+Mywidth/2, lable.frame.size.height+lable.frame.origin.y+15, Mywidth/2-60, btn1.frame.size.height) title:@"类别" buttonTag:10002 fontSize:13 titleColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor]];
    [btn2 addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self CustomButton:btn3 frame:CGRectMake(30, btn1.frame.size.height+btn1.frame.origin.y+20, Mywidth/2-60, btn1.frame.size.height) title:@"性别" buttonTag:10003 fontSize:13 titleColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor]];
    [btn3 addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self CustomButton:btn4 frame:CGRectMake(30+Mywidth/2, btn1.frame.size.height+btn1.frame.origin.y+20, Mywidth/2-60, btn1.frame.size.height) title:@"地区" buttonTag:10004 fontSize:13 titleColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor]];
    [btn4 addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self CustomButton:btn5 frame:CGRectMake(30, btn3.frame.size.height+btn3.frame.origin.y+20, Mywidth-60, btn1.frame.size.height) title:@"价格区间" buttonTag:10005 fontSize:13 titleColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor]];
    [btn5 addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self CustomButton:btn6 frame:CGRectMake(30, btn5.frame.size.height+btn5.frame.origin.y+20, Mywidth-60, btn1.frame.size.height) title:@"根据类别变动标签" buttonTag:10006 fontSize:13 titleColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor]];
    [btn6 addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn6];
    
    btn1.selected = YES;
    btn2.selected = YES;
    btn3.selected = YES;
    btn4.selected = YES;
    btn5.selected = YES;
    btn6.selected = YES;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    searchBtn.frame = CGRectMake(0, Myheight-45-64,Mywidth, 45);
    [searchBtn setTitle:@"立即搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:204/255.0 alpha:1];
    [searchBtn addTarget:self action:@selector(didImmediatelySearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 10, 10) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.alpha = 0;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.layer.borderColor = [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1].CGColor;
    _tableView.layer.borderWidth = 0.5;
    _tableView.layer.masksToBounds = YES;
    _tableView.layer.cornerRadius = 4;
    [self.view addSubview:_tableView];
    
}
-(void)setTaBar{
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
    title.text = @"艺人搜索";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
}

#pragma mark - tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOfTableData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"mycell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = YES;
        cell.backgroundColor = [UIColor whiteColor];
        UILabel *label  = [[UILabel alloc] init];
        label.tag = 101;
        [self Customlable:label text:@"" fontSzie:13 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter adjustsFontSizeToFitWidth:YES numberOfLines:1];
        [cell.contentView addSubview:label];
    }
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:101];
    label.frame = CGRectMake(0, 0, _tableView.frame.size.width, 25);
    label.text = arrOfTableData[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self didTap];
    [MyBtn setTitle:arrOfTableData[indexPath.row] forState:UIControlStateNormal];
}


#pragma mark - textField的代理
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (MyBtn != nil) {
        MyBtn.selected = YES;
    }
    [UIView animateWithDuration:0.2 animations:^{
        _tableView.alpha = 0;
    }];
}

#pragma mark - 手势
-(void)didTap
{
    
    if (MyBtn != nil) {
        MyBtn.selected = YES;
    }
    [UIView animateWithDuration:0.2 animations:^{
        _tableView.alpha = 0;
    }];
    [_textField resignFirstResponder];
}

#pragma mark - 返回键
-(void)didGoBack{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 点击 立即搜索 时间
-(void)didImmediatelySearch
{
    NSLog(@"立即搜索");
}
#pragma mark - 选择分类按钮
-(void)didBtn:(UIButton *)sender
{
    [_textField resignFirstResponder];
    
    //再没有选择内容时 就点击其他按钮 则把前面那个按钮的选中状态 变成YES
    if (MyBtn != nil && MyBtn.tag != sender.tag) {
        MyBtn.selected = YES;
         _tableView.alpha = 0;
    }

    //取得当前点击的Button
    MyBtn = sender;
    
    
    if (sender.tag == 10001) {
        arrOfTableData = [NSMutableArray arrayWithObjects:@"热门",@"不限",@"中国最强音",@"星光大道",@"春晚",@"中国最强音",@"我是歌手",@"超男快女",@"网络", nil];
    }else if (sender.tag == 10002){
        arrOfTableData = [NSMutableArray arrayWithObjects:@"不限",@"影视",@"主持",@"歌手",@"曲艺",nil];
    }else if (sender.tag == 10003){
        arrOfTableData = [NSMutableArray arrayWithObjects:@"不限",@"男",@"女",@"组合",nil];
    }else if (sender.tag == 10004){
        arrOfTableData = [NSMutableArray arrayWithObjects:@"不限",@"大陆",@"港台",@"新马泰",@"日韩",nil];
    }else if (sender.tag == 10005){
        arrOfTableData = [NSMutableArray arrayWithObjects:@"不限",@"0-10万元",@"10-50万元",@"50-100万元",@"100-300万元",@"300-500万元",@"500万以上",nil];
    }else if (sender.tag == 10006){
        arrOfTableData = [NSMutableArray arrayWithObjects:@"不限",nil];
    }

    CGFloat height = arrOfTableData.count*25;
    if (arrOfTableData.count>5) {
        height = 5*25;
    }
    
    _tableView.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y+sender.frame.size.height,sender.frame.size.width, height);
    
    [UIView animateWithDuration:0.4 animations:^{
        if (sender.selected) {
            _tableView.alpha = 1;
            sender.selected = NO;
        }else{
            _tableView.alpha = 0;
            sender.selected = YES;
        }
    }];
    [_tableView reloadData];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    return YES;
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
#pragma mark - UIButton的方法
-(void)CustomButton:(UIButton *)sender frame:(CGRect)frame title:(NSString *)title buttonTag:(NSInteger)tag fontSize:(CGFloat)font titleColor:(UIColor*)titleColor backgroundColor:(UIColor *)backgroundColor
{
    
    [sender setTitleColor:titleColor forState:UIControlStateNormal];
    [sender setTitle:title forState:UIControlStateNormal];
    sender.frame = frame;
    sender.tag = tag;
    sender.backgroundColor = backgroundColor;
    sender.titleLabel.font = [UIFont systemFontOfSize:font];
    sender.layer.masksToBounds = YES;
    sender.layer.cornerRadius = 4;
    sender.layer.borderWidth = 0.5;
    sender.layer.borderColor = [UIColor colorWithRed:190/255.0 green:190/255. blue:190/255. alpha:1].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
