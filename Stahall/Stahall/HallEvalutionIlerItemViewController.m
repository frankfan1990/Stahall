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
#import "StahallValuationViewController.h"
#import "ProgressHUD.h"

@interface HallEvalutionIlerItemViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    CGFloat cellHeight;
    RTLabel *rtlabel;
    
    UIButton *allowCheck;
    UIButton *unallowCheck;
    
    NSMutableArray *checkBoxState;
    
    UILabel *allowLabel;
    UILabel *unAllow;
    
    UIButton *commitButton;
    
    NSInteger currentTag;//记录当前的确认框
    
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
    currentTag = 1001;
    
    
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
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStylePlain];
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
    NSString *testString = @"出的艺人演艺价格堂估价条款-堂估价是艺人堂根据平台<p>大量交易数据分堂估款-堂估价是艺人堂\n根据平台大量交易数据分析得出的艺人演艺价格堂估价条款-堂估价是艺人堂根据平台大量交易人演艺价格堂估价条款-堂估价是艺人堂根据平台大量交易堂估款-堂估价是艺人堂根据平台大量交易数据分析得出的艺人演艺价格堂估价条款-堂估价是艺人堂根据平台大量交易数据分析得出的艺人演艺价格堂估价条款-堂估价是艺人堂根据平台大量交易析得出的艺人演艺价格";
    rtlabel.text = [self handleStringForRTLabel:testString];
    cellHeight = rtlabel.optimumSize.height;
   
  
    //
    allowCheck =[UIButton buttonWithType:UIButtonTypeCustom];
    allowCheck.tag = 1001;
    [allowCheck addTarget:self action:@selector(checkOrUncheckButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [allowCheck setImage:[UIImage imageNamed:@"fz对勾"] forState:UIControlStateNormal];
    
    
    unallowCheck =[UIButton buttonWithType:UIButtonTypeCustom];
    unallowCheck.tag = 1002;
    [unallowCheck addTarget:self action:@selector(checkOrUncheckButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    allowLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2.0+10, 0, 100, 35)];
    allowLabel.font =[UIFont systemFontOfSize:14];
    allowLabel.text = @"同意";
    allowCheck.backgroundColor =[UIColor colorWithWhite:0.85 alpha:1];

    
    unAllow = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2.0+10, 0, 100, 35)];
    unAllow.font =[UIFont systemFontOfSize:14];
    unAllow.text = @"不同意";
    unallowCheck.backgroundColor =[UIColor colorWithWhite:0.85 alpha:1];
    
    commitButton =[UIButton buttonWithType:UIButtonTypeCustom];
    commitButton.backgroundColor =[UIColor orangeColor];
    commitButton.layer.cornerRadius = 3;
    [commitButton setTitle:@"继续" forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(goToNextPage) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Do any additional setup after loading the view.
}

#pragma mark - cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}


#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return cellHeight+230;
}


#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellName =@"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellName];
    if(!cell){
    
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//        cell.backgroundColor =[UIColor orangeColor];
        
        rtlabel.frame = CGRectMake(10, 10, self.view.bounds.size.width-20, cellHeight);
        allowLabel.frame = CGRectMake(self.view.bounds.size.width/2.0-10, cellHeight+45, 100, 35);
        unAllow.frame = CGRectMake(self.view.bounds.size.width/2.0-10, cellHeight+45+35+20, 100, 35);
        
        allowCheck.frame = CGRectMake(self.view.bounds.size.width/2.0-25-10, cellHeight+45+10, 15, 15);
        unallowCheck.frame = CGRectMake(self.view.bounds.size.width/2.0-25-10, cellHeight+45+35+20+10, 15, 15);
        
        
        [cell.contentView addSubview:allowCheck];
        [cell.contentView addSubview:unallowCheck];
        [cell.contentView addSubview:allowLabel];
        [cell.contentView addSubview:unAllow];
        [cell.contentView addSubview:rtlabel];
        
        //
        commitButton.frame = CGRectMake(self.view.bounds.size.width/2.0-25, cellHeight+45+35+20+10+40, 50, 30);
        [cell.contentView addSubview:commitButton];
        
        
    }
    
    return cell;
}


#pragma mark - 继续按钮触发
- (void)goToNextPage{

    if(currentTag==1001){//同意跳转
    
        StahallValuationViewController *staHallvaluation =[StahallValuationViewController new];
        [self.navigationController pushViewController:staHallvaluation animated:YES];
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isAgreen"];
        
    }else{
    
        [ProgressHUD showError:@"请勾选同意选项"];
    }

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



#pragma mark - 同意/不同意 - 方法触发

- (void)checkOrUncheckButtonClicked:(UIButton *)sender{
    
    if(sender.tag==1001){//同意
    
        if(!sender.currentImage){
        
            currentTag = 1001;
            [unallowCheck setImage:nil forState:UIControlStateNormal];
        }
    
    }else{//不同意
    
        if(!sender.currentImage){
        
            currentTag = 1002;
            [allowCheck setImage:nil forState:UIControlStateNormal];
        }
    
    }
    
    [sender setImage:[UIImage imageNamed:@"fz对勾"] forState:UIControlStateNormal];
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
