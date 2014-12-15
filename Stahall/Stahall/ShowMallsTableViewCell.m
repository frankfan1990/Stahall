//
//  ShowMallsTableViewCell.m
//  Stahall
//
//  Created by JM_Pro on 14-12-15.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "ShowMallsTableViewCell.h"

@implementation ShowMallsTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_backView];
        
        _imageV = [[UIImageView alloc] init];
        
        
        _labelOfTitle = [[UILabel alloc] init];
        _labelOfDate = [[UILabel alloc] init];
        
        _labelOfTitle.font = [UIFont systemFontOfSize:14];
        _labelOfTitle.textAlignment = NSTextAlignmentLeft;
        _labelOfTitle.textColor = [UIColor blackColor];
        
        _labelOfDate.font = [UIFont systemFontOfSize:13];
        _labelOfDate.textAlignment = NSTextAlignmentRight;
        _labelOfDate.textColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];
        
        [_backView addSubview:_imageV];
        [_backView addSubview:_labelOfTitle];
        [_backView addSubview:_labelOfDate];
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _backView.frame = CGRectMake(10, 10,self.frame.size.width-20, self.frame.size.height-20);
    _imageV.frame = CGRectMake(10, 10, _backView.frame.size.width-20, _backView.frame.size.height-50);
    _labelOfTitle.frame = CGRectMake(10, _backView.frame.size.height-30, _backView.frame.size.width-90, 20);
    _labelOfDate.frame = CGRectMake(_backView.frame.size.width-90, _backView.frame.size.height-30,80, 20);
   
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
