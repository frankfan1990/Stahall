//
//  ShowMallDetailsViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-29.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "ShowMallDetailsViewController.h"
#import "UIImageView+WebCache.h"
#import "BuyMyMallsViewController.h"
#import "AFNetworking.h"
#import "Marcos.h"

#pragma mark -showMall详情
@interface ShowMallDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *arrOfTitle;
    NSMutableArray *arrOfcontent;
    NSDictionary *dictData;
}

@end

@implementation ShowMallDetailsViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self.view setBackgroundColor:[UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1]];
    arrOfTitle = @[@"活动名称:",@"时       间:",@"地       点:",@"场       馆:",@"出场艺人:",@"主办单位:",@"活动介绍",@"艺人简介"];
    arrOfcontent = [NSMutableArray array];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

-(void)getData
{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/plain"]];
    //秀mall数据
    NSDictionary *parameterdic = [NSDictionary dictionaryWithObjectsAndKeys:_mallId,@"mallId",nil];
    [manger GET:MALLDetailIP parameters:parameterdic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dictData = (NSDictionary *)responseObject[@"data"];
        
        [arrOfcontent addObject:dictData[@"mallName"]];
        [arrOfcontent addObject:dictData[@"mallTime"]];
        [arrOfcontent addObject:dictData[@"mallAddress"]];
        [arrOfcontent addObject:dictData[@"mallVenues"]];
        [arrOfcontent addObject:dictData[@"mallArtist"]];
        [arrOfcontent addObject:dictData[@"organizer"]];
        
        [self setTabBar];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
    }];
}


#pragma mark tabBar的设置
-(void)setTabBar{
    

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
    [btnLeft setFrame:CGRectMake(0, 0, 30, 30)];
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

    self.title = @"秀Mall详情";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

//    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
//    title.text = @"秀MALL";
//    title.font = [UIFont systemFontOfSize:19];
//    title.textColor = [UIColor whiteColor];
//    self.navigationItem.titleView = title;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOfTitle.count +1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 160;
    }else if (indexPath.row == arrOfTitle.count-1){
        
        if (dictData[@"mallIntroduction"]) {
            return [self caculateTheTextHeight:dictData[@"mallIntroduction"] andFontSize:13 andDistance:Mywidth-20]+40;
        }else{
            return 40;
        }
    }else if (indexPath.row == arrOfTitle.count){
        
        if (dictData[@"artistIntroduction"]) {
            return [self caculateTheTextHeight:dictData[@"artistIntroduction"] andFontSize:13 andDistance:Mywidth-20]+40;
        }else{
            return 40;
        }
    }else{
        return 50;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor clearColor];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(15, 10, Mywidth-30, 38);
    buyBtn.layer.masksToBounds = YES;
    buyBtn.layer.cornerRadius = 5;
    [buyBtn setTitle:@"我要买" forState:UIControlStateNormal];
    buyBtn.backgroundColor = [UIColor greenColor];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(didBuyBtn) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:buyBtn];
    
    return footView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell0 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 160)];
        [imageV  sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@""]];
        [cell0.contentView addSubview:imageV];
        return cell0;
    }else if (indexPath.row > arrOfTitle.count-2){
        
        static NSString *str = @"mycell1";
        UITableViewCell *cell1 = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:str];
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            cell1.backgroundColor = [UIColor clearColor];
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 15, 15)];
            imageV.backgroundColor = [UIColor whiteColor];
            
            UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(23+7, 8, 200, 15)];
            [self Customlable:labelTitle text:nil fontSzie:13 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
            labelTitle.backgroundColor = [UIColor clearColor];
            labelTitle.tag = 10001;
            
            UILabel *webView = [[UILabel alloc] init];
            webView.backgroundColor = [UIColor clearColor];
            [self Customlable:webView text:@"" fontSzie:13 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:100];
            webView.opaque = NO;
            webView.tag = 10002;
            
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 170)];
            if (indexPath.row%2) {
                 bgView.backgroundColor = [UIColor clearColor];
            }else{
                bgView.backgroundColor = [UIColor blackColor];
                bgView.alpha = 0.03;
               
            }
            [cell1.contentView addSubview:bgView];
            [cell1.contentView addSubview:webView];
            [cell1.contentView addSubview:labelTitle];
            [cell1.contentView addSubview:imageV];

        }
        UILabel *label = (UILabel *)[cell1.contentView viewWithTag:10001];
        label.text = arrOfTitle[indexPath.row-1];
       
        UILabel *weblabel = (UILabel *)[cell1.contentView viewWithTag:10002];
        if (indexPath.row == arrOfTitle.count-1 && dictData[@"mallIntroduction"]) {
             weblabel.frame = CGRectMake(10, 28, Mywidth-20, [self caculateTheTextHeight:dictData[@"mallIntroduction"] andFontSize:13 andDistance:Mywidth-20]);
            weblabel.text = dictData[@"mallIntroduction"];
        }else if(indexPath.row == arrOfTitle.count && dictData[@"artistIntroduction"]){
            weblabel.frame = CGRectMake(10, 28, Mywidth-20, [self caculateTheTextHeight:dictData[@"artistIntroduction"] andFontSize:13 andDistance:Mywidth-20]);
            weblabel.text = dictData[@"artistIntroduction"];
        }
       
        
        return cell1;
    }else{
        static NSString *cellStr = @"mycell2";
        UITableViewCell *cell2 = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell2 == nil) {
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            cell2.backgroundColor = [UIColor clearColor];
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25-2.5, 5, 5)];
            imageV.layer.masksToBounds = YES;
            imageV.layer.cornerRadius = imageV.frame.size.width/2;
            imageV.backgroundColor = [UIColor greenColor];
            
            UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(23+7, 8, 200, 15)];
            [self Customlable:labelTitle text:nil fontSzie:14 textColor:[UIColor yellowColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
            labelTitle.backgroundColor = [UIColor clearColor];
            labelTitle.tag = 10003;
            
            UILabel *labelContent = [[UILabel alloc] initWithFrame:CGRectMake(labelTitle.frame.origin.x, 25, Mywidth-40, 20)];
            [self Customlable:labelContent text:@"" fontSzie:12 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
            labelContent.tag = 10004;
            
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 50)];
            if (indexPath.row%2) {
                bgView.backgroundColor = [UIColor clearColor];
            }else{
                bgView.backgroundColor = [UIColor blackColor];
                bgView.alpha = 0.03;
                
            }
            [cell2.contentView addSubview:bgView];
            [cell2.contentView addSubview:labelContent];
            [cell2.contentView addSubview:imageV];
            [cell2.contentView addSubview:labelTitle];
            
            
        }
        UILabel *label = (UILabel *)[cell2.contentView viewWithTag:10003];
        label.text = arrOfTitle[indexPath.row-1];
        UILabel *label2 = (UILabel *)[cell2.contentView viewWithTag:10004];
        if (arrOfcontent.count != 0) {
            label2.text = arrOfcontent[indexPath.row-1];
        }
        return cell2;
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIlabel的方法
-(void)Customlable:(UILabel *)label text:(NSString *)textStr fontSzie:(CGFloat)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment adjustsFontSizeToFitWidth:(BOOL)state numberOfLines:(NSInteger)numberOfLines
{
    label.text = textStr;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.adjustsFontSizeToFitWidth = state;
    label.numberOfLines = numberOfLines;
}

#pragma mark - 点击 我要买
-(void)didBuyBtn
{
    BuyMyMallsViewController *buyCtrl = [[BuyMyMallsViewController alloc] init];
    [self.navigationController pushViewController:buyCtrl animated:YES];
    NSLog(@"我要买");
}

-(void)didGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 根据字长算 高度或宽度
- (CGFloat)caculateTheTextHeight:(NSString *)string andFontSize:(int)fontSize andDistance:(CGFloat)distance{
    
    /*非彻底性封装*/
    CGSize constraint = CGSizeMake(distance, CGFLOAT_MAX);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:string
     attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    return size.height;
}

@end
