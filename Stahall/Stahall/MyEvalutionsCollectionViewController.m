//
//  MyEvalutionsCollectionViewController.m
//  Stahall
//
//  Created by frankfan on 15/1/9.
//  Copyright (c) 2015年 Rching. All rights reserved.
//
//FIXME: 已估价艺人集合视图

#import "MyEvalutionsCollectionViewController.h"
#import <ReactiveCocoa.h>
#import "StahallEvalutionDetailInfoCollectionViewCell.h"

#import "Reachability.h"
#import "NetworkHelper.h"
#import "ProgressHUD.h"
#import "FrankfanApis.h"
#import "UIImageView+WebCache.h"
#import "MyShowDetailsViewController.h"

@interface MyEvalutionsCollectionViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{

    Reachability *_reachability;
    NSMutableArray *selectedEvalutionStars;//存放选中的艺人【字典对象】
    NSMutableArray *selectedCell;//存放选中的cell
}
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *evalutionStars;//根据估价id获取的已估价艺人
@end

@implementation MyEvalutionsCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.contents =(__bridge id)[UIImage imageNamed:@"backgroundImage"].CGImage;
    
    //数据初始化
    _reachability =[Reachability reachabilityWithHostName:@"www.baidu.com"];
    selectedEvalutionStars =[NSMutableArray array];
    selectedCell =[NSMutableArray array];
    
    /*title*/
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 123, 40)];
    title.text = self.showTitle;
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
    [searchButton1 setTitle:@"完成" forState:UIControlStateNormal];
    [searchButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchButton1.rac_command =[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        if(![selectedEvalutionStars count]){
            
            [ProgressHUD showError:@"没有选择艺人"];
        }else{
        
            NSMutableArray *tempArray = [self.theSelectedStars mutableCopy];
            [tempArray removeLastObject];
            if([tempArray count]){
            
                [tempArray enumerateObjectsUsingBlock:^(id obj1, NSUInteger idx, BOOL *stop) {
                    
                    [selectedEvalutionStars enumerateObjectsUsingBlock:^(id obj2, NSUInteger idx, BOOL *stop) {
                        
                        if([obj1 isEqual:obj2]){
                        
                            [selectedEvalutionStars removeObject:obj2];
                        }
                    }];
                }];
            }
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"sendSelectedStars" object:selectedEvalutionStars];

            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        }
        
        return [RACSignal empty];
    }];
    
    UIBarButtonItem *rightitem =[[UIBarButtonItem alloc]initWithCustomView:searchButton1];
    self.navigationItem.rightBarButtonItem = rightitem;

    
    //mainBody
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(60, 60);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    
    self.collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[StahallEvalutionDetailInfoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor =[UIColor clearColor];

    //网络请求
    if(![_reachability isReachable]){
    
        [ProgressHUD showError:@"网络错误"];
        return;
    }
    
    AFHTTPRequestOperationManager *manager =[NetworkHelper createRequestManagerWithContentType:application_json];
    NSDictionary *paramert = @{@"valuationId":self.valutionId};
    [manager GET:API_GetValutionInfoByValutionId parameters:paramert success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *tempDict = responseObject[@"data"];
        self.evalutionStars = tempDict[@"valuationRelevances"];
        [self.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error:%@",[error localizedDescription]);
        [ProgressHUD showError:@"网络错误"];
    }];
    
}

#pragma mark - collectionViewCell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return [self.evalutionStars count];
}

#pragma mark - 创建collectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{


    StahallEvalutionDetailInfoCollectionViewCell *cell = (StahallEvalutionDetailInfoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary *tempDict = self.evalutionStars[indexPath.row];
    [cell.staHeaderImageView sd_setImageWithURL:[NSURL URLWithString:tempDict[@"header"]] placeholderImage:nil];
    cell.starName.text = tempDict[@"artistName"];
   
    cell.topPrice.text = [NSString stringWithFormat:@"%@万",tempDict[@"showRate"]];
    cell.bottomPrice.text =[NSString stringWithFormat:@"%@万",tempDict[@"alternativeRate"]];
    
    cell.topTime.text = tempDict[@"showTime"];
    cell.bottomTime.text = tempDict[@"alternativeTime"];
    return cell;
}

#pragma mark - collectionCell被选中
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    StahallEvalutionDetailInfoCollectionViewCell *cell = (StahallEvalutionDetailInfoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    NSDictionary *tempDict = self.evalutionStars[indexPath.row];
    
    if(![selectedCell containsObject:cell]){
    
        cell.checkIcon.hidden = NO;
        [selectedCell addObject:cell];
        [selectedEvalutionStars addObject:tempDict];
        
        
    }else{
    
        [selectedCell removeObject:cell];
        cell.checkIcon.hidden = YES;
        [selectedEvalutionStars removeObject:tempDict];
    }
    
    
    

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
