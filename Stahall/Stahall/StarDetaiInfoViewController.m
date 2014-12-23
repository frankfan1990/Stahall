//
//  StarDetaiInfoViewController.m
//  Stahall
//
//  Created by frankfan on 14/12/23.
//  Copyright (c) 2014年 Rching. All rights reserved.
//
//FIXME: 艺人详情


#import "StarDetaiInfoViewController.h"

@interface StarDetaiInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    UIWebView *webView;
}
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation StarDetaiInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*title*/
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:69/255.0 green:174/255.0 blue:215/255.0 alpha:1]];
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    title.text = self.starName;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    /*回退*/
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.tag = 10006;
    backButton.frame = CGRectMake(0, 0, 30, 30);
    [backButton setImage:[UIImage imageNamed:@"朝左箭头icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftitem =[[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftitem;
    
    //背景
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"fz艺人详情背景"].CGImage;
    
    /**
     *  @author frankfan, 14-12-23 15:12:43
     *
     *  创建主界面
     */
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-44) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundColor =[UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    CGRect rect = CGRectZero;
    UIView *footerView =[[UIView alloc]initWithFrame:rect];
    self.tableView.tableFooterView = footerView;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    //创建webView
    webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
    webView.opaque = NO;
    webView.backgroundColor =[UIColor orangeColor];
    
    //创建button
    
    
    
}


#pragma mark - section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

#pragma mark - cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellName =@"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellName];
    if(!cell){
    
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.selectionStyle = NO;
        
        if(indexPath.section==0){
        
            [cell.contentView addSubview:webView];
        }
    }
    
    
    
    return cell;
}

#pragma mark - 控制头部的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section==0){
        
        return 0.1;
        
    }else if (section==1){
        
        return 5;
        
    }else{
    
        return 5;
    }


}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.section==0){
    
        return 200;

        
    }else if (indexPath.section==1){
    
        return 330;
    }else{
        
        return 60;
    }
    
}



#pragma mark- 创建button
- (UIButton *)createButtonWithTag:(NSInteger)tag andTitle:(NSString *)title andBackGroundImage:(UIImage *)image andFrame:(CGRect)frame{

    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor =[UIColor purpleColor];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = tag;
    [button setImage:image forState:UIControlStateNormal];
    
    return button;
}




#pragma mark - 回退
- (void)buttonClicked:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    


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
