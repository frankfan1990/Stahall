//
//  CreateNewShowViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-22.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "CreateShowFirstViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "CreateShowSecondViewController.h"
#import "Marcos.h"
@interface CreateShowFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *arrOfname;
    NSMutableArray *arrOfContent;
    NSArray *arrOfrule;
    NSArray *arrOfSegmentTitle;
    
    
    NSMutableDictionary *dictOfdata;
    
    
}
@property (nonatomic,strong)TPKeyboardAvoidingScrollView *tpscrollerView;
@end

@implementation CreateShowFirstViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
     [self setTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrOfname = [NSMutableArray arrayWithObjects:@"演出名称",@"主办/承办单位", nil];
    arrOfContent = [NSMutableArray arrayWithObjects:@"请输入演出名称",@"请输入主办/承办单位",nil];
    arrOfSegmentTitle = @[@"商业演出",@"公益演出"];
    
    arrOfrule = @[@"艺人到达演出会场如发现演出名称与实际不符，有权拒绝演出",@"艺人到达演出会场如发现演出名称与实际不符，有权拒绝演出艺人到达演出会场如发现演出名称与实际不符，有权拒绝演出"];
    dictOfdata = [NSMutableDictionary dictionary];

    self.tpscrollerView =[[TPKeyboardAvoidingScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.tpscrollerView];
    self.view.backgroundColor = [UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
     _tableView.sectionFooterHeight = 0.1;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tpscrollerView addSubview:_tableView];
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
    title.text = @"新建演出";
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
    if (section == 0) {
       return arrOfContent.count;
    }else if(section == 1){
        return 1;
    }else {
        return arrOfrule.count;
    }
}

#pragma mark -  头部的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 70+25;
    }else if (section == 2){
        return 80;
    }
    return 30;
}

#pragma mark -  cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0  || indexPath.section == 1) {
        return 45;
    }else{
        return 20+[self caculateTheTextHeight:arrOfrule[indexPath.row] andFontSize:14 andDistance:Mywidth-65];
    }
    
}

#pragma mark -  头部
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 90)];
        headView.backgroundColor = [UIColor clearColor];
       UILabel * segmentCtrl = [[UILabel alloc] initWithFrame:CGRectMake(0,25,Mywidth ,45)];
        segmentCtrl.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        [self Customlable:segmentCtrl text:@"     商业演出" fontSzie:16 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
        [headView addSubview:segmentCtrl];
        return headView;
    }
    else if (section == 1){
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 20)];
        headView.backgroundColor = [UIColor clearColor];
        return headView;
    }
    else{
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 80)];
        headView.backgroundColor = [UIColor clearColor];
        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        nextBtn.frame = CGRectMake(60, 27, Mywidth-120, 40);
        nextBtn.backgroundColor = [UIColor colorWithRed:78/255.0 green:218/255.0 blue:68/255.0 alpha:1];
        nextBtn.layer.masksToBounds = YES;
        nextBtn.layer.cornerRadius = 20;
        [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
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
    if (indexPath.section == 0) {
        static NSString *str = @"cell1";
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            cell1.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10,120, 25)];
            [self Customlable:label text:@"" fontSzie:15 textColor:[UIColor colorWithRed:22/255.0 green:89/255.0 blue:134/255.0 alpha:1] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
            label.tag = 112;
            
            UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, Mywidth-155, 25)];
            field.textAlignment = NSTextAlignmentRight;
            field.font = [UIFont systemFontOfSize:15];
            field.tag = 113;
            [cell1.contentView addSubview:label];
            [cell1.contentView addSubview:field];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(Mywidth-30, 10, 25, 25);
            [btn setBackgroundImage:[UIImage imageNamed:@"lc取消"] forState:UIControlStateNormal];
            btn.tag = 120;
            [btn addTarget:self action:@selector(didCancel:) forControlEvents:UIControlEventTouchUpInside];
            btn.hidden = YES;
            [cell1.contentView addSubview:btn];
            
            if (indexPath.row != 0) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 0.5)];
                line.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
                [cell1.contentView addSubview:line];
            }
            
        }
        
        UILabel *label = (UILabel *)[cell1.contentView viewWithTag:112];
        UITextField *feild = (UITextField *)[cell1.contentView viewWithTag:113];
        label.text = arrOfname[indexPath.row];
        feild.attributedPlaceholder = [[NSAttributedString alloc] initWithString:arrOfContent[indexPath.row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        feild.textColor = [UIColor whiteColor];
        UIButton *btn = (UIButton *)[cell1.contentView viewWithTag:120];
        if (indexPath.row >1) {
            btn.hidden = NO;
        }else{
            btn.hidden = YES;
        }
        return cell1;
    }
    else if (indexPath.section == 1){
        
        UITableViewCell *cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        UILabel *label = [[UILabel alloc] init];
        label.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.3].CGColor;
        label.layer.borderWidth = 0.5;
        label.frame = CGRectMake(-1, 0, Mywidth+2, 45);
        [self Customlable:label text:@"增加主办单位" fontSzie:16 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter adjustsFontSizeToFitWidth:NO numberOfLines:1];
        [cell2.contentView addSubview:label];
        
        return cell2;
    }
    else{
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
            
            [cell3 addSubview:view];
            [cell3.contentView addSubview:label];
        }
        UILabel *label = (UILabel *)[cell3.contentView viewWithTag:1114];
        label.text = arrOfrule[indexPath.row];
        return cell3;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (arrOfname.count > 5) {
            UIAlertView *alerView= [[UIAlertView alloc] initWithTitle:nil message:@"\n最多只能添加五个单位" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alerView show];
            return;
        }
        [arrOfname addObject:@"主办/承办单位"];
        [arrOfContent addObject:@"请输入主办/承办单位"];
        NSIndexPath *index = [NSIndexPath indexPathForRow:arrOfname.count-1 inSection:0];
        [_tableView beginUpdates];
        [_tableView insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationRight];
        [_tableView endUpdates];
        
    }
}


#pragma mark - 取消
-(void)didCancel:(UIButton *)sender
{
    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath *index = [_tableView indexPathForCell:cell];
    [arrOfname removeObjectAtIndex:index.row];
    [arrOfContent removeObjectAtIndex:index.row];
    [_tableView beginUpdates];
    [_tableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationLeft];
    [_tableView endUpdates];
    
}

#pragma mark - 下一步
-(void)didNextBtn
{
    NSString * dataStr = [NSString string];
    [dictOfdata removeAllObjects];
    for (int i=0; i<arrOfname.count; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cell = (UITableViewCell *)[_tableView cellForRowAtIndexPath:index];
        UITextField *field = (UITextField *)[cell.contentView viewWithTag:113];
        if (![field.text length]) {
            NSString *msg = @"";
            if (index.row == 0) {
                msg = @"\n演出名称不能为空";
            }else{
                msg = @"\n主办/承办单位不能为空";
            }
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        else{
            if (index.row == 0) {
                [dictOfdata setObject:field.text forKey:@"showName"];
            }else{
//                NSString *key = [NSString stringWithFormat:@"company_%ld",index.row];
                if ([dataStr length]) {
                    dataStr = [NSString stringWithFormat:@"%@,%@",dataStr,field.text];
                }else{
                    dataStr = field.text;
                }
        
            }
            
        }
        
    }
    
    [dictOfdata setObject:dataStr forKey:@"organizer"];     //演出商
    [dictOfdata setObject:@"商业演出" forKey:@"showType"];   //演出类型
    CreateShowSecondViewController *secondCtrl = [[CreateShowSecondViewController alloc] init];
    secondCtrl.dictOfData = dictOfdata;
    [self.navigationController pushViewController:secondCtrl animated:YES];
}

#pragma mark - 返回上一页
-(void)didGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
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
