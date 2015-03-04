//
//  MyRecommendViewController.m
//  Stahall
//
//  Created by JM_Pro on 15-1-21.
//  Copyright (c) 2015年 Rching. All rights reserved.
//

#import "MyRecommendViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "Email_Phone.h"
#import "Marcos.h"
#import "AFNetworking.h"
#pragma mark - 我推荐
@interface MyRecommendViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
    NSArray *arrOfname;
    NSArray *arrOfKeys;
    NSIndexPath *myIndexPath;

    NSMutableDictionary *datadic1;
    UITextField *_textField;
}
@property (nonatomic,strong)TPKeyboardAvoidingScrollView *tpscrollerView;
@end

@implementation MyRecommendViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    datadic1 = [NSMutableDictionary dictionary];
    arrOfname = [NSArray arrayWithObjects:@"名称1",@"名称2",@"名称3", @"时间",@"手机号码", nil];
    arrOfKeys = @[@"Name1",@"Name2",@"Name3",@"Time",@"phoneNumber"];
    self.tpscrollerView =[[TPKeyboardAvoidingScrollView alloc]initWithFrame:self.view.bounds];
    _tpscrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tpscrollerView];
    self.view.backgroundColor = [UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.sectionFooterHeight = 0.1;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tpscrollerView addSubview:_tableView];
    
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
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:114/255.0 green:190/255.0 blue:222/255.0 alpha:1]];
    
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
    title.text = @"我推荐";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}

#pragma mark - _tableView的代理

#pragma mark - 每一个section好多cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOfname.count;
}

#pragma mark -  头部的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
    
}
#pragma mark -  cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section >0){
        return 145;
    } else{
        return 45;
    }
    
}

#pragma mark -  头headView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 20)];
    headView.backgroundColor = [UIColor clearColor];
    return headView;
}

#pragma mark -  footView
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 100)];
    footView.backgroundColor = [UIColor clearColor];
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    nextBtn.frame = CGRectMake(60, 25, Mywidth-120, 40);
    nextBtn.backgroundColor = [UIColor colorWithRed:78/255.0 green:218/255.0 blue:68/255.0 alpha:1];
    
    nextBtn.layer.masksToBounds = YES;
    nextBtn.layer.cornerRadius = 20;
    [nextBtn setTitle:@"我推荐" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextBtn addTarget:self action:@selector(didNextBtn) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:nextBtn];
        
    return footView;
}

#pragma mark -  cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell1";
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell1 == nil) {
        cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 10,120, 25)];
        [self Customlable:label text:@"" fontSzie:15 textColor:[UIColor colorWithRed:22/255.0 green:89/255.0 blue:134/255.0 alpha:1] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
        label.tag = 112;
        
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, Mywidth-135, 25)];
        field.userInteractionEnabled = YES;
        field.delegate = self;
        field.textColor = [UIColor whiteColor];
        field.textAlignment = NSTextAlignmentRight;
        field.font = [UIFont systemFontOfSize:15];
        field.returnKeyType = UIReturnKeyDone;
        field.tag = 113;
        [cell1.contentView addSubview:label];
        [cell1.contentView addSubview:field];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 0.5)];
        line.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        line.tag = 114;
        [cell1.contentView addSubview:line];
        
    }
    
    UIView *line = (UIView *)[cell1.contentView viewWithTag:114];
    if (indexPath.row == 0) {
        line.hidden = YES;
    }else{
        line.hidden = NO;
    }
    
    UILabel *label = (UILabel *)[cell1.contentView viewWithTag:112];
    UITextField *feild = (UITextField *)[cell1.contentView viewWithTag:113];
    feild.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"请输入%@",arrOfname[indexPath.row]] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    label.text = arrOfname[indexPath.row];
    feild.text = datadic1[arrOfKeys[indexPath.row]];
    return cell1;
}

#pragma mark - textField代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - textField代理
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _textField = textField;
    CGPoint position = [textField convertPoint:CGPointZero toView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:position];
    myIndexPath = indexPath;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (myIndexPath.section == 0) {
        [datadic1 setObject:textField.text forKey:arrOfKeys[myIndexPath.row]];
    }
    
}

#pragma mark - 点击申请认证
-(void)didNextBtn
{
    [_textField resignFirstResponder];
    NSString * msg;
    for (int i = 0; i< arrOfKeys.count; i++) {
        
        if (![datadic1[arrOfKeys[i]] length]) {
            msg = [NSString stringWithFormat:@"\n请输入%@",arrOfname[i]];
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            break;
        }
        
    }
    
    if ([msg length]) {
        return;
    }
    if (!isValidatePhone(datadic1[arrOfKeys[4]])){
        msg = @"\n请输入正确的手机号";
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSLog(@"%@",datadic1);
    
}


#pragma mark - 点击返回上一页
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
