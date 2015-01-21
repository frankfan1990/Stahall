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

@property (nonatomic,strong)UITableView *tableView;
@end

@implementation MyCreditableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor grayColor];
    //
    /*title*/
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 123, 40)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"我的信用";
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView  =title;
    
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
    
    
    historyRecode.rac_command =[[RACCommand alloc]initWithSignalBlock:^RACSignal *(UIButton *input) {
        
        [UIView animateWithDuration:0.35 animations:^{
            
            slideView.frame = CGRectMake(0, 50, self.view.bounds.size.width/2.0, 3);
        }];
        
        [creditable setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [historyRecode setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        
        return [RACSignal empty];
    }];
    
    creditable.rac_command =[[RACCommand alloc]initWithSignalBlock:^RACSignal *(UIButton *input) {
        
        [UIView animateWithDuration:0.35 animations:^{
            
            slideView.frame = CGRectMake(self.view.bounds.size.width/2.0, 50, self.view.bounds.size.width/2.0, 3);
        }];
        
        [creditable setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [historyRecode setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        return [RACSignal empty];
    }];

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
    star1.editable = YES;
    [star1 setNeedsDisplay];
    [backView addSubview:star1];

    UILabel *currentCre =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 50)];
    currentCre.font =[UIFont systemFontOfSize:14];
    currentCre.textColor =[UIColor grayColor];
    currentCre.text = @"当前信用";
    [backView addSubview:currentCre];

    //创建tableView
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(20, 130, self.view.bounds.size.width-40, self.view.bounds.size.height-200) style:UITableViewStylePlain];
    self.tableView.backgroundColor =[UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = NO;
    
    
    
    
    
}

#pragma marl -cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 10;
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
}

#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

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
        
        
        
    }
    
    return cell;

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
