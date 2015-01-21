//
//  ShowMallsViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-15.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "ShowMallsViewController.h"
#import "ShowMallsTableViewCell.h"
#import "ShowDetailsViewController.h"
#import "MyNeedViewController.h"
#import "MyRecommendViewController.h"
#import "CycleScrollView.h"
#import "ShowMallDetailsViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "Marcos.h"

#pragma mark -  秀MALL 内容列表
@interface ShowMallsViewController()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UITableView *_tableViewOther;
    CycleScrollView *headScrollView;
    
    //判定 小tableView 是否 随着大tableView滑动
    BOOL isFollow;
    
    //定义一个全局的btn 这个指针 指向 点击 那个按钮
    UIButton *MyBtn;
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    NSMutableArray *arrOfTableData;
    UIView *backView;
    
    NSArray *arrData;
    
    UIView *myView;
    
}
@property (nonatomic,strong)NSMutableArray *arrOfimages_one; // 第一个cell里的图片
@end
@implementation ShowMallsViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    MyBtn.selected = YES;
    _tableViewOther.alpha = 0;
    
}
-(void)viewDidLoad
{
    [self getData];
    _arrOfimages_one = [NSMutableArray arrayWithObjects:@"七夕",@"七夕",@"七夕",@"七夕",nil];
    isFollow = YES;
    self.view.backgroundColor = [UIColor colorWithRed:114/255.0 green:190/255.0 blue:222/255.0 alpha:1];
    [self createHeadSrcoView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,Mywidth, Myheight -64) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:114/255.0 green:190/255.0 blue:222/255.0 alpha:1];
    _tableView.delegate = self;
    _tableView.tag = 1200;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableViewOther = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _tableViewOther.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableViewOther.delegate = self;
    _tableViewOther.dataSource = self;
    _tableViewOther.alpha = 0;
    _tableViewOther.tag = 2000;
    [[UIApplication sharedApplication].keyWindow addSubview:_tableViewOther];
    
    myView = [[UIView alloc] initWithFrame:CGRectMake(Mywidth-30, Myheight-180, 200+20, 45)];
    myView.backgroundColor = [UIColor greenColor];
    myView.layer.masksToBounds = YES;
    myView.layer.cornerRadius = 22.5;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setImage:[UIImage imageNamed:@"lc向左灰"] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"lc向右灰"] forState:UIControlStateSelected];
    
    [self CustomButton:button1 frame:CGRectMake( 0 ,7.5, 30, 30) title:@"" buttonTag:98 fontSize:14 titleColor:nil backgroundColor:[UIColor clearColor]];

    [button1 addTarget:self action:@selector(didmyButton:) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self CustomButton:button2 frame:CGRectMake(35, 0, 85, 45) title:@"我推荐" buttonTag:99 fontSize:15 titleColor:nil backgroundColor:[UIColor clearColor]];
    [button2  addTarget:self action:@selector(didmyButton:) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self CustomButton:button3 frame:CGRectMake(button2.frame.size.width+button2.frame.origin.x, 0, 85, 45) title:@"我需要" buttonTag:100 fontSize:15 titleColor:nil backgroundColor:[UIColor clearColor]];
    [button3 addTarget:self action:@selector(didmyButton:) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:button3];
    
    button1.layer.borderWidth=0;
    button2.layer.borderWidth=0;
    button3.layer.borderWidth=0;
    [self.view addSubview:myView];
}


-(void)getData
{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/plain"]];
    //秀mall数据
    NSDictionary *parameterdic = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"start",@"20",@"limit",@"秀Mall",@"query",nil];
    [manger GET:MALLListIP parameters:parameterdic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        arrData = (NSArray *)responseObject[@"results"];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
    }];
    
}
-(void)createHeadSrcoView
{
    headScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(10, 10, Mywidth-20, 170) animationDuration:3 andShowControlDot:YES];
    headScrollView.backgroundColor = [UIColor clearColor];
    __weak typeof (self)Myself = self;
    headScrollView.totalPagesCount = ^NSInteger(void){
        return Myself.arrOfimages_one.count;
    };
    headScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Myself.view.frame.size.width-20, 140)];
        imageV.image = [UIImage imageNamed:Myself.arrOfimages_one[pageIndex]];
        return imageV;
    };
    
#pragma mark - 点击轮播图
    headScrollView.TapActionBlock = ^(NSInteger pageIndex){
        
        ShowDetailsViewController *details = [[ShowDetailsViewController alloc] init];
        details.titleViewStr  = @"海报详情";
        details.type = 1;
        [Myself.navigationController pushViewController:details animated:YES];
        NSLog(@"%ld",(long)pageIndex);
    };
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
    title.text = @"秀MALL";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}

#pragma mark - tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1200) {
        
        if (section == 1) {
            return arrData.count;
        }
        return 1;
        
    }else{
        
        return arrOfTableData.count;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1200) {
        if (indexPath.section == 0) {
            return 180;
        }else{
            return 205;
        }
    }else{
        return 25;
    }
   
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 1200) {
        return 2;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 1200 && section == 1) {
        return 45;
    }else{
        return 0.01;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 1200 && section == 1) {

        backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 45)];
//        backView.backgroundColor = [UIColor whiteColor];
        btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self CustomButton:btn1 frame:CGRectMake(15, 10, (Mywidth-80)/3, 25) title:@"不限" buttonTag:10001 fontSize:13 titleColor:[UIColor whiteColor] backgroundColor:[UIColor clearColor]];
        
        btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self CustomButton:btn2 frame:CGRectMake(15+(Mywidth-80)/3+25, 10, (Mywidth-80)/3, 25) title:@"类别" buttonTag:10002 fontSize:13 titleColor:[UIColor whiteColor] backgroundColor:[UIColor clearColor]];
        
        btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self CustomButton:btn3 frame:CGRectMake(15+(Mywidth-80)/3*2+50, 10, (Mywidth-80)/3, 25) title:@"价格区间" buttonTag:10003 fontSize:13 titleColor:[UIColor whiteColor] backgroundColor:[UIColor clearColor]];
        
        [btn1 addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn3 addTarget:self action:@selector(didBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn1.selected = YES;
        btn2.selected = YES;
        btn3.selected = YES;
        
        [backView addSubview:btn1];
        [backView addSubview:btn2];
        [backView addSubview:btn3];
       
        backView.backgroundColor = [UIColor colorWithRed:114/255.0 green:190/255.0 blue:222/255.0 alpha:1];
        return backView;

    }else{
        return nil;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1200) {
        if (indexPath.section == 0) {
            UITableViewCell *cell0 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell0.selectionStyle = UITableViewCellSelectionStyleNone;
            cell0.backgroundColor = [UIColor colorWithRed:114/255.0 green:190/255.0 blue:222/255.0 alpha:1];
            [cell0.contentView addSubview:headScrollView];
            return cell0;
        }
        
        static NSString *cellStr = @"mycell";
        ShowMallsTableViewCell *cell = (ShowMallsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell == nil) {
            cell = [[ShowMallsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            cell.backgroundColor = [UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backView.backgroundColor = [UIColor colorWithRed:114/255.0 green:190/255.0 blue:222/255.0 alpha:1];
        }
        cell.labelOfTitle.text = arrData[indexPath.row][@"title"];
        cell.labelOfDate.text = arrData[indexPath.row][@"timer"];
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:arrData[indexPath.row][@"titlePage"]] placeholderImage:[UIImage imageNamed:@""]];
        return cell;
    }
    else{
        
        static NSString *str = @"mycellTwo";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = YES;
            UILabel *label  = [[UILabel alloc] init];
            label.tag = 101;
            [self Customlable:label text:@"" fontSzie:13 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter adjustsFontSizeToFitWidth:YES numberOfLines:1];
            label.frame = CGRectMake(0, 0, _tableViewOther.frame.size.width, 25);
            [cell.contentView addSubview:label];
        }
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:101];
        label.text = arrOfTableData[indexPath.row];

        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1200){
        
        ShowMallDetailsViewController *details = [[ShowMallDetailsViewController alloc] init];
        details.mallId = arrData[indexPath.row][@"mallId"];
        details.imageUrl = arrData[indexPath.row][@"titlePage"];
        [self.navigationController pushViewController:details animated:YES];
    }else if (tableView.tag == 2000){
        [MyBtn setTitle:arrOfTableData[indexPath.row] forState:UIControlStateNormal];
        if (MyBtn != nil) {
            MyBtn.selected = YES;
        }
        [UIView animateWithDuration:0.2 animations:^{
            _tableViewOther.alpha = 0;
        }];
    }

}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //第一个cell 将要出现 则 要小tableView 跟着大 tableView动
    if (indexPath.section == 0 && indexPath.row == 0 && tableView.tag == 1200) {
        isFollow = YES;
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
     //第一个cell 消失 则 要小tableView 不需要 跟着tableView动
    if (indexPath.section == 0 && indexPath.row == 0 && tableView.tag == 1200) {
        isFollow = NO;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
 
    if (!isFollow) {
        return;
    }
    CGPoint point = [MyBtn.superview convertPoint:CGPointMake(MyBtn.frame.origin.x, MyBtn.frame.origin.y+25) toView:_tableView.superview];
    // 猛力 上滑 就会导致piont.y很大 在这里限制一下
    if (point.y <36) {
        point.y = 36;
    }
    CGFloat height = arrOfTableData.count*25;
    if (arrOfTableData.count>5) {
        height = 5*25;
    }
    
    _tableViewOther.frame = CGRectMake(point.x, point.y+64,MyBtn.frame.size.width, height);
}

#pragma mark - 点击 我需要 我推荐
-(void)didmyButton:(UIButton *)sender{
    if (sender.tag == 98) {
        [UIView animateWithDuration:0.5 animations:^{
            sender.selected = !sender.selected;
            if (sender.selected) {
                myView.frame = CGRectMake(Mywidth-200, Myheight-180+64, 200+20, 45);
                sender.frame = CGRectMake( 5 ,7.5, 30, 30);
            }else{
                myView.frame = CGRectMake(Mywidth-30, Myheight-180+64, 200+20, 45);
                sender.frame = CGRectMake( 0 ,7.5, 30, 30);
            }
            
        }];
    }else if (sender.tag == 99){
        MyRecommendViewController *commendCtrl = [[MyRecommendViewController alloc] init];
        [self.navigationController pushViewController:commendCtrl animated:YES];
        NSLog(@"我推荐");
    }else if (sender.tag == 100){
        MyNeedViewController *needCtrl = [[MyNeedViewController alloc] init];
        [self.navigationController pushViewController:needCtrl animated:YES];
        NSLog(@"我需要");
    }
}

#pragma mark - 点击返回上一页
-(void)didGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 点击选择分类
-(void)didBtn:(UIButton *)sender
{
    //再没有选择内容时 就点击其他按钮 则把前面那个按钮的选中状态 变成YES
    if (MyBtn != nil && MyBtn.tag != sender.tag) {
        MyBtn.selected = YES;
        _tableViewOther.alpha = 0;
    }
    
    //取得当前点击的Button
    MyBtn = sender;
    
    
    if (sender.tag == 10001) {
        arrOfTableData = [NSMutableArray arrayWithObjects:@"热门",@"不限",@"中国最强音",@"星光大道",@"春晚",@"中国最强音",@"我是歌手",@"超男快女",@"网络", nil];
    }else if (sender.tag == 10002){
        arrOfTableData = [NSMutableArray arrayWithObjects:@"不限",@"影视",@"主持",@"歌手",@"曲艺",nil];
    }else if (sender.tag == 10003){
        arrOfTableData = [NSMutableArray arrayWithObjects:@"不限",@"0-1万元",@"1-5万元",@"5-10万元",@"10-20万元",@"20-30万元",nil];
    }
    
    CGFloat height = arrOfTableData.count*25;
    if (arrOfTableData.count>5) {
        height = 5*25;
    }
    
    CGPoint ponint = [sender.superview convertPoint:CGPointMake(sender.frame.origin.x, sender.frame.origin.y+25) toView:_tableView.superview];
    
    
    _tableViewOther.frame = CGRectMake(ponint.x, ponint.y+64,sender.frame.size.width, height);
    
    [UIView animateWithDuration:0.4 animations:^{
        if (sender.selected) {
            _tableViewOther.alpha = 1;
            sender.selected = NO;
        }else{
            _tableViewOther.alpha = 0;
            sender.selected = YES;
        }
    }];
    [_tableViewOther reloadData];
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
//    sender.layer.masksToBounds = YES;
//    sender.layer.cornerRadius = 4;
    sender.layer.borderWidth = 0.5;
    sender.layer.borderColor = [UIColor colorWithRed:190/255.0 green:190/255. blue:190/255. alpha:1].CGColor;
}

@end
