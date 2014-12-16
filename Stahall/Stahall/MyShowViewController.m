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
#import "MainViewController.h"

@interface MyShowViewController ()

@end

@implementation MyShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}

#pragma mark - 导航栏按钮触发
- (void)buttonClicked:(UIButton *)sender{

    MainViewController *mainViewController =[MainViewController new];
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:mainViewController] animated:YES];
    [self.sideMenuViewController presentLeftMenuViewController];
  
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
