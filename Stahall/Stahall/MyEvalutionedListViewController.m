//
//  MyEvalutionedListViewController.m
//  Stahall
//
//  Created by frankfan on 15/1/9.
//  Copyright (c) 2015年 Rching. All rights reserved.
//
//FIXME: 我的估价【已完成列表】

#import "MyEvalutionedListViewController.h"
#import <ReactiveCocoa.h>
#import "StahallValuationViewController.h"
#import "MyEvalutionsCollectionViewController.h"

@interface MyEvalutionedListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@end

@implementation MyEvalutionedListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"backgroundImage"].CGImage;
    
    /*title*/
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    title.text = @"已完成估价";
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
    
    /*去估价*/
    UIButton *searchButton1 =[UIButton buttonWithType:UIButtonTypeCustom];
    searchButton1.tag = 10007;
    searchButton1.frame = CGRectMake(0, 0, 60, 30);
    searchButton1.titleLabel.font =[UIFont systemFontOfSize:14];
    [searchButton1 setTitle:@"去估价" forState:UIControlStateNormal];
    [searchButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchButton1.rac_command =[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
    
        
        StahallValuationViewController *stahallValutionVC =[StahallValuationViewController new];
       [self.navigationController pushViewController:stahallValutionVC animated:YES];
        return [RACSignal empty];
    }];
    
    UIBarButtonItem *rightitem =[[UIBarButtonItem alloc]initWithCustomView:searchButton1];
    self.navigationItem.rightBarButtonItem = rightitem;

    
    
    

    //mainBody
    self.tableView =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor =[UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
   
    self.tableView.separatorStyle = NO;
    
    if(![self.evalutionedStars count]){
    
        [self.evalutionedStars addObject:@"暂无估价完艺人-点击去估价"];
    }

    
    
}


#pragma mark - 分组数目
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

#pragma mark - cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.evalutionedStars count];
}



#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
    
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor =[UIColor clearColor];
        
        //
        UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, cell.bounds.size.height-1, self.view.bounds.size.width, 0.5)];
        line.backgroundColor =[UIColor whiteColor];
        [cell.contentView addSubview:line];
        line.alpha = 0.3;
        
        UILabel *showNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, cell.bounds.size.height)];
        showNameLabel.tag = 1001;
        showNameLabel.textColor =[UIColor whiteColor];
        showNameLabel.font =[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:showNameLabel];
        
        UILabel *showTimeLabel =[[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-100, 0, 100, cell.bounds.size.height)];
        showTimeLabel.tag = 1002;
        showTimeLabel.textColor =[UIColor whiteColor];
        showTimeLabel.font =[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:showTimeLabel];
        
    }
    
    UILabel *showNameLabel = (UILabel *)[cell viewWithTag:1001];
    UILabel *showTimeLabel = (UILabel *)[cell viewWithTag:1002];
   
    NSDictionary *tempDict = self.evalutionedStars[indexPath.row];
    showNameLabel.text = tempDict[@"showName"];
    showTimeLabel.text = tempDict[@"showTime"];
    
    
    NSLog(@"%@",self.evalutionedStars);
    
    
    return cell;

}

#pragma mark - tableViewCell被选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if([[self.evalutionedStars firstObject]isKindOfClass:[NSString class]]){//列表没有估价艺人
    
        StahallValuationViewController *stahallValutionCV =[StahallValuationViewController new];
        [self.navigationController pushViewController:stahallValutionCV animated:YES];
    
    }else{//有估价艺人
    
        MyEvalutionsCollectionViewController *myEvalutionCollcetionCV =[MyEvalutionsCollectionViewController new];
        NSDictionary *tempDict = self.evalutionedStars[indexPath.row];
        myEvalutionCollcetionCV.showTitle = tempDict[@"showName"];
        myEvalutionCollcetionCV.valutionId = tempDict[@"valuationId"];
        myEvalutionCollcetionCV.hasEvalutionedStars = self.evalutionedStars;
        myEvalutionCollcetionCV.theSelectedStars = self.theSelectedStars;
        [self.navigationController pushViewController:myEvalutionCollcetionCV animated:YES];
        
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
