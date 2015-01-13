//
//  SecondAccountsViewController.m
//  Stahall
//
//  Created by JM_Pro on 15-1-13.
//  Copyright (c) 2015年 Rching. All rights reserved.
//

#import "SecondAccountsViewController.h"
#import "AFNetworking.h"
#import "AddSecondAccoutsViewController.h"
#import "Marcos.h"

#pragma mark - 二级账号列表

@interface SecondAccountsViewController ()
{
    
}
@end

@implementation SecondAccountsViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)setTabBar
{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:115/255.0 green:199/255.0 blue:228/255.0 alpha:1]];
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLeft.layer.masksToBounds = YES;
    btnLeft.layer.cornerRadius = 20;
    [btnLeft setFrame:CGRectMake(0, 0, 35, 35)];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateHighlighted];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(didGoBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    UIButton*  btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:@"增加" forState:UIControlStateNormal];
    [btn2 setFrame:CGRectMake(0, 10, 40, 45)];;
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(didAdd) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnright = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -5;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        self.navigationItem.rightBarButtonItems= @[negativeSpacer, btnright];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
        self.navigationItem.rightBarButtonItem = btnright;
    }
    
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    title.text = @"二级账号";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 增加二级账号
-(void)didAdd{
    AddSecondAccoutsViewController *addCtrl = [[AddSecondAccoutsViewController alloc] init];
    [self.navigationController pushViewController:addCtrl animated:YES];
}


@end
