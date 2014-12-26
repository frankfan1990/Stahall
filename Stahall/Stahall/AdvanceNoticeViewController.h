//
//  AdvanceNoticeViewController.h
//  Stahall
//
//  Created by JM_Pro on 14-12-15.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvanceNoticeViewController : UIViewController
@property(nonatomic,strong)NSString *titleViewStr;
@property(nonatomic,assign)NSInteger type;//1：预告详情  2：案例详情  3：行程详情
@property(nonatomic,assign)NSDictionary *dictData;
@end
