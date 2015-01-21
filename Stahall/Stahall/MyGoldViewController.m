//
//  MyGoldViewController.m
//  Stahall
//
//  Created by frankfan on 15/1/20.
//  Copyright (c) 2015年 Rching. All rights reserved.
//
//FIXME: 我的金币页面
#import "MyGoldViewController.h"
#import <ReactiveCocoa.h>

@interface MyGoldViewController ()

@end

@implementation MyGoldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor grayColor];
    //
    
    /*title*/
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 123, 40)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"我的金币";
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
    //
   __block UIButton *gold =[UIButton buttonWithType:UIButtonTypeCustom];
    gold.tag = 2002;
    gold.backgroundColor =[UIColor whiteColor];
    gold.frame = CGRectMake(0, 0, self.view.bounds.size.width/2.0, 50);
    [gold setTitle:@"金币" forState:UIControlStateNormal];
    gold.titleLabel.font =[UIFont systemFontOfSize:14];
    [gold setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:gold];
    
    
   __block UIButton *creditable =[UIButton buttonWithType:UIButtonTypeCustom];
    creditable.tag = 2003;
    creditable.backgroundColor =[UIColor whiteColor];
    creditable.frame = CGRectMake(self.view.bounds.size.width/2.0, 0, self.view.bounds.size.width/2.0, 50);
    [creditable setTitle:@"担保金" forState:UIControlStateNormal];
    creditable.titleLabel.font =[UIFont systemFontOfSize:14];
    [creditable setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:creditable];

   __block UIView *slideView =[[UIView alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width/2.0, 3)];
    slideView.backgroundColor =[UIColor greenColor];
    [self.view addSubview:slideView];
    
    
    gold.rac_command =[[RACCommand alloc]initWithSignalBlock:^RACSignal *(UIButton *input) {
        
        [UIView animateWithDuration:0.35 animations:^{
            
            slideView.frame = CGRectMake(0, 50, self.view.bounds.size.width/2.0, 3);
        }];
        
        [creditable setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [gold setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
  
        return [RACSignal empty];
    }];
    
    creditable.rac_command =[[RACCommand alloc]initWithSignalBlock:^RACSignal *(UIButton *input) {
        
        [UIView animateWithDuration:0.35 animations:^{
            
            slideView.frame = CGRectMake(self.view.bounds.size.width/2.0, 50, self.view.bounds.size.width/2.0, 3);
        }];
        
        [creditable setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [gold setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
      
        return [RACSignal empty];
    }];
    
    
    
    UIView *backView1 =[[UIView alloc]initWithFrame:CGRectMake(20, 80, self.view.bounds.size.width-40, 60)];
    backView1.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView1];
    
    UILabel *goldLabel =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, 60)];
    goldLabel.font =[UIFont systemFontOfSize:14];
    goldLabel.text = @"我的金币";
    goldLabel.textColor =[UIColor grayColor];
    [backView1 addSubview:goldLabel];
    
    //我的金币个数
    UILabel *goldNumber =[[UILabel alloc]initWithFrame:CGRectMake(100, 0, 30, 60)];
    goldNumber.font =[UIFont systemFontOfSize:14];
    goldNumber.textColor =[UIColor orangeColor];
    [backView1 addSubview:goldNumber];
    goldNumber.text = @"20.0";
    
    UILabel *num =[[UILabel alloc]initWithFrame:CGRectMake(140, 0, 20, 60)];
    num.font =[UIFont systemFontOfSize:14];
    num.textColor =[UIColor grayColor];
    [backView1 addSubview:num];
    num.text = @"个";
    
    //充值
    UIButton *topUp =[UIButton buttonWithType:UIButtonTypeCustom];
    topUp.titleLabel.font =[UIFont systemFontOfSize:14];
    [topUp setTitle:@"充值" forState:UIControlStateNormal];
    [topUp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    topUp.frame = CGRectMake(backView1.bounds.size.width-80, 0, 60, 60);
    [backView1 addSubview:topUp];
    
    //金币说明
    UIButton *goldCommit =[UIButton buttonWithType:UIButtonTypeCustom];
    goldCommit.titleLabel.font =[UIFont systemFontOfSize:14];
    goldCommit.backgroundColor =[UIColor whiteColor];
    goldCommit.frame = CGRectMake(20, 170, (self.view.bounds.size.width-40-20)/2.0, 123);
    [goldCommit setTitle:@"金币说明" forState:UIControlStateNormal];
    [goldCommit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:goldCommit];
    
    //历史记录
    
    UIButton *historyRecode =[UIButton buttonWithType:UIButtonTypeCustom];
    historyRecode.titleLabel.font =[UIFont systemFontOfSize:14];
    historyRecode.backgroundColor =[UIColor whiteColor];
    historyRecode.frame = CGRectMake(20+20+(self.view.bounds.size.width-40-20)/2.0, 170, (self.view.bounds.size.width-40-20)/2.0, 123);
    [historyRecode setTitle:@"历史记录" forState:UIControlStateNormal];
    [historyRecode setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:historyRecode];
    
    //
    
    
    
    
    
    
    
    
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
