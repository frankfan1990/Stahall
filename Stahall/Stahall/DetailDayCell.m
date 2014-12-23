//
//  DetailDayCell.m
//  piano_D3team
//
//  Created by Kom on 14-9-17.
//  Copyright (c) 2014年 d3team. All rights reserved.
//

#import "DetailDayCell.h"

@implementation DetailDayCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _noticeTextView = [[UITextView alloc] initWithFrame:CGRectMake(30, 5, 260, 40)];
        _noticeTextView.editable = NO;
        _noticeTextView.selectable = NO;
        _noticeTextView.backgroundColor = [UIColor clearColor];
        _noticeTextView.font = [UIFont systemFontOfSize:13];
        
        _eventButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _eventButton.frame = CGRectMake(220, 45, 80, 30);
        _eventButton.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.6];
        _eventButton.tintColor = [UIColor whiteColor];
        _eventButton.layer.cornerRadius = 5.0;
        [_eventButton setTitle:@"请假" forState:UIControlStateNormal];
        
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:_noticeTextView];
        [self addSubview:_eventButton];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
