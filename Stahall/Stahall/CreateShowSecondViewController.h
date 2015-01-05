//
//  CreateShowSecondViewController.h
//  Stahall
//
//  Created by JM_Pro on 14-12-22.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateShowSecondViewController : UIViewController
@property(nonatomic,strong)UITextField *field1;//用来传递设置时间的
@property(nonatomic,strong)NSMutableDictionary *dictOfData;
-(void)addData:(NSString *)text;
@end
