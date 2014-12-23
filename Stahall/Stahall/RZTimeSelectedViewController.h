//
//  RZTimeSelectedViewController.h
//  ZhiHuiChengShi
//
//  Created by H.DX on 14-11-11.
//  Copyright (c) 2014年 H.DX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZTimeSelectedViewController : UIViewController
@property(nonatomic,assign) NSInteger type;
-(void)getDate:(NSString *)date Time:(NSString *)time;
@end
