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
        self.nameLabel.adjustsFontSizeToFitWidth = YES;
        self.nameLabel.font =[UIFont systemFontOfSize:14];
        
     
        
        //白色圆圈
        self.circleView = [[UIView alloc]init];
        self.circleView.frame = CGRectMake(5, 15, 20, 20);
        self.circleView.layer.cornerRadius = 10;
        self.circleView.tag = 2999;
        self.circleView.backgroundColor =[UIColor colorWithWhite:1 alpha:0.45];
        
        
        //白色箭头
        self.arrowButton = nil;
        _arrowButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _arrowButton.userInteractionEnabled = YES;
        _arrowButton.frame = CGRectMake(0, 0, 20, 20);
        [_arrowButton setImage:[UIImage imageNamed:@"朝右箭头icon"] forState:UIControlStateNormal];
        _arrowButton.layer.masksToBounds = YES;
        _arrowButton.layer.cornerRadius = 10;
        [self.circleView addSubview:self.arrowButton];
        
        
        //分类按钮1
        self.sortButton1 =[UIButton buttonWithType:UIButtonTypeCustom];
        self.sortButton1.frame = CGRectMake(140, 15, 40, 20);
        self.sortButton1.layer.cornerRadius = 3;
        self.sortButton1.backgroundColor =[UIColor whiteColor];
        [self addSubview:self.sortButton1];
        
        //分类按钮2
        self.sortButton2 =[UIButton buttonWithType:UIButtonTypeCustom];
        self.sortButton2.frame = CGRectMake(190, 15, 40, 20);
        self.sortButton2.layer.cornerRadius = 3;
        self.sortButton2.backgroundColor =[UIColor whiteColor];
        [self addSubview:self.sortButton2];
        
        //分类按钮3
        self.sortButton3 =[UIButton buttonWithType:UIButtonTypeCustom];
        self.sortButton3.frame = CGRectMake(240, 15, 40, 20);
        self.sortButton3.layer.cornerRadius = 3;
        self.sortButton3.backgroundColor =[UIColor whiteColor];
        [self addSubview:self.sortButton3];

        
        
        [self addSubview:self.circleView];
        [self addSubview:self.nameLabel];
        
        
    }
    return self;
}



@end
