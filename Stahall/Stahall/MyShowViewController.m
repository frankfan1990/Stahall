//
//  MyShowViewController.m
//  Stahall
//
//  Created by frankfan on 14/12/14.
//  Copyright (c) 2014年 Rching. All rights reserved.
//
//FIXME: 我的演出

#import "MyShowViewController.h"
#import "RESideMenu.h"
#import "Marcos.h"
#import "MainViewController.h"

@interface MyShowViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIButton *btnLeft;
    UIButton *btnRight;
    NSArray *arrOfHeadTitleOne;
    NSArray *arrOfHeadTitleTwo;
}
@end

@implementation MyShowViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBar];
    [self Variableinitialization];
    self.view.backgroundColor = [UIColor whiteColor];
    btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLeft.selected = YES;
    btnRight.selected = NO;
    
    [btnLeft setTitle:@"我的项目" forState:UIControlStateNormal];
    [btnLeft setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btnLeft setTitleColor:[UIColor colorWithRed:0/255.0 green:180/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnLeft addTarget:self action:@selector(didLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    [btnRight setTitle:@"我的估价" forState:UIControlStateNormal];
    [btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btnRight setTitleColor:[UIColor colorWithRed:0/255.0 green:180/255.0 blue:204/255.0 alpha:1] forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(didRightBtn) forControlEvents:UIControlEventTouchUpInside];
    btnLeft.backgroundColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:204/255.0 alpha:1];
    btnRight.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight-64-45) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    UIButton *addNewShowBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    addNewShowBtn.frame = CGRectMake(0, Myheight-45-64,Mywidth, 45);
    
    [addNewShowBtn setTitle:@"新建演出" forState:UIControlStateNormal];
    [addNewShowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addNewShowBtn.backgroundColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:204/255.0 alpha:1];
    
    [addNewShowBtn addTarget:self action:@selector(didAddNewShow) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addNewShowBtn];
    
    
}
#pragma mark - tabBar的设置
-(void)setTabBar{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0/255.0 green:180/255.0 blue:204/255.0 alpha:1]];
    
    UIButton *btnLeft1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLeft1.layer.masksToBounds = YES;
    btnLeft1.layer.cornerRadius = 20;
    [btnLeft1 setFrame:CGRectMake(0, 0, 35, 35)];
    [btnLeft1 setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateNormal];
    [btnLeft1 setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateHighlighted];
    [btnLeft1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft1];
    
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
    }
    
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    title.text = @"我的演出";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
}

#pragma mark - 变量的初始化
-(void)Variableinitialization
{
    arrOfHeadTitleOne = @[@"待审核",@"进行中",@"已完成"];
    arrOfHeadTitleTwo = @[@"估价中",@"已完成"];
    
}

#pragma mark - tableView 好多分组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (btnLeft.selected) {
        return arrOfHeadTitleOne.count+1;
    }else{
        return arrOfHeadTitleTwo.count+1;
    }
}

#pragma mark - tableView的 每一组有几个cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 1;
    }else if (section == 2){
        return 2;
    }else if (section == 3){
        return 1;
    }
    return  1;
}

#pragma mark - tableView———headView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    if (section == 0) {
        UIView *myView = [[UIView alloc] init];
        UIView *bakcView = [[UIView alloc] initWithFrame:CGRectMake(20, 15, Mywidth-40, 35)];
        bakcView.layer.masksToBounds = YES;
        bakcView.layer.cornerRadius = 8;
        bakcView.layer.borderWidth = 0.5;
        bakcView.layer.borderColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:204/255.0 alpha:1].CGColor;
       
        btnLeft.frame = CGRectMake(0, 0, bakcView.frame.size.width/2, bakcView.frame.size.height);
        btnRight.frame = CGRectMake(bakcView.frame.size.width/2, 0, bakcView.frame.size.width/2, bakcView.frame.size.height);
        
        [bakcView addSubview:btnLeft];
        [bakcView addSubview:btnRight];
        [myView addSubview:bakcView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,65-0.5, Mywidth, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1];
        [myView addSubview:lineView];
        
        return myView;
    }
    else{
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 40)];
        backView.backgroundColor = [UIColor whiteColor];
        
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(65, 10, 20, 20)];
        imageV.layer.masksToBounds = YES;
        imageV.layer.cornerRadius = 10;
        
        UILabel *labeilOfTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 60, 20)];
        
        if (btnLeft.selected) {
            
            if (section == 1) {
                imageV.backgroundColor = [UIColor orangeColor];
            }else if (section == 2){
                imageV.backgroundColor = [UIColor redColor];
            }else if(section == 3){
                imageV.backgroundColor = [UIColor greenColor];
            }
            
            [self Customlable:labeilOfTitle text:arrOfHeadTitleOne[section-1] fontSzie:15 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter adjustsFontSizeToFitWidth:NO numberOfLines:1];
        }else{
            [self Customlable:labeilOfTitle text:arrOfHeadTitleTwo[section-1] fontSzie:15 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter adjustsFontSizeToFitWidth:NO numberOfLines:1];
            
            if (section == 1) {
                imageV.backgroundColor = [UIColor orangeColor];
            }else if (section == 2){
                imageV.backgroundColor = [UIColor greenColor];
            }
        }
        [backView addSubview:imageV];
        [backView addSubview:labeilOfTitle];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,backView.frame.size.height-0.5, Mywidth, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1];
        [backView addSubview:lineView];
        return backView;
    }
   
}
#pragma mark - tableView的 headView的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 65;
    }else{
        return 40;
    }
}

#pragma mark - tableView的 每一个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 0.01;
    }
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"Mycell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *labelOfConten = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, Mywidth-20-120, 20)];
        UILabel *labelOfDate = [[UILabel alloc] initWithFrame:CGRectMake(Mywidth-120, 10, 110, 20)];

        labelOfConten.tag = 10000;
        labelOfDate.tag = 100000;
        [self Customlable:labelOfConten text:nil fontSzie:14 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
         [self Customlable:labelOfDate text:nil fontSzie:12 textColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] textAlignment:NSTextAlignmentRight adjustsFontSizeToFitWidth:NO numberOfLines:1];
        [cell.contentView addSubview:labelOfConten];
        [cell.contentView addSubview:labelOfDate];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,40-0.5, Mywidth, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1];
        [cell.contentView addSubview:lineView];
        
    }
    UILabel *labelContent = (UILabel *)[cell.contentView viewWithTag:10000];
    UILabel *labelOfDate = (UILabel *)[cell.contentView viewWithTag:100000];
    
    labelOfDate.text = @"2015-01-01 08:30";
    labelContent.text = @"陈奕迅演唱会";
    
    return cell;
}



#pragma mark - 导航栏按钮触发
- (void)buttonClicked:(UIButton *)sender{

    MainViewController *mainViewController =[MainViewController new];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:mainViewController] animated:YES];
    [self.sideMenuViewController presentLeftMenuViewController];
  
}


#pragma mark -点击 我的项目 我的估价 事件
-(void)didLeftBtn{
    btnLeft.selected  = YES;
    btnRight.selected = NO;
      btnRight.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:0.3 animations:^{
        btnLeft.backgroundColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:204/255.0 alpha:1];
      
    }];
    [_tableView reloadData];

}
-(void)didRightBtn{
    btnLeft.selected  = NO;
    btnRight.selected = YES;
    btnLeft.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:0.3 animations:^{
        btnRight.backgroundColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:204/255.0 alpha:1];
        
    }];
    [_tableView reloadData];
}

-(void)didAddNewShow{
    NSLog(@"add add");
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
