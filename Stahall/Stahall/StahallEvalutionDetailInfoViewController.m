//
//  StahallEvalutionDetailInfoViewController.m
//  Stahall
//
//  Created by frankfan on 14/12/25.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "StahallEvalutionDetailInfoViewController.h"
#import "StahallEvalutionDetailInfoCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"
#import "NetworkHelper.h"
#import "StarModel.h"
#import "FrankfanApis.h"
#import "ProgressHUD.h"
#import <ReactiveCocoa/ReactiveCocoa.h>


NSInteger justTestDataSource = 13;
static NSInteger stepHour = 1;
@interface StahallEvalutionDetailInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{

    UILabel *concertLabel;
    UILabel *concertAddressLabel;
    UILabel *firstTimeLabel;
    UILabel *secondeTimeLabel;
    UILabel *airplaneLabel;
    UILabel *plcaeLabel;
    
    //
    UILabel *hourLable;//加急时间Label
    CGFloat collectionViewHeight;//控制collectionView的高度
    
    //
    Reachability *_reachability;
    BOOL isAddSpeeded;
    
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation StahallEvalutionDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:76/255.0 green:60/255.0 blue:136/255.0 alpha:1]];
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"backgroundImage"].CGImage;
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    title.text = @"堂估价详情";
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
  
    //初始化数据
    justTestDataSource = [self.starsList count];
    _reachability =[Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    
    /*回退*/
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.tag = 10006;
    backButton.frame = CGRectMake(0, 0, 30, 30);
    [backButton setImage:[UIImage imageNamed:@"朝左箭头icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftitem =[[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftitem;
    //左滑手势返回上级
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    //
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-150) style:UITableViewStylePlain];
    
    self.tableView.separatorStyle = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor =[UIColor clearColor];
    self.tableView.allowsSelection = NO;
    [self.view addSubview:self.tableView];
    
    CGRect rect = CGRectZero;
    UIView *footerView = [[UIView alloc]initWithFrame:rect];
    self.tableView.tableFooterView = footerView;
    
    
    //演唱会
    concertLabel =[self createLabelWithFrame:CGRectMake(10, 20, self.view.bounds.size.width/2.0-10-15, 35)];
    concertLabel.text = self.showName;
    
    //地点
    concertAddressLabel =[self createLabelWithFrame:CGRectMake(self.view.bounds.size.width/2.0+30, 20, self.view.bounds.size.width/2.0-10-15, 35)];
    concertAddressLabel.text = self.showAddress;
    
    //第一时间
    firstTimeLabel =[self createLabelWithFrame:CGRectMake(10, 20+35+20, self.view.bounds.size.width/2.0-10-15, 35)];
    firstTimeLabel.text = self.showTime;
    
    //第二时间
    secondeTimeLabel =[self createLabelWithFrame:CGRectMake(self.view.bounds.size.width/2.0+30, 20+35+20,self.view.bounds.size.width/2.0-10-15, 35)];
    
    secondeTimeLabel.text = self.showAnotherTime;

    
    //机场
    airplaneLabel =[self createLabelWithFrame:CGRectMake(10, 20+35+20+35+20, self.view.bounds.size.width/2.0-10-15, 35)];
    airplaneLabel.text = self.airPlane;
    
    
    //场馆
    plcaeLabel =[self createLabelWithFrame:CGRectMake(self.view.bounds.size.width/2.0+30, 20+35+20+35+20, self.view.bounds.size.width/2.0-10-15, 35)];
    
    plcaeLabel.text = self.showPlace;
   
    
    
    //创建collectionView
    UICollectionViewFlowLayout *flowlayout =[[UICollectionViewFlowLayout alloc]init];
    flowlayout.itemSize = CGSizeMake(67, 140);
    flowlayout.sectionInset = UIEdgeInsetsMake(20, 10, 10, 10);
    
    flowlayout.minimumLineSpacing = 30;
    flowlayout.minimumInteritemSpacing =0;
    
    self.collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.tableView.bounds.size.height-170) collectionViewLayout:flowlayout];
    
    [self.collectionView registerClass:[StahallEvalutionDetailInfoCollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor =[UIColor clearColor];
    self.collectionView.scrollEnabled = NO;
    
    
    //
    UIButton *subButton = [UIButton buttonWithType:UIButtonTypeCustom];
    subButton.frame = CGRectMake(10, self.view.bounds.size.height-150+15, 30, 20);
    [subButton setTitle:@"—" forState:UIControlStateNormal];
    [subButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    subButton.backgroundColor = [UIColor magentaColor];
    subButton.tag = 8000;
    [subButton addTarget:self action:@selector(stepButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //
    UIButton *addButton =[UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(10+30+35, self.view.bounds.size.height-150+15, 35, 20);
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    addButton.backgroundColor = [UIColor magentaColor];
    addButton.tag = 8001;
    [addButton addTarget:self action:@selector(stepButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //
    hourLable =[[UILabel alloc]initWithFrame:CGRectMake(10+30, self.view.bounds.size.height-150+15, 35, 20)];
    hourLable.font =[UIFont systemFontOfSize:14];
    hourLable.textColor =[UIColor whiteColor];
    hourLable.backgroundColor =[UIColor clearColor];
    hourLable.text = [NSString stringWithFormat:@"%ldh",(long)stepHour];
    hourLable.textAlignment = NSTextAlignmentCenter;
    
  
    //加急
    UIButton *speedButton =[UIButton buttonWithType:UIButtonTypeCustom];
    speedButton.frame = CGRectMake(10+30+35+35+100, self.view.bounds.size.height-150+15, 100, 20);
    [speedButton setTitle:@"加急" forState:UIControlStateNormal];
    speedButton.layer.cornerRadius = 10;
    speedButton.titleLabel.font = [UIFont systemFontOfSize:14];
    speedButton.backgroundColor =[UIColor orangeColor];
    [speedButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [speedButton addTarget:self action:@selector(addSpeedButtonClicked) forControlEvents:UIControlEventTouchUpInside];
 
    
    if(self.isCouldSpeedModle){
        
        [self.view addSubview:subButton];
        [self.view addSubview:addButton];
        [self.view addSubview:hourLable];
        [self.view addSubview:speedButton];
        
    }
    
    //新建演出邀约
    UIButton *builtShowButton =[UIButton buttonWithType:UIButtonTypeCustom];
    builtShowButton.frame = CGRectMake(50, self.view.bounds.size.height-150+15+40, self.view.bounds.size.width-100, 25);
    builtShowButton.layer.masksToBounds = YES;
    builtShowButton.backgroundColor =[UIColor clearColor];
    builtShowButton.layer.cornerRadius = 12;
    builtShowButton.titleLabel.font =[UIFont systemFontOfSize:14];
    builtShowButton.layer.borderWidth = 1;
    builtShowButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [builtShowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [builtShowButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [builtShowButton setTitle:@"新建演出邀约" forState:UIControlStateNormal];
    

    
    if(!self.isCouldSpeedModle){
    
        [self.view addSubview:builtShowButton];
    }
    
#pragma mark - 网络请求
    //开始网络请求
    if(!self.isFirstPort){//如果不是第一个入口进来的，则进行网络请求
    
        if(![_reachability isReachable]){
        
            [ProgressHUD showError:@"网络错误"];
            return;
        }
        
        AFHTTPRequestOperationManager *manager =[NetworkHelper createRequestManagerWithContentType:application_json];
        NSDictionary *parameter = @{@"valuationId":self.valuationId};
        
        [ProgressHUD show:nil];
        [manager GET:API_GetValutionInfoByValutionId parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            NSDictionary *dataDict = responseObject[@"data"];
            self.starsList = dataDict[@"valuationRelevances"];
            justTestDataSource = [self.starsList count];
            
            if([dataDict[@"urgent"]integerValue]){//已加急
            
                [speedButton setTitle:@"已加急" forState:UIControlStateNormal];
                speedButton.enabled = NO;
            }
            
            
            [self.collectionView reloadData];
            [self.tableView reloadData];
            
            NSLog(@"responseObjc:%@",responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"error:%@",[error localizedDescription]);
            [ProgressHUD showError:@"网络错误"];
            
            [ProgressHUD dismiss];
            
        }];
        
    }
    
    
    
}


#pragma mark - 加急按钮触发
- (void)addSpeedButtonClicked{

    if(isAddSpeeded){
    
        [ProgressHUD showError:@"请勿重复提交"];
        return;
    }
    
    
    if(![_reachability isReachable]){
    
        [ProgressHUD showError:@"网络错误"];
        return;
    }
    
    
    if(![self.starsList count]){
        
        [ProgressHUD show:@"数据错误"];
        return;
    }
    
    
    AFHTTPRequestOperationManager *manager =[NetworkHelper createRequestManagerWithContentType:application_json];
    NSDictionary *parameters = @{@"valuationId":self.valuationId,
                                 @"urgent":[NSNumber numberWithInteger:[hourLable.text integerValue]]};
    
    [ProgressHUD show:nil];
    [manager POST:API_AddSpeedEvalution parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"response:%@",responseObject);
        isAddSpeeded = YES;
        [ProgressHUD showSuccess:@"加急成功"];
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error:%@",[error localizedDescription]);
        [ProgressHUD showError:@"网络错误"];
    }];
    
    
    
    NSLog(@"加急按钮触发");
}



#pragma mark - 创建label
- (UILabel *)createLabelWithFrame:(CGRect)frame{

    UILabel *label =[[UILabel alloc]initWithFrame:frame];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    
    return label;
}

#pragma mark - stepButton触发
- (void)stepButtonClicked:(UIButton *)sender{

    if(sender.tag==8000){//减
    
        if(![hourLable.text isEqualToString:@"1h"]){
        
            stepHour--;
            hourLable.text = [NSString stringWithFormat:@"%ldh",(long)stepHour];
        }
        
    }else if(![hourLable.text isEqualToString:@"12h"]){//加
        
        stepHour++;
        hourLable.text = [NSString stringWithFormat:@"%ldh",(long)stepHour];
    
    }

}




#pragma mark - collectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return [self.starsList count];
 
}

#pragma mark - 创建collectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    StahallEvalutionDetailInfoCollectionViewCell *cell =(StahallEvalutionDetailInfoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];

    if(self.isFirstPort){
    
        StarModel *starModel =[StarModel modelWithDictionary:self.starsList[indexPath.row] error:nil];
        [cell.staHeaderImageView sd_setImageWithURL:[NSURL URLWithString:starModel.header] placeholderImage:nil];
        cell.starName.text = starModel.artistName;
        cell.topPrice.text = @"?万";
        cell.bottomPrice.text = @"?万";

    }else{
    
        NSDictionary *tempDict = self.starsList[indexPath.row];
        [cell.staHeaderImageView sd_setImageWithURL:[NSURL URLWithString:tempDict[@"header"]] placeholderImage:nil];
        
        //演出时间
        if([tempDict[@"showRate"]integerValue]==0){//估价价格未出
        
            cell.topPrice.text = @"?万";
        }else{//已出
        
            cell.topPrice.text = [NSString stringWithFormat:@"%@万",tempDict[@"showRate"]];
        }
        
        //备选时间
        if([tempDict[@"alternativeRate"]integerValue]==0){
        
            cell.bottomPrice.text = @"?万";
        }else{
        
            cell.bottomPrice.text = [NSString stringWithFormat:@"%@万",tempDict[@"alternativeRate"]];
        }
        
        cell.starName.text = tempDict[@"artistName"];
        
    }
    
    cell.topTime.text = self.showTime;
    cell.bottomTime.text = self.showAnotherTime;

    return cell;
}





#pragma mark - cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.row==0){
    
            return 170;

    }else{
    
        if(justTestDataSource%4==0){
            
            self.collectionView.frame = CGRectMake(0, 0, self.view.bounds.size.width, (justTestDataSource/4)*170+30);
            return (justTestDataSource/4)*170+30;
            
        }else if (justTestDataSource%4<4){
            
            self.collectionView.frame = CGRectMake(0, 0, self.view.bounds.size.width, (justTestDataSource/4+1)*170+30);
            return (justTestDataSource/4+1)*170+30;
            
        }
        

    }
    
    return 0;
}


#pragma mark - 创建tableViewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    UITableViewCell *cell0 = nil;
    
    
    UITableViewCell *cell1 = nil;
    
    
    cell0 =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell0.backgroundColor =[UIColor clearColor];
    cell1 =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell1.backgroundColor =[UIColor clearColor];

    if(indexPath.row==0){
    
        
        [cell0.contentView addSubview:concertLabel];
        [cell0.contentView addSubview:concertAddressLabel];
        [cell0.contentView addSubview:firstTimeLabel];
        [cell0.contentView addSubview:secondeTimeLabel];
        [cell0.contentView addSubview:airplaneLabel];
        [cell0.contentView addSubview:plcaeLabel];
        
        return cell0;
    }else{
    
        [cell1.contentView addSubview:self.collectionView];
        return cell1;
    }

}




#pragma mark - 导航栏按钮触发
- (void)buttonClicked:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];

}



#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0/255.0 green:180/255.0 blue:204/255.0 alpha:1]];

}


- (void)viewWillDisappear:(BOOL)animated{

#warning 这个逻辑有待商榷
    //!!!: 这个逻辑有待商榷
    [[NSNotificationCenter defaultCenter]postNotificationName:@"clearAllData" object:nil];
    [ProgressHUD dismiss];
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
