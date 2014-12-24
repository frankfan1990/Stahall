//
//  StarDetailCollectionViewCell.m
//  Stahall
//
//  Created by frankfan on 14/12/24.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "StarDetailCollectionViewCell.h"

@implementation StarDetailCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
    
        _itemTitle =[[UILabel alloc]initWithFrame:self.bounds];
        _itemTitle.font =[UIFont systemFontOfSize:14];
        _itemTitle.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_itemTitle];
    }
    
    return self;
}



@end
