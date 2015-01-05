//
//  MySegmentCtrol.m
//  MySegmentControl
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 无名. All rights reserved.
//

#import "MySegmentCtrol.h"

@implementation MySegmentCtrol

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)createTitles
{
    CGFloat width=self.frame.size.width/_items.count;
    for (int i=0; i<_items.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:_items[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"lc222"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(didClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag=i;
        btn.frame=CGRectMake(i*width, 0, width, self.frame.size.height);
        [self addSubview:btn];
    }
}
-(void)setSelecedIndex:(NSInteger)selecedIndex
{
    _selecedIndex=selecedIndex;
    UIButton *btn=nil;
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[UIButton class]]&& (v.tag==selecedIndex)) {
            
            btn=(UIButton *)v;
            break;
        }
    }
    [self didClicked:btn];

}
-(void)setItems:(NSArray *)items
{
    _items=[items copy];
    [self createTitles];
}
-(void)didClicked:(UIButton *)sender
{
    //在不创建可变数组把按钮找到的方法  把所有选中状态取消
    for (UIView *v in self.subviews)
    {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)v;
            btn.selected = NO;
        }
    }


    sender.selected = YES;
    _selecedIndex=sender.tag;
    if (_didselecedAtIndex) {
        _didselecedAtIndex(self,sender.tag);
    }
}
@end
