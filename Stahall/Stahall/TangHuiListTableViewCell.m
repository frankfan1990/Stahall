//
//  TangHuiListTableViewCell.m
//  Stahall
//
//  Created by JM_Pro on 15-2-6.
//  Copyright (c) 2015年 Rching. All rights reserved.
//

#import "TangHuiListTableViewCell.h"
#import "Marcos.h"
@implementation TangHuiListTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _bgView = [[UIView alloc] init];
        _imageV = [[UIImageView alloc] init];
        _titleOfLabel = [[UILabel alloc] init];
        _keyOfLabel = [[UILabel alloc] init];
        _stahallOfLabel = [[UILabel alloc] init];
        
        _bgView.backgroundColor = [UIColor whiteColor];
        
        _titleOfLabel.textColor = [UIColor blackColor];
        _titleOfLabel.font = [UIFont systemFontOfSize:14];
        _titleOfLabel.textAlignment = NSTextAlignmentLeft;
        
        _keyOfLabel.textColor = UIColorFromRGB(0x969696);
        _keyOfLabel.font = [UIFont systemFontOfSize:11];
        _keyOfLabel.textAlignment = NSTextAlignmentLeft;
        
        _stahallOfLabel.textColor = UIColorFromRGB(0x969696);
        _stahallOfLabel.font = [UIFont systemFontOfSize:11];
        _stahallOfLabel.textAlignment = NSTextAlignmentLeft;
        _stahallOfLabel.numberOfLines = 10;
        
        [self.contentView addSubview:_bgView];
        [_bgView addSubview:_imageV];
        [_bgView addSubview:_titleOfLabel];
        [_bgView addSubview:_keyOfLabel];
        [_bgView addSubview:_stahallOfLabel];
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _bgView.frame = CGRectMake(7.5, 0, self.frame.size.width-15, self.frame.size.height-8);
    
    _imageV.frame = CGRectMake(5, 6, 97, _bgView.frame.size.height-12);
    
    _titleOfLabel.frame = CGRectMake(_imageV.frame.size.width+_imageV.frame.origin.x+10, 10, _bgView.frame.size.width-_imageV.frame.size.width+_imageV.frame.origin.x-20, 20);
    _keyOfLabel.frame = CGRectMake(_titleOfLabel.frame.origin.x, 35+2.5, _titleOfLabel.frame.size.width, 15);
    if ([_stahallOfLabel.text length] >17) {
         _stahallOfLabel.frame = CGRectMake(_titleOfLabel.frame.origin.x, 54, _titleOfLabel.frame.size.width, 30);
    }else{
         _stahallOfLabel.frame = CGRectMake(_titleOfLabel.frame.origin.x, 54, _titleOfLabel.frame.size.width, 15);
    }
   
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
