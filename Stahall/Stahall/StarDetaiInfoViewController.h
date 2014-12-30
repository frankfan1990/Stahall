//
//  StarDetaiInfoViewController.h
//  Stahall
//
//  Created by frankfan on 14/12/23.
//  Copyright (c) 2014年 Rching. All rights reserved.
//
//艺人详情模块



#import <UIKit/UIKit.h>

@interface StarDetaiInfoViewController : UIViewController

@property (nonatomic,strong)NSDictionary *starDict;//艺人数据层dict

@property (nonatomic,copy)NSString *starName;

@property (nonatomic,strong)NSMutableArray *today;
@property (nonatomic,strong)NSMutableArray *travelDay;
@property (nonatomic,strong)NSMutableArray *showDay;

@property (nonatomic,strong)UIButton *leftButton;
@property (nonatomic,strong)UIButton *rightButton;
@end
