//
//  StahallEvalutionDetailInfoCollectionViewCell.h
//  Stahall
//
//  Created by frankfan on 14/12/25.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StahallEvalutionDetailInfoCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *staHeaderImageView;//艺人头像
@property (nonatomic,strong)UILabel *starName;

@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIView *bottomView;

@property (nonatomic,strong)UILabel *topPrice;
@property (nonatomic,strong)UILabel *bottomPrice;

@property (nonatomic,strong)UILabel *topTime;
@property (nonatomic,strong)UILabel *bottomTime;
@end
