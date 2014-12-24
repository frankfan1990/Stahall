//
//  AdvanceNoticeViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-15.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "AdvanceNoticeViewController.h"
#import "MarkupParser.h"
#import "CycleScrollView.h"
#import "CustomLabel.h"
#import "Marcos.h"

#pragma mark - 预告 案例 行程 详情
@interface AdvanceNoticeViewController()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UITableView *_tableView;
    UICollectionView *_collectionView;
    CycleScrollView *cycSroView;
}
@end
@implementation AdvanceNoticeViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setTabBar];
    [self.view setBackgroundColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,Mywidth, Myheight -64) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
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
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0/255.0 green:180/255.0 blue:204/255.0 alpha:1]];
    
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
    title.text = _titleViewStr;
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}

#pragma mark - tableView的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 ) {
        return 220;
    }else if (indexPath.row == 1){
        return 150;
    }else{
        return 300;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell1 = nil;
    UITableViewCell *cell2 = nil;
    UITableViewCell *cell3 = nil;
    
    if (indexPath.row == 0) {
        cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell1.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(15, 18, 130, 175)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.shadowColor = [UIColor blackColor].CGColor;
        backView.layer.shadowOffset = CGSizeMake(-7, -2);
        backView.layer.shadowOpacity = 0.4;
        [cell1.contentView addSubview:backView];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(8, 7, 130-16, 175-14)];
        imageV.image = [UIImage imageNamed:@"汪峰"];
        [backView addSubview:imageV];
        
        NSString *title = @"汪峰2014-2015 “峰暴来临” 超级巡回演唱会 湖南 长沙站 贺龙体育馆";
        CGFloat height = [self caculateTheTextHeight:title andFontSize:16 andDistance:Mywidth-(backView.frame.origin.x+backView.frame.size.width+25)];
        if (height>80) {
            height = 80;
        }
        
        UILabel *labelOfTitle = [[UILabel alloc] initWithFrame:CGRectMake(backView.frame.origin.x+backView.frame.size.width+15, backView.frame.origin.y-1, Mywidth-(backView.frame.origin.x+backView.frame.size.width+25), height)];
        [self Customlable:labelOfTitle text:title fontSzie:16 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:5];
        [cell1.contentView addSubview:labelOfTitle];
        
        NSString *timeStr = [NSString stringWithFormat:@"<font color=\"gray\">时间:  <font color=\"black\">2014-11-15 08:30"];
        CustomLabel *labelOfTime = [[CustomLabel alloc] initWithFrame:CGRectMake(backView.frame.origin.x+backView.frame.size.width+15, 118, Mywidth-(backView.frame.origin.x+backView.frame.size.width+25), 20)];
        MarkupParser *p1 = [[MarkupParser alloc] init];
        p1.fontSize = 13;
        [labelOfTime setAttString:[p1 attrStringFromMarkup:timeStr]];
        [cell1.contentView addSubview:labelOfTime];
        
        NSString *addressStr = [NSString stringWithFormat:@"<font color=\"gray\">地点:  <font color=\"black\">湖南 长沙"];
        CustomLabel *labelOfaddress = [[CustomLabel alloc] initWithFrame:CGRectMake(backView.frame.origin.x+backView.frame.size.width+15, labelOfTime.frame.origin.y+labelOfTime.frame.size.height, Mywidth-(backView.frame.origin.x+backView.frame.size.width+25), 20)];
        [labelOfaddress setAttString:[p1 attrStringFromMarkup:addressStr]];
        [cell1.contentView addSubview:labelOfaddress];
        
        NSString *venuesStr = [NSString stringWithFormat:@"<font color=\"gray\">场馆:  <font color=\"black\">贺龙体育馆"];
        CustomLabel *labelOfVenues = [[CustomLabel alloc] initWithFrame:CGRectMake(backView.frame.origin.x+backView.frame.size.width+15, labelOfaddress.frame.origin.y+labelOfaddress.frame.size.height, Mywidth-(backView.frame.origin.x+backView.frame.size.width+25), 20)];
        [labelOfVenues setAttString:[p1 attrStringFromMarkup:venuesStr]];
        [cell1.contentView addSubview:labelOfVenues];
        
        NSString *hostStr = [NSString stringWithFormat:@"<font color=\"gray\">主办:  <font color=\"black\">艺人堂文化传媒"];
        int a = 20;
        NSString *str = @"主办:  艺人堂文化传媒";
        if ([str length] >=15) {
            p1.fontSize = 12;
            a = 30;
        }
        CustomLabel *labelOfHost = [[CustomLabel alloc] initWithFrame:CGRectMake(backView.frame.origin.x+backView.frame.size.width+15, labelOfVenues.frame.origin.y+labelOfVenues.frame.size.height, Mywidth-(backView.frame.origin.x+backView.frame.size.width+20), a)];
        labelOfHost.numberOfLines = 2;
        [labelOfHost setAttString:[p1 attrStringFromMarkup:hostStr]];
        [cell1.contentView addSubview:labelOfHost];
        
        return cell1;
        
    }
    else if (indexPath.row ==1){
         cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
         cell2.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
         cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, Mywidth-20, 140)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.masksToBounds = YES;
        backView.layer.cornerRadius = 6;
        backView.layer.borderWidth =0.5;
        backView.layer.borderColor = [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1].CGColor;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40-0.5, Mywidth-20, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        [backView addSubview:lineView];
        
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 20, 20)];
        imageV.backgroundColor = [UIColor orangeColor];
        imageV.layer.masksToBounds = YES;
        imageV.layer.cornerRadius = 10;
        [backView addSubview:imageV];
        
        UILabel *labelOftitle = [[UILabel alloc] initWithFrame:CGRectMake(imageV.frame.origin.x+imageV.frame.size.width+5, 2, 200, 40)];
        [self Customlable:labelOftitle text:@"演出明星" fontSzie:17 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
        [backView addSubview:labelOftitle];
        [cell2.contentView addSubview:backView];
        
        cycSroView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 40, Mywidth-20, 100) animationDuration:3 andShowControlDot:NO];
        cycSroView.backgroundColor = [UIColor whiteColor];
         __weak typeof (self)Myself = self;
        cycSroView.totalPagesCount = ^NSInteger(void){
            return 5;
        };
        cycSroView.fetchContentViewAtIndex = ^UIView*(NSInteger pageIndex){
            
            UIView *viewBackOther = [[UIView alloc] initWithFrame:CGRectMake(0, 40, Myself.view.frame.size.width-20, 100)];
            viewBackOther.backgroundColor = [UIColor whiteColor];
            
            UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:CGRectMake(13, 15, 65, 65)];
            imageV2.image = [UIImage imageNamed:@"lc汪峰头像"];
            imageV2.layer.masksToBounds = YES;
            imageV2.layer.cornerRadius = imageV2.frame.size.width/2;
            [viewBackOther addSubview:imageV2];
            
            
            UILabel *labelContent = [[UILabel alloc] initWithFrame:CGRectMake(imageV2.frame.size.width+imageV2.frame.origin.x+22, 10, Myself.view.frame.size.width-(imageV2.frame.size.width+imageV2.frame.origin.x+22+40), 80)];
            [Myself Customlable:labelContent text:@"汪峰,祖籍江苏常熟,1971年6月29日出生于北京。中国大陆摇滚歌手、音乐创作人、作词人、作曲家,鲍家街43号乐队队长 很厉害很厉害很厉害" fontSzie:15 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:10];
            [viewBackOther addSubview:labelContent];
            return viewBackOther;

        };
        
        [backView addSubview:cycSroView];
        
        UIImageView *imageV3 = [[UIImageView alloc] initWithFrame:CGRectMake(Mywidth-20-20, 80, 20, 20)];
        imageV3.image = [UIImage imageNamed:@"lc向右灰"];
        [backView addSubview:imageV3];
         return cell2;
    }
    else{
        
         cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
         cell3.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
         cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, Mywidth-20, 280)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.masksToBounds = YES;
        backView.layer.cornerRadius = 6;
        backView.layer.borderWidth =0.5;
        backView.layer.borderColor = [UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1].CGColor;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, Mywidth-20, 0.5)];
        lineView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        [backView addSubview:lineView];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 20, 20)];
        imageV.backgroundColor = [UIColor greenColor];
        imageV.layer.masksToBounds = YES;
        imageV.layer.cornerRadius = 10;
        [backView addSubview:imageV];
        UILabel *labelOftitle = [[UILabel alloc] initWithFrame:CGRectMake(imageV.frame.origin.x+imageV.frame.size.width+5, 2, 200, 40)];
        [self Customlable:labelOftitle text:@"演出介绍" fontSzie:17 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
        [backView addSubview:labelOftitle];
        
        
        UICollectionViewFlowLayout *layoutView = [[UICollectionViewFlowLayout alloc] init];
        layoutView.itemSize = CGSizeMake(80, 80);
        layoutView.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        [layoutView setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        _collectionView= [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40+10, Mywidth, 80) collectionViewLayout:layoutView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"My_collectionViewCell"];
        [backView addSubview:_collectionView];
        
        UILabel *labelContent = [[UILabel alloc] initWithFrame:CGRectMake(10, _collectionView.frame.origin.y+_collectionView.frame.size.height+10, Mywidth-40, 280-(_collectionView.frame.origin.y+_collectionView.frame.size.height+25))];
        [self Customlable:labelContent text:@"汪峰自幼在中央音乐学院附小、附中学习小提琴，大学考入中央音乐学院小提琴中提琴专业，大学期间在专业音乐学习和训练之余就开始进行摇滚乐创作并组建乐队。完成本科学业后，进入中央芭蕾舞团任副首席小提琴师，后辞职后转型为职业歌手。" fontSzie:15 textColor:[UIColor colorWithRed:190/255.0 green:190/255.0 blue:190/255.0 alpha:1] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:100000];
        [backView addSubview:labelContent];
        
        [cell3.contentView addSubview:backView];
        
         return cell3;
    }
}
    
#pragma mark - collectionview的代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"My_collectionViewCell" forIndexPath:indexPath];
    UIImageView *imageV = [[UIImageView alloc] init];    
    imageV.frame = CGRectMake(0, 0,80, 80);
    imageV.image = [UIImage imageNamed:@"lc汪峰2"];
    [cell.contentView addSubview:imageV];
    
    return cell;
}
#pragma mark - 返回键
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
- (CGFloat)caculateTheTextWidth:(NSString *)string andFontSize:(int)fontSize andDistance:(int)distance{
    
    /*非彻底性封装*/
    CGSize constraint = CGSizeMake( CGFLOAT_MAX,distance);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:string
     attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    return size.width;
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
@end
