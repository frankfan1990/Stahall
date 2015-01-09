//
//  SendInvitationCollectionViewCell.m
//  Stahall
//
//  Created by frankfan on 15/1/8.
//  Copyright (c) 2015年 Rching. All rights reserved.
//

#import "SendInvitationCollectionViewCell.h"

@implementation SendInvitationCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    self =[super initWithFrame:frame];
    if(self){
    
        self.headerImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 65, 65)];
        self.headerImageView.layer.cornerRadius = 65/2.0;
        self.headerImageView.layer.masksToBounds = YES;
        self.headerImageView.layer.borderWidth = 3;
        self.headerImageView.layer.borderColor =[UIColor colorWithWhite:0.6 alpha:0.75].CGColor;
        [self.contentView addSubview:self.headerImageView];
    }
    
    return self;
}
@end
