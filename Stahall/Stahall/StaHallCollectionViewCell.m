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
        
        self.starImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
        self.starImage.layer.masksToBounds = YES;
        self.starImage.layer.borderColor = [UIColor purpleColor].CGColor;
        self.starImage.layer.borderWidth = 2;
        self.starImage.layer.cornerRadius = 20;
        [self.contentView addSubview:self.starImage];
    
    }
    
    self.backgroundColor =[UIColor clearColor];
    return self;
}


@end
