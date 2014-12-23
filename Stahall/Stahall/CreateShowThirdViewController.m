//
//  CreateShowThirdViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-23.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "CreateShowThirdViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "Marcos.h"
@interface CreateShowThirdViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
{
    UITableView *_tableView;
    UIActionSheet *sheetView;
    NSArray *arrOfrule;
    NSMutableArray *arrOfname;
    NSMutableArray *arrOfContent;
    
}
@property (nonatomic,strong)TPKeyboardAvoidingScrollView *tpscrollerView;
@end

@implementation CreateShowThirdViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arrOfrule = @[@"艺人到达演出会场如发现演出名称与实际不符，有权拒绝演出",@"艺人到达演出会场如发现演出名称与实际不符，有权拒绝演出艺人到达演出会场如发现演出名称与实际不符，有权拒绝演出"];
    arrOfname = [NSMutableArray arrayWithObjects:@"申请人",@"所在公司", nil];
    arrOfContent = [NSMutableArray arrayWithObjects:@"小龙包",@"神雕侠包剧组",nil];
    
    self.tpscrollerView =[[TPKeyboardAvoidingScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.tpscrollerView];
    self.view.backgroundColor = [UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tpscrollerView addSubview:_tableView];
    
    sheetView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    

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
    title.text = @"商业演出";
    
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}


#pragma mark - _tableView的代理
#pragma mark - 好多section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
#pragma mark - 每一个section好多cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return arrOfrule.count;
    }else if (section == 1){
        return 1;
    }else {
        return arrOfname.count;
    }
}

#pragma mark -  头部的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 80-5;
    }else if (section == 1){
        return 20;
    } else{
        return 25;
    }
    
}

#pragma mark -  cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 20+[self caculateTheTextHeight:arrOfrule[indexPath.row] andFontSize:14 andDistance:Mywidth-65];
    }else if (indexPath.section ==1){
        return 150;
    } else{
        return 45;
    }
    
}

#pragma mark -  头部
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 2) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 20)];
        headView.backgroundColor = [UIColor clearColor];
        return headView;
    }else{
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 80-5)];
        headView.backgroundColor = [UIColor clearColor];
        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        nextBtn.frame = CGRectMake(60, 10, Mywidth-120, 40);
        nextBtn.backgroundColor = [UIColor colorWithRed:78/255.0 green:218/255.0 blue:68/255.0 alpha:1];
        nextBtn.layer.masksToBounds = YES;
        nextBtn.layer.cornerRadius = 20;
        [nextBtn setTitle:@"申请创建演出" forState:UIControlStateNormal];
        [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [nextBtn addTarget:self action:@selector(didNextBtn) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:nextBtn];
        return headView;
    }
}

#pragma mark -  cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 1){
        
        UITableViewCell *cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 0, Mywidth-10, 30);
        [self Customlable:label text:@"授权书/委托函" fontSzie:16 textColor:[UIColor colorWithRed:22/255.0 green:89/255.0 blue:134/255.0 alpha:1] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
        [cell2.contentView addSubview:label];
        
        return cell2;
    }
    else if(indexPath.section == 2){
        static NSString * cellName = @"cell3";
        UITableViewCell *cell3 = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell3 == nil) {
            cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            cell3.selectionStyle = UITableViewCellSelectionStyleNone;
            cell3.backgroundColor = [UIColor clearColor];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, Mywidth-65, [self caculateTheTextHeight:arrOfrule[indexPath.row] andFontSize:14 andDistance:Mywidth-65])];
            label.tag = 1114;
            [self Customlable:label text:@"" fontSzie:14 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:100];
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(22, label.frame.origin.y+6, 10, 10)];
            view.backgroundColor = [UIColor whiteColor];
            view.alpha = 0.9;
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = view.frame.size.width/2;
            [cell3.contentView addSubview:view];
            [cell3.contentView addSubview:label];
        }
        UILabel *label = (UILabel *)[cell3.contentView viewWithTag:1114];
        label.text = arrOfrule[indexPath.row];
        return cell3;
    }
    else{
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
            field.userInteractionEnabled = NO;
            field.textColor = [UIColor whiteColor];
            field.textAlignment = NSTextAlignmentRight;
            field.font = [UIFont systemFontOfSize:15];
            field.tag = 113;
            [cell1.contentView addSubview:label];
            [cell1.contentView addSubview:field];
            
            if (indexPath.row != 0) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 0.5)];
                line.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
                [cell1.contentView addSubview:line];
            }
        }
        
        
        UILabel *label = (UILabel *)[cell1.contentView viewWithTag:112];
        UITextField *feild = (UITextField *)[cell1.contentView viewWithTag:113];
        feild.text = arrOfContent[indexPath.row];
        label.text = arrOfname[indexPath.row];
        return cell1;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [sheetView showInView:self.view];
}


#pragma mark - sheetView的代理
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}
#pragma mark - 返回
-(void)didGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 创建
-(void)didNextBtn
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
