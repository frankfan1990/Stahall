//
//  MyEvalutionsCollectionViewController.m
//  Stahall
//
//  Created by frankfan on 15/1/9.
//  Copyright (c) 2015年 Rching. All rights reserved.
//
//FIXME: 已估价艺人集合视图

#import "MyEvalutionsCollectionViewController.h"

@interface MyEvalutionsCollectionViewController ()

@end

@implementation MyEvalutionsCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.contents =(__bridge id)[UIImage imageNamed:@"backgroundImage"].CGImage;
    


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
