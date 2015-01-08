//
//  CaseDetailsViewController.m
//  Stahall
//
//  Created by JM_Pro on 15-1-7.
//  Copyright (c) 2015年 Rching. All rights reserved.
//

#import "CaseDetailsViewController.h"
#import "AFNetworking.h"
#import "CycleScrollView.h"
#import "UIImageView+WebCache.h"
#import "CasePlayVideoViewController.h"
#import "Marcos.h"
@interface CaseDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    CycleScrollView *headScrollView;
    UITableView *_tableView;
    UIButton *btnDetails;
    UIButton *btnPicture;
    UIButton *btnVideo;
    
    
    NSMutableArray *pictureData;//图集数据
    NSMutableArray *starsData;//捧场明星数据
    NSMutableArray *videosData;//视频信息
    
    NSString *introduce;
}
@end

@implementation CaseDetailsViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self getdata];
    
    headScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 150) animationDuration:3 andShowControlDot:YES];
    headScrollView.scrollView.scrollEnabled = YES;
    headScrollView.userInteractionEnabled = YES;
    
//    NSArray *arrData = @[@"七夕",@"lc张学友",@"陈奕迅"];
    
    btnDetails = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDetails.frame = CGRectMake(0, headScrollView.frame.size.height, Mywidth/3, 45);
    [btnDetails setTitle:@"详情" forState:UIControlStateNormal];
    btnDetails.titleLabel.font =[UIFont systemFontOfSize:15];
    [btnDetails setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnDetails setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    btnPicture = [UIButton buttonWithType:UIButtonTypeCustom];
    btnPicture.frame = CGRectMake(Mywidth/3, headScrollView.frame.size.height, Mywidth/3, 45);
    [btnPicture setTitle:@"图集" forState:UIControlStateNormal];
    btnPicture.titleLabel.font =[UIFont systemFontOfSize:15];
    [btnPicture setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnPicture setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    btnVideo = [UIButton buttonWithType:UIButtonTypeCustom];
    btnVideo.frame = CGRectMake(Mywidth/3*2, headScrollView.frame.size.height, Mywidth/3, 45);
    [btnVideo setTitle:@"视频" forState:UIControlStateNormal];
    btnVideo.titleLabel.font =[UIFont systemFontOfSize:15];
    [btnVideo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnVideo setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    btnDetails.selected = YES;
    btnPicture.selected = NO;
    btnVideo.selected = NO;
    btnDetails.backgroundColor = [UIColor colorWithRed:114/255.0 green:190/255.0 blue:222/255.0 alpha:1];
    btnPicture.backgroundColor = [UIColor whiteColor];
    btnVideo.backgroundColor = [UIColor whiteColor];
    
    [btnDetails addTarget:self action:@selector(didMyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btnPicture addTarget:self action:@selector(didMyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btnVideo addTarget:self action:@selector(didMyBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight-64) style:UITableViewStyleGrouped];
    _tableView.sectionFooterHeight = 0.01;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [self.view addSubview:_tableView];
    
}
-(void)setTabBar
{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:114/255.0 green:190/255.0 blue:222/255.0 alpha:1]];
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLeft.layer.masksToBounds = YES;
    btnLeft.layer.cornerRadius = 20;
    [btnLeft setFrame:CGRectMake(0, 0, 35, 35)];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateHighlighted];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(didGoBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
    }
    
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    title.text = _caseName;
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}

-(void)getdata
{
    
    pictureData = [NSMutableArray array];
    
//    __weak typeof (self)Myself = self;
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/plain",@"text/html"]];
    NSDictionary *dic = @{@"caseId":_caseId};
    [manger GET:CaseDetailIP parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *data = (NSDictionary *)responseObject;
        introduce = data[@"data"][@"introduction"];
        starsData = data[@"data"][@"stars"];
        videosData = data[@"data"][@"videos"];
        
        
        //存放轮播图数据的数组
        NSMutableArray *lunboData = [NSMutableArray array];
        for (NSDictionary *dd in data[@"data"][@"atlas"]) {
            if ([dd[@"carousel"] intValue] == 0) {
                [pictureData addObject:dd];
            }else if ([dd[@"carousel"] intValue] == 1){
                [lunboData addObject:dd];
            }
        }
        
        
        
        __weak typeof (self)Myself = self;
        headScrollView.totalPagesCount = ^NSInteger(void){
            return lunboData.count;
        };
        
        headScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Myself.view.frame.size.width, 150)];
            [imageV sd_setImageWithURL:[NSURL URLWithString:lunboData[pageIndex][@"filePath"]] placeholderImage:[UIImage imageNamed:@""]];
            
            return imageV;
        };
        
#pragma mark - 点击轮播图
        headScrollView.TapActionBlock = ^(NSInteger pageIndex){
            
            NSLog(@"%ld",(long)pageIndex);
            
        };
        
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}



#pragma mark - tableVIew的代理 - 有几组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (btnDetails.selected) {
        return 3;
    }else{
        return 2;
    }
}
#pragma mark - tableVIew的代理 - 每组的cell个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 1;
}
#pragma mark - tableVIew的代理 - 底部高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
#pragma mark - tableVIew的代理 - 头部的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 195;
    }
    if (btnDetails.selected) {
        return 40;
    }else{
        return 0.01;
    }
}
#pragma mark - tableVIew的代理 - cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 0.01;
    }
    
    if (btnDetails.selected) {
        if (indexPath.section == 1) {
            return Mywidth/4+20;
        }else{
            return 200;
        }
    }else{
        return Myheight-195;
    }
}
#pragma mark - tableVIew的代理 - 头部视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 195)];
        [headView addSubview:headScrollView];
        [headView addSubview:btnDetails];
        [headView addSubview:btnPicture];
        [headView addSubview:btnVideo];
        return headView;
    }
    
    if (btnDetails.selected) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 45)];
        headView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        imageV.backgroundColor = [UIColor orangeColor];
        [headView addSubview:imageV];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 60, 20)];
        if (section == 1) {
            label.text = @"捧场明星";
        }else{
            label.text = @"演出简介";
        }
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        [headView addSubview:label];
        
        UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(103, 10, 20, 20)];
        imageV2.backgroundColor = [UIColor orangeColor];
        [headView addSubview:imageV2];
        
        return headView;
    }else{
        return nil;
    }
    
}
#pragma mark - tableVIew的代理 - cell样子
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (btnDetails.selected) {
        if (indexPath.section == 1) {
            UITableViewCell *cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell1.backgroundColor = [UIColor clearColor];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            UICollectionViewFlowLayout *layoutViwe = [[UICollectionViewFlowLayout alloc] init];
            layoutViwe.itemSize = CGSizeMake(Mywidth/4, Mywidth/4+20);
            layoutViwe.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layoutViwe.sectionInset = UIEdgeInsetsMake(0, 10, 0, 0);
            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Mywidth/4+20) collectionViewLayout:layoutViwe];
            collectionView.backgroundColor = [UIColor clearColor];
            [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"My_collectionViewCell_One"];
            collectionView.delegate = self;
            collectionView.dataSource = self;
            collectionView.tag = 10001;
            
            [cell1.contentView addSubview:collectionView];
            return cell1;
        }else{
            UITableViewCell *cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell2.backgroundColor = [UIColor clearColor];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 10, Mywidth-20, 180)];
            webView.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
            [webView loadHTMLString:introduce baseURL:nil];
            webView.opaque = NO;
            [cell2.contentView addSubview:webView];
            return cell2;
        }
    }else if(btnPicture.selected){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UICollectionViewFlowLayout *layoutViwe = [[UICollectionViewFlowLayout alloc] init];
        layoutViwe.itemSize = CGSizeMake(Mywidth/3-10, Mywidth/3-20);
        layoutViwe.scrollDirection = UICollectionViewScrollDirectionVertical;
        layoutViwe.sectionInset = UIEdgeInsetsMake(10, 0, 10, 10);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight-195) collectionViewLayout:layoutViwe];
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"My_collectionViewCell_Two"];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.tag = 10002;
        
        [cell.contentView addSubview:collectionView];
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        UICollectionViewFlowLayout *layoutViwe = [[UICollectionViewFlowLayout alloc] init];
        layoutViwe.itemSize = CGSizeMake(Mywidth/2-10, Mywidth/2-20);
        layoutViwe.sectionInset = UIEdgeInsetsMake(15, 0, 0, 10);
        layoutViwe.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight-195) collectionViewLayout:layoutViwe];
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"My_collectionViewCell_There"];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.tag = 10003;
        [cell.contentView addSubview:collectionView];
        return cell;
    }
   
}

#pragma mark - collecView的代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 10001) {
        return starsData.count;
    }else if (collectionView.tag == 10002){
        return pictureData.count;
    }else if(collectionView.tag == 10003){
        return videosData.count;
    }
    return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView.tag == 10001) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"My_collectionViewCell_One" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, Mywidth/4-15, Mywidth/4-15)];
        [imageV sd_setImageWithURL:[NSURL URLWithString:starsData[indexPath.row][@"avatar"]] placeholderImage:[UIImage imageNamed:@"lc汪峰头像"]];
        imageV.layer.masksToBounds = YES;
        imageV.layer.cornerRadius = imageV.frame.size.height/2;
        [cell addSubview:imageV];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageV.frame.origin.x, imageV.frame.size.height+imageV.frame.origin.y,imageV.frame.size.width,20)];
        label.text = starsData[indexPath.row][@"starName"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor blackColor];
        [cell addSubview:label];
        return cell;
    }else if (collectionView.tag == 10002){
        
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"My_collectionViewCell_Two" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, Mywidth/3-15, Mywidth/3-20)];
        [imageV sd_setImageWithURL:[NSURL URLWithString:pictureData[indexPath.row][@"filePath"]] placeholderImage:[UIImage imageNamed:@"lc刘德华"]];
        [cell addSubview:imageV];
        return cell;
    }else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"My_collectionViewCell_There" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, Mywidth/2-15, Mywidth/2-30)];
        [imageV sd_setImageWithURL:[NSURL URLWithString:videosData[indexPath.row][@"thumbnails"]] placeholderImage:[UIImage imageNamed:@"lc范冰冰"]];
        [cell addSubview:imageV];
        
        UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        imageV2.center = imageV.center;
        imageV2.backgroundColor = [UIColor whiteColor];
        imageV2.layer.masksToBounds = YES;
        imageV2.layer.cornerRadius = 35/2;
        [cell addSubview:imageV2];
        return cell;
    }
    

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 10003) {
        CasePlayVideoViewController *palyCtrl = [[CasePlayVideoViewController alloc] init];
        palyCtrl.dataDict = videosData[indexPath.row];
        [self  presentViewController:palyCtrl animated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)didGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 第几三个按钮事件
-(void)didMyBtn:(UIButton *)sender
{
    btnVideo.selected = NO;
    btnPicture.selected = NO;
    btnDetails.selected = NO;
    sender.selected = YES;
    
    btnDetails.backgroundColor = [UIColor whiteColor];
    btnPicture.backgroundColor = [UIColor whiteColor];
    btnVideo.backgroundColor = [UIColor whiteColor];
    sender.backgroundColor = [UIColor colorWithRed:114/255.0 green:190/255.0 blue:222/255.0 alpha:1];
    [_tableView reloadData];
}

@end
