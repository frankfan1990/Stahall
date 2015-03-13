//
//  UIViewController+AddTitle.m
//  Stahall
//
//  Created by frankfan on 15/3/13.
//  Copyright (c) 2015年 Rching. All rights reserved.
//

#import "UIViewController+AddTitle.h"
#import <ReactiveCocoa.h>

@implementation UIViewController (AddTitle)

- (void)setTheTitle:(NSString *)theTitle{
    
    /*title*/
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 123, 40)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = theTitle;
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
}

- (void)setTheBackArrow{

    UIButton *searchButton0 =[UIButton buttonWithType:UIButtonTypeCustom];
    searchButton0.tag = 10006;
    searchButton0.frame = CGRectMake(0, 0, 30, 30);
    [searchButton0 setImage:[UIImage imageNamed:@"朝左箭头icon"] forState:UIControlStateNormal];
    searchButton0.rac_command =[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        [self.navigationController popViewControllerAnimated:YES];
        return [RACSignal empty];
    }];
    
    UIBarButtonItem *leftitem =[[UIBarButtonItem alloc]initWithCustomView:searchButton0];
    self.navigationItem.leftBarButtonItem = leftitem;

}
@end
