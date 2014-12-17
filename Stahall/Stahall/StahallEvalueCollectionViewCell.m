//
//  StahallEvalueCollectionViewCell.m
//  Stahall
//
//  Created by frankfan on 14/12/16.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "StahallEvalueCollectionViewCell.h"

@implementation StahallEvalueCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if(self){
    
        //艺人头像
        self.starHeaderImage =[[UIImageView alloc]initWithFrame:CGRectMake(2.5, 0, 60, 60)];
        self.starHeaderImage.layer.masksToBounds = YES;
        self.starHeaderImage.layer.borderColor = [UIColor colorWithWhite:0.35 alpha:0.9].CGColor;
        self.starHeaderImage.layer.borderWidth = 2;
        self.starHeaderImage.layer.cornerRadius = 30;
        [self.contentView addSubview:self.starHeaderImage];
    
        
        //删除按钮
        self.deleteButton =[UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteButton.tag = 2002;
        self.deleteButton.frame = CGRectMake(50, 7, 15, 15);
        self.deleteButton.layer.masksToBounds = YES;
        self.deleteButton.layer.borderWidth = 1.5;
        self.deleteButton.layer.borderColor = [UIColor colorWithWhite:0.85 alpha:0.5].CGColor;
        [self.contentView addSubview:self.deleteButton];
        [self.deleteButton setImage:[UIImage imageNamed:@"fz删除"] forState:UIControlStateNormal];
        self.deleteButton.backgroundColor =[UIColor colorWithWhite:0.85 alpha:1];
        self.deleteButton.layer.cornerRadius = 7.5;
        [self.deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //艺人姓名
        self.starName =[[UITextField alloc]initWithFrame:CGRectMake(5, 62, 55, 17)];
        self.starName.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        self.starName.textColor =[UIColor whiteColor];
        [self.contentView addSubview:self.starName];
        self.starName.userInteractionEnabled = YES;
        self.starName.delegate = self;
        self.starName.font =[UIFont systemFontOfSize:12];
        self.starName.textAlignment = NSTextAlignmentCenter;
        
        self.addIcon =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        self.addIcon.center = self.starHeaderImage.center;
        [self.contentView addSubview:self.addIcon];
        
    }
    
    return self;
}

#pragma mark - 按钮触发
- (void)deleteButtonClicked:(UIButton *)sender{

    [self.delegate deletaButtonClicked:self andButton:sender];
}



- (void)textFieldDidEndEditing:(UITextField *)textField{

    [self.delegate starNameInputName:textField.text];
}


@end
