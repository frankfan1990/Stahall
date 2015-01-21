//
//  MyCreditableViewController.m
//  Stahall
//
//  Created by frankfan on 15/1/20.
//  Copyright (c) 2015年 Rching. All rights reserved.
//
//FIXME: 我的信用页面
#import "MyCreditableViewController.h"
#import <ReactiveCocoa.h>
#import "EDStarRating.h"
#import "RTLabel.h"

@interface MyCreditableViewController ()<EDStarRatingProtocol,UITableViewDelegate,UITableViewDataSource>
{
    RTLabel *rtLabel;
    RTLabel *rtLabel2;
    
    //
    UIView *bigView;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITableView *tabeleView2;
@end

@implementation MyCreditableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor grayColor];
    //初始化
    bigView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width*2, self.view.bounds.size.height)];
    [self.view addSubview:bigView];
    //
    
    /*title*/
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 123, 40)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"我的信用";
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    /*回退*/
    UIButton *searchButton0 =[UIButton buttonWithType:UIButtonTypeCustom];
    searchButton0.tag = 10006;
    searchButton0.frame = CGRectMake(0, 0, 30, 30);
    [searchButton0 setImage:[UIImage imageNamed:@"朝左箭头icon"] forState:UIControlStateNormal];
    searchButton0.rac_command =[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        [self.navigationController popViewControllerAnimated:YES];
        return [RACSignal empty];
    }];
    
    UIBarButtonItem *leftitem =[[UIBarButtonItem alloc]initWithCustomView:searchButton0];
    self.navigationItem.leftBarButtonItem = leftitem;

    //
    __block UIButton *historyRecode =[UIButton buttonWithType:UIButtonTypeCustom];
    historyRecode.tag = 2002;
    historyRecode.backgroundColor =[UIColor whiteColor];
    historyRecode.frame = CGRectMake(0, 0, self.view.bounds.size.width/2.0, 50);
    [historyRecode setTitle:@"历史记录" forState:UIControlStateNormal];
    historyRecode.titleLabel.font =[UIFont systemFontOfSize:14];
    [historyRecode setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:historyRecode];
    
    
    __block UIButton *creditable =[UIButton buttonWithType:UIButtonTypeCustom];
    creditable.tag = 2003;
    creditable.backgroundColor =[UIColor whiteColor];
    creditable.frame = CGRectMake(self.view.bounds.size.width/2.0, 0, self.view.bounds.size.width/2.0, 50);
    [creditable setTitle:@"信用说明" forState:UIControlStateNormal];
    creditable.titleLabel.font =[UIFont systemFontOfSize:14];
    [creditable setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:creditable];
    
    __block UIView *slideView =[[UIView alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width/2.0, 3)];
    slideView.backgroundColor =[UIColor greenColor];
    [self.view addSubview:slideView];
    
    
    //
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(20, 70, self.view.bounds.size.width-40, 50)];
    backView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView];
   
    
    EDStarRating *star1 =[[EDStarRating alloc]initWithFrame:CGRectMake(70, 10, 123, 30)];
    
#pragma mark - 信用值
    star1.rating = 3;
    star1.tag = 3000;
    star1.delegate = self;
    star1.maxRating = 5;
    star1.starImage = [[UIImage imageNamed:@"star-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    star1.starHighlightedImage = [[UIImage imageNamed:@"star-highlighted-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    star1.horizontalMargin = 15.0;
    star1.displayMode=EDStarRatingDisplayFull;
    star1.tintColor = [UIColor orangeColor];
    star1.editable = NO;
    [star1 setNeedsDisplay];
    [backView addSubview:star1];

    UILabel *currentCre =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 50)];
    currentCre.font =[UIFont systemFontOfSize:14];
    currentCre.textColor =[UIColor grayColor];
    currentCre.text = @"当前信用";
    [backView addSubview:currentCre];

#warning 此处的控件高度需要设为0-这个用来获取内容高度的
    rtLabel =[[RTLabel alloc]initWithFrame:CGRectMake(10, 35, self.view.bounds.size.width-40-20-40, 80-35-15)];
    
    //创建tableView
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(20, 130, self.view.bounds.size.width-40, self.view.bounds.size.height-200) style:UITableViewStylePlain];
    self.tableView.tag = 1001;
    self.tableView.backgroundColor =[UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = NO;
    

    
    //信用说明部分
    __block UIView *secondePartView =[[UIView alloc]initWithFrame:CGRectMake(-self.view.bounds.size.width, 60, self.view.bounds.size.width, self.view.bounds.size.height)];
    secondePartView.alpha = 0;
    secondePartView.backgroundColor =[UIColor grayColor];
    [self.view addSubview:secondePartView];
    
    UILabel *aboutCreditate =[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 123, 30)];
    aboutCreditate.textColor =[UIColor whiteColor];
    aboutCreditate.font =[UIFont systemFontOfSize:14];
    aboutCreditate.text = @"信用说明";
    [secondePartView addSubview:aboutCreditate];
    
#warning 此处的控件高度需要设为0
    rtLabel2 =[[RTLabel alloc]initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width-20-20, 200)];
    
    //secondePart tableView
    self.tabeleView2 =[[UITableView alloc]initWithFrame:CGRectMake(10, 40, self.view.bounds.size.width-20, self.view.bounds.size.height-200+20)];
    self.tabeleView2.tag = 1002;
    self.tabeleView2.delegate = self;
    self.tabeleView2.dataSource = self;
    [secondePartView addSubview:self.tabeleView2];
    self.tabeleView2.tableFooterView =[[UIView alloc]init];
    self.tabeleView2.separatorStyle = NO;
    
    
    historyRecode.rac_command =[[RACCommand alloc]initWithSignalBlock:^RACSignal *(UIButton *input) {
        
        [UIView animateWithDuration:0.35 animations:^{
            
            slideView.frame = CGRectMake(0, 50, self.view.bounds.size.width/2.0, 3);
            secondePartView.frame  = CGRectMake(-self.view.bounds.size.width, 60, self.view.bounds.size.width, self.view.bounds.size.height);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.33 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                secondePartView.alpha = 0;
            });
            secondePartView.alpha = 0;
        }];
        
    
        [creditable setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [historyRecode setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        
        return [RACSignal empty];
    }];
    
    creditable.rac_command =[[RACCommand alloc]initWithSignalBlock:^RACSignal *(UIButton *input) {
        
        secondePartView.alpha = 1;
        [UIView animateWithDuration:0.35 animations:^{
            
            slideView.frame = CGRectMake(self.view.bounds.size.width/2.0, 50, self.view.bounds.size.width/2.0, 3);
            secondePartView.frame = CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height);
        }];
        
        [creditable setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [historyRecode setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        return [RACSignal empty];
    }];


    
}

#pragma marl -cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if(tableView.tag==1001){
    
        return 10;
    }else{
        return 1;
    }
    
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(tableView.tag==1001){
        return 80;
    }else{
    
        return 300;
    }
    
}

#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(tableView.tag==1001){
    
        static NSString *cellName = @"cell";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellName];
        if(!cell){
            
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            cell.opaque = YES;
            cell.selectionStyle = NO;
            cell.backgroundColor =[UIColor clearColor];
            //
            UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 10, cell.bounds.size.width, 80-20)];
            backView.backgroundColor =[UIColor whiteColor];
            [cell.contentView addSubview:backView];
            
            //时间
            UILabel *timeLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 123, 20)];
            timeLabel.textColor =[UIColor grayColor];
            timeLabel.tag = 3003;
            timeLabel.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:timeLabel];
            
            //正文
#warning 高度值为0
            RTLabel *newRtlabel = [[RTLabel alloc]initWithFrame:CGRectMake(10, 35, self.view.bounds.size.width-40-20-40, 80-35-15)];
            newRtlabel.backgroundColor =[UIColor orangeColor];
            newRtlabel.tag = 3004;
            newRtlabel.font =[UIFont systemFontOfSize:14];
#warning 这里需要注释掉
            newRtlabel.textColor =[UIColor blackColor];//这里需要注释掉
            [cell.contentView addSubview:newRtlabel];
            
        }
        
        UILabel *timeLabel =(UILabel *)[cell viewWithTag:3003];
        RTLabel *rtLabel_1 = (RTLabel *)[cell viewWithTag:3004];
        
        timeLabel.text =@"2015-1-21 10:45";
        rtLabel_1.text = @"这里是一个信用测试信用测试信用测试信用测试信用测试信测试";
        
        return cell;

    }else{
    
        
        static NSString *cellName2 = @"cell2";
        UITableViewCell *cell2 =[tableView dequeueReusableCellWithIdentifier:cellName2];
        if(!cell2){
        
            cell2 =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName2];
            cell2.selectionStyle = NO;
            
            rtLabel2.tag = 3005;
            [cell2.contentView addSubview:rtLabel2];
        }
        
        RTLabel *rtlabel_2 = (RTLabel *)[cell2 viewWithTag:3005];
        rtlabel_2.textColor =[UIColor grayColor];
        rtlabel_2.text = @"信用说明测试";
        return cell2;
    }
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
