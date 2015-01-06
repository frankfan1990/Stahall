//
//  StahallEvalutionDetailInfoViewController.h
//  Stahall
//
//  Created by frankfan on 14/12/25.
//  Copyright (c) 2014年 Rching. All rights reserved.
//
//FIXME: 堂估价详情

#import <UIKit/UIKit.h>

@interface StahallEvalutionDetailInfoViewController : UIViewController

@property (nonatomic,assign)BOOL isCouldSpeedModle;//是否是可以加急的状态模式

@property (nonatomic,copy)NSString *showName;
@property (nonatomic,copy)NSString *showAddress;
@property (nonatomic,copy)NSString *showTime;
@property (nonatomic,copy)NSString *showAnotherTime;
@property (nonatomic,copy)NSString *airPlane;
@property (nonatomic,copy)NSString *showPlace;

@property (nonatomic,strong)NSMutableArray *starsList;

@property (nonatomic,assign)BOOL isFirstPort;//判断是不是从第一个入口进来的
@property (nonatomic,copy)NSString *valuationId;//估价Id
@end
