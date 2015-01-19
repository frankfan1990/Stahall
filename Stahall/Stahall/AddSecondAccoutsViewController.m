//
//  AddSecondAccoutsViewController.m
//  Stahall
//
//  Created by JM_Pro on 15-1-13.
//  Copyright (c) 2015年 Rching. All rights reserved.
//

#import "AddSecondAccoutsViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "SecondAccountsViewController.h"
#import "AFNetworking.h"
#import "ProgressHUD.h"
#import "Email_Phone.h"
#import "Marcos.h"
#pragma mark - 增加二级账户
@interface AddSecondAccoutsViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
    NSArray *arrOfTitle;
    UITextField *_textField;
    NSIndexPath *myIndexPath;
    NSMutableDictionary *dataDict;
    NSArray *arrOfContent;
    NSString *passWordStr;
}
@property (nonatomic,strong)TPKeyboardAvoidingScrollView *tpscrollerView;
@end

@implementation AddSecondAccoutsViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [ProgressHUD dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    dataDict = [NSMutableDictionary dictionary];
    arrOfTitle = @[@"姓名",@"公司所在职位",@"手机号码",@"用户密码",@"确认密码"];
    arrOfContent = @[@"输入姓名",@"输入职位名称",@"请输入手机号码",@"输入用户密码",@"确认密码"];

    self.view.backgroundColor = [UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.tpscrollerView =[[TPKeyboardAvoidingScrollView alloc]initWithFrame:self.view.bounds];
    self.tpscrollerView.backgroundColor = [UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1];
    [self.view addSubview:self.tpscrollerView];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight-64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1];
    _tableView.sectionFooterHeight = 0.01;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tpscrollerView addSubview:_tableView];
}
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
    [btnLeft setFrame:CGRectMake(0, 0, 35, 35)];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateHighlighted];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(didGoBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    UIButton*  btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"完成" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 10, 40, 45)];;
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(didFinish) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnright = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -5;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        self.navigationItem.rightBarButtonItems= @[negativeSpacer, btnright];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
        self.navigationItem.rightBarButtonItem = btnright;
    }
    
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    title.text = @"增加二级账号";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
}

#pragma mark-tableVIew  cell个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOfTitle.count;
}
#pragma mark-tableVIew  cell个高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
        
        field.userInteractionEnabled = YES;
        field.delegate = self;
        field.returnKeyType = UIReturnKeyDone;
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
    UITextField *feild = (UITextField *)[cell.contentView viewWithTag:113];
  
    feild.attributedPlaceholder = [[NSAttributedString alloc] initWithString:arrOfContent[indexPath.row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
   
    return cell;
}
#pragma mark - 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - textField代理
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _textField = textField;
    CGPoint position = [textField convertPoint:CGPointZero toView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:position];
    myIndexPath = indexPath;
    if (myIndexPath.row >2) {
        textField.secureTextEntry = YES;
    }else if(myIndexPath.row == 2){
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (myIndexPath.row == 0) {
        [dataDict setObject:textField.text forKey:@"nickName"];
    }else if (myIndexPath.row == 1){
        [dataDict setObject:textField.text forKey:@"position"];
    }else if (myIndexPath.row == 2){
        [dataDict setObject:textField.text forKey:@"telphone"];
    }else if (myIndexPath.row == 3){
        [dataDict setObject:textField.text forKey:@"passWord"];
    }else if (myIndexPath.row == 4){
        [dataDict setObject:textField.text forKey:@"passWord_two"];
        passWordStr = textField.text;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - 返回上一页
-(void)didGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 点击完成
-(void)didFinish
{
    [_textField resignFirstResponder];
    
    NSLog(@"%@",self.navigationController.viewControllers);
    
    NSString *msg = @"";
    if (![dataDict[@"nickName"] length]) {
        msg = @"\n请填写姓名";
    }else if(![dataDict[@"position"] length]){
        msg = @"\n请填写职位名称";
    }else if(![dataDict[@"telphone"] length]){
        msg = @"\n请填写手机号码";
    }else if(![dataDict[@"passWord"] length]){
        msg = @"\n请填写密码";
    }else if (![dataDict[@"passWord_two"] length]){
        msg = @"\n请确认密码";
    } else if (!isValidatePhone(dataDict[@"telphone"])){
        msg = @"\n请填写正确的手机号码";
    }else if(![dataDict[@"passWord"] isEqualToString:dataDict[@"passWord_two"]]){
        msg = @"\n两次密码不一致";
    }else if ([dataDict[@"passWord"] length] < 6){
        msg = @"\n密码长度必须大于六位";
    }
    
    if ([msg length]) {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alerView show];
        return;
    }else{
        
        [ProgressHUD show:@"正在添加"];
        //一级账户的id
        [dataDict setObject:@"78955a4c-6b00-4999-96eb-1b2334b4f7b5" forKey:@"parentId"];
        
        [dataDict removeObjectForKey:@"passWord_two"];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //如果报接受类型不一致请替换一致text/html或别的
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
        __weak typeof (self)mySelf = self;
        [manager POST:AddSecondIP parameters:dataDict success:^(AFHTTPRequestOperation *operation, id responseObject) {

            if ([responseObject[@"success"] intValue] == 0) {
                [ProgressHUD dismiss];
                UIAlertView *aler=[[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"\n%@",responseObject[@"data"]] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
                [aler show];
                [dataDict setObject:passWordStr forKey:@"passWord_two"];
            }else{
                [ProgressHUD showSuccess:@"添加成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [mySelf.navigationController.viewControllers[1] getData];
                    [mySelf.navigationController popViewControllerAnimated:YES];
                });
               
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [ProgressHUD dismiss];
            UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"添加失败" message:@"\n请检查网络设置" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [aler show];
            [dataDict setObject:passWordStr forKey:@"passWord_two"];
            NSLog(@"%@",error);
        }];

    }
    
    
    
    
    NSLog(@"%@",dataDict);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
