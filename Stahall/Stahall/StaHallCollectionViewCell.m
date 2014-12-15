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
        self.starImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
        self.starImage.layer.masksToBounds = YES;
        self.starImage.layer.borderColor = [UIColor purpleColor].CGColor;
        self.starImage.layer.borderWidth = 2;
        self.starImage.layer.cornerRadius = 20;
        [self.contentView addSubview:self.starImage];
        
        //艺人区域
        self.zoneDot =[[UILabel alloc]initWithFrame:CGRectMake(35, 30, 15, 15)];
        self.zoneDot.layer.cornerRadius = 7.5;
        self.zoneDot.layer.borderColor = [UIColor whiteColor].CGColor;
        self.zoneDot.layer.borderWidth = 1.5;
        self.zoneDot.layer.masksToBounds = YES;
        [self.contentView addSubview:self.zoneDot];
    
        //艺人姓名
        self.starName =[[UILabel alloc]initWithFrame:CGRectMake(13, 43, 30, 20)];
        self.starName.font =[UIFont systemFontOfSize:14];
        self.starName.textColor = [UIColor whiteColor];
        self.starName.adjustsFontSizeToFitWidth = YES;
        self.starName.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.starName];
    }
    
   
    return self;
}


@end
