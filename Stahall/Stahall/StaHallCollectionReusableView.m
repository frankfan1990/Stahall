//
//  StaHallCollectionReusableView.m
//  Stahall
//
//  Created by frankfan on 14/12/15.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "StaHallCollectionReusableView.h"

@implementation StaHallCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
    
    
        //item名字
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 100, 50)];
        self.nameLabel.backgroundColor =[UIColor clearColor];
        self.nameLabel.textColor =[UIColor whiteColor];
        
     
        
        //白色圆圈
        UIButton *circleView =[UIButton buttonWithType:UIButtonTypeCustom];
        circleView.frame = CGRectMake(5, 15, 20, 20);
        circleView.layer.cornerRadius = 10;
        circleView.backgroundColor =[UIColor colorWithWhite:1 alpha:0.45];
        
        
        
        
        
        [self addSubview:circleView];
        [self addSubview:self.nameLabel];
        
        
    }
    return self;
}



@end
