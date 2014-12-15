//
//  LeftMenuViewController.m
//  Stahall
//
//  Created by frankfan on 14/12/11.
//  Copyright (c) 2014年 Rching. All rights reserved.
//frankfan
//FIXME: 侧边栏模块-frankfan

#import "StarHallViewController.h"//测试
#import "LeftMenuViewController.h"
#import "MyShowViewController.h"
#import "RESideMenu.h"

@interface LeftMenuViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    NSArray *itemNames;//侧边栏名字
}
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     变量初始化之地
     */
    
    itemNames = @[@"我的演出",@"我的账户",@"我的艺人",@"我的收藏",@"我的消息",@"专属客服",@"帮助中心",@"注销"];
    
    //侧边菜单
    self.tableView =[[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    CGRect rect = CGRectZero;
    UIView *footerView = [[UIView alloc]initWithFrame:rect];
    self.tableView.tableFooterView = footerView;
 
}


#pragma mark - cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 9;
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row==0){
        
        return 120;
    }else{
    
        return 55;
    }
    

}


#pragma mark - 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellName = @"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellName];
    if(!cell){
    
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.backgroundColor =[UIColor clearColor];
        if(indexPath.row==0){
        
            cell.selectionStyle = NO;
        }
        
        UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width-100, 0.5)];
        line.backgroundColor =[UIColor colorWithWhite:0.85 alpha:0.3];
        [cell.contentView addSubview:line];
        
        
        //开始创建cell控件
        if(indexPath.row==0){
        
            //头像
            UIImageView *userheaderImage =[[UIImageView alloc]initWithFrame:CGRectMake(20, 45, 60, 60)];
            userheaderImage.tag = 1001;
            userheaderImage.layer.masksToBounds = YES;
            userheaderImage.layer.cornerRadius = 30;
            userheaderImage.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.15].CGColor;
            userheaderImage.layer.borderWidth = 3;
            [cell.contentView addSubview:userheaderImage];
        
            //用户名
            UILabel *nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(90, 45, 110, 30)];
            nameLabel.tag = 1002;
            nameLabel.textColor = [UIColor whiteColor];
            nameLabel.font =[UIFont systemFontOfSize:16];
            nameLabel.adjustsFontSizeToFitWidth = YES;
            [cell.contentView addSubview:nameLabel];
            
            //VIP
            UILabel *vipLabel =[[UILabel alloc]initWithFrame:CGRectMake(90, 45+30, 50, 16)];
            vipLabel.backgroundColor =[UIColor orangeColor];
            vipLabel.textAlignment = NSTextAlignmentCenter;
            vipLabel.textColor =[UIColor whiteColor];
            vipLabel.font =[UIFont systemFontOfSize:14];
            vipLabel.text = @"VIP";
            vipLabel.layer.masksToBounds = YES;
            vipLabel.layer.cornerRadius = 8;
            [cell.contentView addSubview:vipLabel];
            
        }else{
        
            //item图标
            UIImageView *itemImageView =[[UIImageView alloc]initWithFrame:CGRectMake(20, cell.bounds.size.height/2.0-6.5, 25, 25)];
            itemImageView.tag = 1003;
            [cell.contentView addSubview:itemImageView];
        
            //item名字
            UILabel *itemLabel =[[UILabel alloc]initWithFrame:CGRectMake(50, cell.bounds.size.height/2.0-12.5, 100, 40)];
            itemLabel.tag = 1004;
            itemLabel.font =[UIFont systemFontOfSize:16];
            itemLabel.textColor =[UIColor whiteColor];
            [cell.contentView addSubview:itemLabel];
            
            if(indexPath.row==1 || indexPath.row==5){
            
                //我的演出-消息条数
                UILabel *circleLabel =[[UILabel alloc]initWithFrame:CGRectMake(175, cell.bounds.size.height/2.0-4, 25, 25)];
                circleLabel.layer.masksToBounds = YES;
                circleLabel.layer.cornerRadius = 12.5;
                circleLabel.backgroundColor =[UIColor redColor];
                circleLabel.textAlignment = NSTextAlignmentCenter;
                circleLabel.textColor =[UIColor whiteColor];
                circleLabel.font =[UIFont systemFontOfSize:14];
                
                if(indexPath.row==1){
                
                    circleLabel.tag = 1005;
                }else{
                
                    circleLabel.tag = 1006;
                }
                
                [cell.contentView addSubview:circleLabel];
            }
            
        
        }
        
    }
    
    //用户头像
    UIImageView *userHeaderImageView = (UIImageView *)[cell viewWithTag:1001];
    userHeaderImageView.image =[UIImage imageNamed:@"陈奕迅"];
    
    //用户名
    UILabel *nameLabel =(UILabel *)[cell viewWithTag:1002];
    nameLabel.text = @"宇宙人气小美女";
    
    //item图标
    UIImageView *itemImageVIew =(UIImageView *)[cell viewWithTag:1003];
    itemImageVIew.backgroundColor =[UIColor orangeColor];
    
    //item名字
    UILabel *itemName =(UILabel *)[cell viewWithTag:1004];
    if(indexPath.row!=0){
    
        itemName.text = itemNames[indexPath.row-1];
    }
    
    //消息条数
    if(indexPath.row==1){
    
        UILabel *circleLabel = (UILabel *)[cell viewWithTag:1005];
        circleLabel.text = @"10";
        
    }else if (indexPath.row==5){
    
        UILabel *circleLabel = (UILabel *)[cell viewWithTag:1006];
        circleLabel.text = @"25";
    }
    
    
    
    
    return cell;

}


#pragma mark - cell被点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row==1){//我的演出
    
        MyShowViewController *myshowController = [MyShowViewController new];
        myshowController.customTitle = @"我的演出";
        [self showTheContentViewControll:myshowController];
    }
    
    if(indexPath.row==2){//测试
    
        StarHallViewController *starHallViewController =[StarHallViewController new];
        [self showTheContentViewControll:starHallViewController];
    }

}

- (void)showTheContentViewControll:(UIViewController *)viewController{

    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:viewController] animated:YES];
    [self.sideMenuViewController hideMenuViewController];
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
