//
//  HallEvalutionIlerItemViewController.m
//  Stahall
//
//  Created by frankfan on 14/12/19.
//  Copyright (c) 2014年 Rching. All rights reserved.
//
//FIXME: 堂估价条款

#import "HallEvalutionIlerItemViewController.h"
#import "RTLabel.h"

@interface HallEvalutionIlerItemViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    CGFloat cellHeight;
    RTLabel *rtlabel;
    
    UIButton *allowCheck;
    UIButton *unallowCheck;
    NSMutableArray *checkBoxState;
    
}
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation HallEvalutionIlerItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    /**
     初始化数据
     */
    checkBoxState =[NSMutableArray arrayWithObjects:@0,@0, nil];
    
    
    
    /*title*/
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    title.text = @"估价条款";
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView  =title;
    
    /*回退*/
    UIButton *searchButton0 =[UIButton buttonWithType:UIButtonTypeCustom];
    searchButton0.tag = 10006;
    searchButton0.frame = CGRectMake(0, 0, 30, 30);
    [searchButton0 setImage:[UIImage imageNamed:@"朝左箭头icon"] forState:UIControlStateNormal];
    [searchButton0 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftitem =[[UIBarButtonItem alloc]initWithCustomView:searchButton0];
    self.navigationItem.leftBarButtonItem = leftitem;

    //
    self.tableView =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
    self.tableView.allowsSelection = NO;
    
    CGRect rect = CGRectZero;
    UIView *footerView = [[UIView alloc]initWithFrame:rect];
    self.tableView.tableFooterView = footerView;
    
    //
    
    rtlabel =[[RTLabel alloc]initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width-20, 0)];
    NSString *testString = @"堂估价条款-堂估价是艺人堂根据平台大量交易数据分析得出的艺人演艺价格堂估价条款-堂估价是艺人堂根据平台大量交易数据分析得出的艺人演艺价格堂估价条款-堂估价是艺人堂根据平台大量交易数据分析得出的艺人演艺价格堂估价条款-堂估价是艺人堂根据平台大量交易数据分析得出的艺人演艺价格堂估价条款-堂估价是艺人堂根据平台大量交易数据分析得出的艺人演艺价格";
    rtlabel.text = [self handleStringForRTLabel:testString];
    cellHeight = rtlabel.optimumSize.height;
   
  
    //
    allowCheck =[UIButton buttonWithType:UIButtonTypeCustom];
    allowCheck.tag = 1001;
   
    
    unallowCheck =[UIButton buttonWithType:UIButtonTypeCustom];
    unallowCheck.tag = 1002;
    
    
    // Do any additional setup after loading the view.
}

#pragma mark - cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}


#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return cellHeight+180;
}


#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellName =@"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellName];
    if(!cell){
    
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.backgroundColor =[UIColor orangeColor];
        
        rtlabel.frame = CGRectMake(10, 10, self.view.bounds.size.width-20, cellHeight);
        [cell.contentView addSubview:rtlabel];
        
        //
        UILabel *allowLabel = [];
        
        
    }
    
    return cell;
}




#pragma mark - 处理富文本格式字符串，使之适配RTLabel的使用
- (NSString *)handleStringForRTLabel:(NSString *)htmlString{
    
    NSString *tempString = [htmlString stringByReplacingOccurrencesOfString:@"<br>" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [htmlString length])];
    
    NSString *resultString =[tempString stringByReplacingOccurrencesOfString:@"div" withString:@"br" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [tempString length])];
    
    return resultString;
}



#pragma mark - view将要出现
- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:76/255.0 green:60/255.0 blue:136/255.0 alpha:1]];
}


#pragma mark - 导航栏事件触发
- (void)buttonClicked:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
