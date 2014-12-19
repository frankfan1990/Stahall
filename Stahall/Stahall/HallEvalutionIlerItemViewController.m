//
//  HallEvalutionIlerItemViewController.m
//  Stahall
//
//  Created by frankfan on 14/12/19.
//  Copyright (c) 2014年 Rching. All rights reserved.
//
//FIXME: 堂估价条款

#import "HallEvalutionIlerItemViewController.h"



@interface HallEvalutionIlerItemViewController ()

@end

@implementation HallEvalutionIlerItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    //
    
    
    
    
    
    // Do any additional setup after loading the view.
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
