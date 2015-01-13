//
//  StahallEvalutionDetailInfoCollectionViewCell.m
//  Stahall
//
//  Created by frankfan on 14/12/25.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "StahallEvalutionDetailInfoCollectionViewCell.h"

@implementation StahallEvalutionDetailInfoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    if(self){
    
        //头像
        self.staHeaderImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, -5, self.bounds.size.width, self.bounds.size.width)];
        self.staHeaderImageView.layer.masksToBounds  =YES;
        self.staHeaderImageView.layer.cornerRadius = self.bounds.size.width/2.0;
        self.staHeaderImageView.layer.borderColor = [UIColor colorWithWhite:0.85 alpha:0.65].CGColor;
        self.staHeaderImageView.layer.borderWidth = 3;
        [self.contentView addSubview:self.staHeaderImageView];
        
        //名字
        self.starName = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.width-13, self.bounds.size.width, 35)];
        self.starName.font =[UIFont systemFontOfSize:12];
        self.starName.textColor =[UIColor whiteColor];
        self.starName.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.starName];
        
        //
        UIView *bacView =[[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.width+15,self.bounds.size.width, 70)];
        bacView.layer.cornerRadius = 3;
        bacView.layer.masksToBounds = YES;
        bacView.backgroundColor =[UIColor colorWithWhite:0.22 alpha:0.85];
        [self.contentView addSubview:bacView];
        
        //topView
        self.topPrice =[[UILabel alloc]initWithFrame:CGRectMake(0, 5,self.bounds.size.width, 20)];
        self.topPrice.backgroundColor =[UIColor orangeColor];
        self.topPrice.font =[UIFont boldSystemFontOfSize:15];
        self.topPrice.textColor =[UIColor whiteColor];
        self.topPrice.textAlignment = NSTextAlignmentCenter;
        [bacView addSubview:self.topPrice];
        
        //topTime
        self.topTime =[[UILabel alloc]initWithFrame:CGRectMake(0, 5+20, self.bounds.size.width, 10)];
        self.topTime.backgroundColor =[UIColor orangeColor];
        self.topTime.font =[UIFont systemFontOfSize:11];
        self.topTime.textColor =[UIColor whiteColor];
        self.topTime.textAlignment = NSTextAlignmentCenter;
        [bacView addSubview:self.topTime];
        
        
        //bottomPrice
        self.bottomPrice =[[UILabel alloc]initWithFrame:CGRectMake(0, 5+20+10,self.bounds.size.width, 20)];
        self.bottomPrice.backgroundColor =[UIColor redColor];
        self.bottomPrice.font =[UIFont boldSystemFontOfSize:15];
        self.bottomPrice.textColor =[UIColor whiteColor];
        self.bottomPrice.textAlignment = NSTextAlignmentCenter;
        [bacView addSubview:self.bottomPrice];

        //bottomTime
        self.bottomTime =[[UILabel alloc]initWithFrame:CGRectMake(0, 5+20+10+20, self.bounds.size.width, 10)];
        self.bottomTime.backgroundColor =[UIColor redColor];
        self.bottomTime.font =[UIFont systemFontOfSize:11];
        self.bottomTime.textColor =[UIColor whiteColor];
        self.bottomTime.textAlignment = NSTextAlignmentCenter;
        [bacView addSubview:self.bottomTime];
        
        //勾选
        self.checkIcon =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        self.checkIcon.center = self.staHeaderImageView.center;
        self.checkIcon.image =[UIImage imageNamed:@"fz选中对勾"];
        [self.staHeaderImageView addSubview:self.checkIcon];
        self.checkIcon.hidden = YES;
        
    }
    
    return self;
}




@end
