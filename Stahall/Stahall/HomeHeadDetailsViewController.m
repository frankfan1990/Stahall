//
//  HomeHeadDetailsViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-25.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "HomeHeadDetailsViewController.h"

@interface HomeHeadDetailsViewController ()
{
    UIWebView *_webView;
}
@end

@implementation HomeHeadDetailsViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [_webView loadHTMLString:_dataStr baseURL:nil];
    [self.view addSubview:_webView];
    
}

#pragma mark - TabBar的设置
-(void)setTabBar
{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1]];
    
    
    UIButton *btnLeft1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLeft1.layer.masksToBounds = YES;
    btnLeft1.layer.cornerRadius = 20;
    [btnLeft1 setFrame:CGRectMake(0, 0, 35, 35)];
    [btnLeft1 setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateNormal];
    [btnLeft1 setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateHighlighted];
    [btnLeft1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft1 addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft1];
    
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
    }
    
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    title.text = @"海报详情";
    
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}

-(void)buttonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
