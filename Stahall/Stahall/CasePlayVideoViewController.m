//
//  CasePlayVideoViewController.m
//  Stahall
//
//  Created by JM_Pro on 15-1-8.
//  Copyright (c) 2015年 Rching. All rights reserved.
//

#import "CasePlayVideoViewController.h"
#import "Marcos.h"
@interface CasePlayVideoViewController ()<UIWebViewDelegate>

@end

@implementation CasePlayVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight)];
    webView.backgroundColor = [UIColor whiteColor];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_dataDict[@"link"]]]];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didBack) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(Mywidth-60, 15, 50, 30);
    [self.view addSubview:btn];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error);
}


-(void)didBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
