//
//  MyShowDetailsViewController.h
//  Stahall
//
//  Created by JM_Pro on 15-1-8.
//  Copyright (c) 2015年 Rching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyShowDetailsViewController : UIViewController
@property(nonatomic,strong)NSDictionary *dicData;

@property (nonatomic,strong)NSMutableArray *hasEvationStars;//这个数组用来存放已估价完的艺人
@end
