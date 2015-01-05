//
//  MySegmentCtrol.h
//  MySegmentControl
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 无名. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySegmentCtrol : UIView
//存放标题的数组 自定义一个set方法
@property(nonatomic,strong)NSArray *items;
//选择的第几个
@property(nonatomic,assign)NSInteger selecedIndex;
//用block变量来实现 把点的第几个传出去
@property(nonatomic,strong) void(^didselecedAtIndex)(MySegmentCtrol *,NSInteger);

@end
