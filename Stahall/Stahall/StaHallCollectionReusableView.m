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
//        self.circleView =[UIButton buttonWithType:UIButtonTypeCustom];
        self.circleView = [[UIView alloc]init];
        self.circleView.frame = CGRectMake(5, 15, 20, 20);
        self.circleView.layer.cornerRadius = 10;
        self.circleView.tag = 2999;
        self.circleView.backgroundColor =[UIColor colorWithWhite:1 alpha:0.45];
        
        
        self.arrowButton = nil;
        _arrowButton =[UIButton buttonWithType:UIButtonTypeCustom];
//        _arrowButton =[[UIImageView alloc]init];
        _arrowButton.userInteractionEnabled = YES;
//        _arrowButton.image =[UIImage imageNamed:@"朝右箭头icon"];
        _arrowButton.frame = CGRectMake(0, 0, 20, 20);
        [_arrowButton setImage:[UIImage imageNamed:@"朝右箭头icon"] forState:UIControlStateNormal];
        _arrowButton.layer.masksToBounds = YES;
        _arrowButton.layer.cornerRadius = 10;
        _arrowButton.tag = 3000;
        [self.circleView addSubview:self.arrowButton];
        
        
        
        
        [self addSubview:self.circleView];
        [self addSubview:self.nameLabel];
        
        
    }
    return self;
}



@end
