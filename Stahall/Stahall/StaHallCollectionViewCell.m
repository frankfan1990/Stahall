//
//  StaHallCollectionViewCell.m
//  Stahall
//
//  Created by frankfan on 14/12/15.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "StaHallCollectionViewCell.h"

@implementation StaHallCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        
        //艺人头像
        self.starImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -5, 60, 60)];
        self.starImage.layer.masksToBounds = YES;
        self.starImage.layer.borderColor = [UIColor colorWithWhite:0.35 alpha:0.4].CGColor;
        self.starImage.layer.borderWidth = 3;
        self.starImage.layer.cornerRadius = 30;
        [self.contentView addSubview:self.starImage];
        
        //艺人区域
        self.zoneDot =[[UILabel alloc]initWithFrame:CGRectMake(37+10, 32+4, 12, 12)];
        self.zoneDot.layer.cornerRadius = 6;
        self.zoneDot.layer.borderColor = [UIColor whiteColor].CGColor;
        self.zoneDot.layer.borderWidth = 1;
        self.zoneDot.layer.masksToBounds = YES;
        [self.contentView addSubview:self.zoneDot];
    
        //艺人姓名
        self.starName =[[UILabel alloc]initWithFrame:CGRectMake(12, 55, 33, 20)];
        self.starName.font =[UIFont systemFontOfSize:11];
        self.starName.textColor = [UIColor whiteColor];
        self.starName.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.starName];
        
        //选中对勾
        self.checkIt =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        self.checkIt.center = self.starImage.center;
        self.checkIt.image = [UIImage imageNamed:@"fz选中对勾"];
        [self addSubview:self.checkIt];
        self.checkIt.hidden = YES;
        
        
    }
    
   
    return self;
}


@end
