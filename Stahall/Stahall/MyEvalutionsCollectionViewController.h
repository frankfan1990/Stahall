//
//  MyEvalutionsCollectionViewController.h
//  Stahall
//
//  Created by frankfan on 15/1/9.
//  Copyright (c) 2015年 Rching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyEvalutionsCollectionViewController : UIViewController

@property (nonatomic,copy)NSString *showTitle;
@property (nonatomic,strong)NSMutableArray *hasEvalutionedStars;
@property (nonatomic,copy)NSString *valutionId;

@property (nonatomic,strong)NSMutableArray *theSelectedStars;//接受从上页传来的已选择的艺人
@end
