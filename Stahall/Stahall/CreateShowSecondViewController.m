//
//  CreateShowSecondViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-22.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "CreateShowSecondViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "RZTimeSelectedViewController.h"
#import "CreateShowThirdViewController.h"
#import "AFNetworking.h"
#import "Marcos.h"
@interface CreateShowSecondViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
    NSIndexPath *myIndexPath;// 标志indexPath
    NSMutableArray *arrOfSection;
    NSArray *arrOfrule;
    
    NSMutableArray *arrOfname;
    NSMutableArray *arrOfContent;
    NSMutableArray *arrOfdata;

    NSArray *keys;
    UITextField *_textField;
}

@property (nonatomic,strong)TPKeyboardAvoidingScrollView *tpscrollerView;
@end

@implementation CreateShowSecondViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_textField resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrOfSection = [NSMutableArray arrayWithObjects:@"1",nil];
    arrOfrule = @[@"艺人到达演出会场如发现演出名称与实际不符，有权拒绝演出",@"艺人到达演出会场如发现演出名称与实际不符，有权拒绝演出艺人到达演出会场如发现演出名称与实际不符，有权拒绝演出"];
    arrOfname = [NSMutableArray arrayWithObjects:@"演出开始时间",@"演出结束时间",@"演出地点",@"演出场地",@"场馆名称", nil];
    arrOfContent = [NSMutableArray arrayWithObjects:@"点击设置开始时间",@"点击设置结束时间",@"请输入演出地点",@"请输入演出场地",@"请输入场馆名称",nil];
    keys = @[@"startTime",@"endTime",@"address",@"space",@"venues"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"" forKey:keys[0]];
    [dic setObject:@"" forKey:keys[1]];
    [dic setObject:@"" forKey:keys[2]];
    [dic setObject:@"" forKey:keys[3]];
    [dic setObject:@"" forKey:keys[4]];
    
    arrOfdata = [NSMutableArray array];
    [arrOfdata addObject:dic];
 
    
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
    title.text = @"商业演出";
    
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}


#pragma mark - _tableView的代理
#pragma mark - 好多section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrOfSection.count+2;
}
#pragma mark - 每一个section好多cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == arrOfSection.count+1) {
        return arrOfrule.count;
    }else if (section == arrOfSection.count){
        return 1;
    }else {
        return 5;
    }
}

#pragma mark -  头部的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == arrOfSection.count+1) {
        return 90;
    }else if (section == arrOfSection.count){
       return 30;
    }else{
        return 45;
    }
    
}

#pragma mark -  cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == arrOfSection.count+1) {
         return 20+[self caculateTheTextHeight:arrOfrule[indexPath.row] andFontSize:14 andDistance:Mywidth-65];
    }else{
        return 45;
    }
    
}

#pragma mark -  头部
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != arrOfSection.count+1) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 90)];
        headView.backgroundColor = [UIColor clearColor];
        if (section != arrOfSection.count) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, 25, 25)];
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = label.frame.size.width/2;
            label.textColor = [UIColor whiteColor];
            label.text = [NSString stringWithFormat:@"%ld",section+1];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
            [headView addSubview:label];
            
            if (section != 0) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(Mywidth-33, 10, 25, 25);
                [btn setBackgroundImage:[UIImage imageNamed:@"lc取消"] forState:UIControlStateNormal];
                btn.tag = 100000+section;
                [btn addTarget:self action:@selector(didCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
                [headView addSubview:btn];
            }
        }
   
        return headView;
    }else{
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
    
  
    if (indexPath.section == arrOfSection.count){
        
        UITableViewCell *cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        UILabel *label = [[UILabel alloc] init];
        label.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.3].CGColor;
        label.layer.borderWidth = 0.5;
        label.frame = CGRectMake(-1, 0, Mywidth+2, 45);
        [self Customlable:label text:@"增加场次" fontSzie:16 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter adjustsFontSizeToFitWidth:NO numberOfLines:1];
        [cell2.contentView addSubview:label];
        return cell2; 
    }
    else if(indexPath.section == arrOfSection.count+1){
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
        feild.text = [arrOfdata[indexPath.section] objectForKey:keys[indexPath.row]];
        feild.attributedPlaceholder = [[NSAttributedString alloc] initWithString:arrOfContent[indexPath.row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        if (indexPath.row == 0 || indexPath.row == 1) {
            feild.userInteractionEnabled = NO;
        }else{
            feild.userInteractionEnabled = YES;
        }
        
        
        return cell1;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_textField resignFirstResponder];
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == arrOfSection.count) {

        for (NSMutableDictionary *dict in arrOfdata) {
            for (NSString *key in keys) {
                if (![[dict objectForKey:key] length]) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"\n完善其他场次信息 才能增加另外的场次" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                    [alertView show];
                    return;
                };
            }
        }
        
        [arrOfSection addObject:@""];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"" forKey:keys[0]];
        [dic setObject:@"" forKey:keys[1]];
        [dic setObject:@"" forKey:keys[2]];
        [dic setObject:@"" forKey:keys[3]];
        [dic setObject:@"" forKey:keys[4]];
        [arrOfdata addObject:dic];
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(arrOfSection.count-1,1)];//第一个参数是插入到第几section  第二参数 加几个section
        [_tableView beginUpdates];
        [_tableView insertSections:set withRowAnimation:UITableViewRowAnimationRight];
        [_tableView endUpdates];
        [_tableView setContentOffset:CGPointMake(0, (arrOfSection.count-1)*270) animated:YES];
        
    }
    else if (indexPath.section < arrOfSection.count && indexPath.row<2){
        
        _field1 = (UITextField *)[cell.contentView viewWithTag:113];
        RZTimeSelectedViewController *timeCtrl = [[RZTimeSelectedViewController alloc] init];
        if ([_field1.text length]) {
            
            NSString *date;
            NSString *time;
            if ([_field1.text length] == 16) {
                date = [_field1.text substringToIndex: 10];
                time = [_field1.text substringFromIndex:11];
            }
            [timeCtrl getDate:date Time:time];
        }
        myIndexPath = indexPath;
        [self.navigationController pushViewController:timeCtrl animated:YES];
    }
}

#pragma mark - textfield的代理
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    _textField = textField;
//    myIndexPath = [_tableView indexPathForCell:(UITableViewCell *)[[textField superview] superview]];
    //这里可能不兼容其他系统
    
    CGPoint position = [textField convertPoint:CGPointZero toView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:position];
    myIndexPath = indexPath;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [arrOfdata[myIndexPath.section] setObject:textField.text forKey:keys[myIndexPath.row]];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)didCancelBtn:(UIButton *) sender{
    
    [arrOfSection removeLastObject];
    [arrOfdata removeObjectAtIndex:sender.tag-100000];
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(sender.tag-100000, 1)];
    [_tableView beginUpdates];
    [_tableView deleteSections:set withRowAnimation:UITableViewRowAnimationRight];
    [_tableView endUpdates];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView reloadData];
    });
}

#pragma mark - 下一页
-(void)didNextBtn
{
    [_textField resignFirstResponder];
    
    for (int i = 0; i<arrOfdata.count; i++)
    {
        NSMutableDictionary *dic = arrOfdata[i];
        for (int j = 0; j<5; j++)
        {
            if (![[dic objectForKey:keys[j]] length])
            {
                NSString *msg;
                if (j == 0) {
                    msg = [NSString stringWithFormat:@"\n请输入第%d场的开始时间",i+1];
                }else if (j == 1){
                    msg = [NSString stringWithFormat:@"\n请输入第%d场的结束时间",i+1];
                }else if (j == 2){
                    msg = [NSString stringWithFormat:@"\n请输入第%d场的演出地点",i+1];
                }else if (j == 3){
                    msg = [NSString stringWithFormat:@"\n请输入第%d场的演出场地",i+1];
                }else if (j == 4){
                    msg = [NSString stringWithFormat:@"\n请输入第%d场的场馆名称",i+1];
                }
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alertView show];
                return;
            }
        }
    }
    
    
    [_dictOfData setObject:arrOfdata forKey:@"matches"];
    
    CreateShowThirdViewController *thirdCtrl = [[CreateShowThirdViewController alloc] init];
    thirdCtrl.dictData = _dictOfData;
    [self.navigationController pushViewController:thirdCtrl animated:YES];
}



-(void)didGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addData:(NSString *)text
{

    [arrOfdata[myIndexPath.section] setObject:text forKey:keys[myIndexPath.row]];
    
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
