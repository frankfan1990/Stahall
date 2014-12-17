//
//  StahallFooterReusableView.m
//  Stahall
//
//  Created by frankfan on 14/12/17.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "StahallFooterReusableView.h"

@implementation StahallFooterReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self =[super initWithFrame:frame];
    if(self){
    
        self.loadMoreButton =[UIButton buttonWithType:UIButtonTypeCustom];
        self.loadMoreButton.frame = CGRectMake(10 ,5, self.bounds.size.width-20, 25);
        self.loadMoreButton.backgroundColor =[UIColor purpleColor];
        self.loadMoreButton.alpha = 0.75;
        [self.loadMoreButton setTitle:@"加载更多" forState:UIControlStateNormal];
        [self.loadMoreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.loadMoreButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self addSubview:self.loadMoreButton];
        self.loadMoreButton.titleLabel.font =[UIFont systemFontOfSize:12];
        self.loadMoreButton.layer.cornerRadius = 2;
        
    }

    return self;
}

@end
