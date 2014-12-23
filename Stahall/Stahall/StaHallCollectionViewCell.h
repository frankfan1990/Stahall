//
//  StaHallCollectionViewCell.h
//  Stahall
//
//  Created by frankfan on 14/12/15.
//  Copyright (c) 2014年 Rching. All rights reserved.
//
//FIXME: 艺人堂cell

#import <UIKit/UIKit.h>

@interface StaHallCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *starImage;//艺人头像
@property (nonatomic,strong)UILabel *zoneDot;//艺人的区域
@property (nonatomic,strong)UILabel *starName;//艺人姓名
@property (nonatomic,strong)UIImageView *checkIt;//选中对勾
@end
