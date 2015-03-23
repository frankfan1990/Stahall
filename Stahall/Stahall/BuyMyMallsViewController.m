//
//  BuyMyMallsViewController.m
//  Stahall
//
//  Created by JM_Pro on 15/3/23.
//  Copyright (c) 2015年 Rching. All rights reserved.
//

#import "BuyMyMallsViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "Marcos.h"
@interface BuyMyMallsViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
    NSIndexPath *myIndexPath;// 标志indexPath
    NSMutableArray *arrOfSection;
    
    NSMutableArray *arrOfname;
    NSMutableArray *arrOfContent;
    NSMutableArray *arrOfdata;
    
    NSArray *keys;//参数
    UITextField *_textField;
}
@property (nonatomic,strong)TPKeyboardAvoidingScrollView *tpscrollerView;
@end

@implementation BuyMyMallsViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tpscrollerView =[[TPKeyboardAvoidingScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.tpscrollerView];
    
    arrOfname = [NSMutableArray arrayWithObjects:@"演出地点",@"演出时间",@"备选时间",@"直飞机场",@"场馆场馆",@"待定",@"待定",nil];
    arrOfContent = [NSMutableArray arrayWithObjects:@"请选择城市",@"请填写时间",@"请填写时间",@"请填写机场",@"请填写场馆",@"待定",@"待定",nil];
    
    self.view.backgroundColor = [UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionFooterHeight = 0.1;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tpscrollerView addSubview:_tableView];
}
#pragma mark tabBar的设置
-(void)setTabBar{
    
    
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
    
    self.title = @"我要买秀Mall";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - _tableView的代理

#pragma mark - 每一个section好多cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOfContent.count;
}


#pragma mark -  cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(15, 20, Mywidth-30, 38);
    buyBtn.layer.masksToBounds = YES;
    buyBtn.layer.cornerRadius = 5;
    [buyBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    buyBtn.backgroundColor = [UIColor greenColor];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(didSend) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:buyBtn];
    
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
        field.returnKeyType = UIReturnKeyDone;
        field.textAlignment = NSTextAlignmentRight;
        field.font = [UIFont systemFontOfSize:15];
        field.tag = 113;
        [cell1.contentView addSubview:label];
        [cell1.contentView addSubview:field];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 0.5)];
        line.tag = 11111;
        line.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        [cell1.contentView addSubview:line];
        
    }
    
    UIView *line = (UIView *)[cell1.contentView viewWithTag:11111];
    if (indexPath.row == 0) {
        line.hidden = YES;
    }else{
        line.hidden = NO;
    }
    
    UILabel *label = (UILabel *)[cell1.contentView viewWithTag:112];
    
    UITextField *feild = (UITextField *)[cell1.contentView viewWithTag:113];
    feild.textColor = [UIColor whiteColor];
    label.text = arrOfname[indexPath.row];
    feild.attributedPlaceholder = [[NSAttributedString alloc] initWithString:arrOfContent[indexPath.row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //        if (indexPath.row == 0 || indexPath.row == 1) {
    //            feild.userInteractionEnabled = NO;
    //        }else{
    //            feild.userInteractionEnabled = YES;
    //        }
    
    
    return cell1;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}


#pragma mark - textFeild代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - 点击返回
-(void)didGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 点击提交
-(void)didSend
{
    
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

#pragma mark - 根据字长算 高度或宽度
- (CGFloat)caculateTheTextHeight:(NSString *)string andFontSize:(int)fontSize andDistance:(CGFloat)distance{
    
    /*非彻底性封装*/
    CGSize constraint = CGSizeMake(distance, CGFLOAT_MAX);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:string
     attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    return size.height;
}

@end
