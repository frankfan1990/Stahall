//
//  StahallEvalutionDetailInfoViewController.m
//  Stahall
//
//  Created by frankfan on 14/12/25.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "StahallEvalutionDetailInfoViewController.h"
#import "StahallEvalutionDetailInfoCollectionViewCell.h"

int justTestDataSource = 13;
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
    
    /*回退*/
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.tag = 10006;
    backButton.frame = CGRectMake(0, 0, 30, 30);
    [backButton setImage:[UIImage imageNamed:@"朝左箭头icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftitem =[[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftitem;
 
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
    concertLabel.text = @"许巍演唱会";
    
    //地点
    concertAddressLabel =[self createLabelWithFrame:CGRectMake(self.view.bounds.size.width/2.0+30, 20, self.view.bounds.size.width/2.0-10-15, 35)];
    concertAddressLabel.text = @"湖南长沙";
    
    //第一时间
    firstTimeLabel =[self createLabelWithFrame:CGRectMake(10, 20+35+20, self.view.bounds.size.width/2.0-10-15, 35)];
    firstTimeLabel.text = @"2015-3-4";
    
    //第二时间
    secondeTimeLabel =[self createLabelWithFrame:CGRectMake(self.view.bounds.size.width/2.0+30, 20+35+20,self.view.bounds.size.width/2.0-10-15, 35)];
    secondeTimeLabel.text = @"2015-6-14";

    
    //机场
    airplaneLabel =[self createLabelWithFrame:CGRectMake(10, 20+35+20+35+20, self.view.bounds.size.width/2.0-10-15, 35)];
    airplaneLabel.text = @"黄花机场";
    
    
    //场馆
    plcaeLabel =[self createLabelWithFrame:CGRectMake(self.view.bounds.size.width/2.0+30, 20+35+20+35+20, self.view.bounds.size.width/2.0-10-15, 35)];
    
    plcaeLabel.text = @"湖南大剧院";
    
    
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
    [self.view addSubview:speedButton];
    
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

    return justTestDataSource;
}

#pragma mark - 创建collectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    StahallEvalutionDetailInfoCollectionViewCell *cell =(StahallEvalutionDetailInfoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];

    cell.starName.text = @"刘德华";
    cell.topPrice.text = @"30万";
    cell.topTime.text = @"2015-3-22";
    cell.bottomPrice.text = @"88万";
    cell.bottomTime.text = @"2015-5-21";
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
