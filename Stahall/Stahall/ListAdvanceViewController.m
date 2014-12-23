//
//  ListAdvanceViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-18.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "ListAdvanceViewController.h"
#import "GNWheelView.h"
#import "Marcos.h"
#import "UIImageView+WebCache.h"
#import "AdvanceNoticeViewController.h"
@interface ListAdvanceViewController ()<GNWheelViewDelegate>
{
    NSMutableArray *arrays;
    NSMutableArray *activityImages_my;
    GNWheelView *gnView;
}
@end

@implementation ListAdvanceViewController


#pragma mark -预告  案例 行程 的列表（黑白图片）
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [self setTabBar];
     activityImages_my = [NSMutableArray arrayWithObjects:
                          @"http://imgs.focus.cn/upload/news/7094/a_70932259.jpg",
                          @"http://photocdn.sohu.com/20101125/Img277908901.jpg",
                          @"http://photocdn.sohu.com/20080625/Img257738894.jpg",
                          @"http://ent.taiwan.cn/list/201310/W020131021414396230095.jpg",
                          @"http://ent.shangdu.com/report/20140408/P_5892825_0__363882803.jpg",
                          @"http://photocdn.sohu.com/20101125/Img277908901.jpg",
                          @"http://ent.shangdu.com/report/20140408/P_5892825_0__363882803.jpg",nil];
    
    arrays =[NSMutableArray array];
    for (int i= 0; i<activityImages_my.count; i++) {
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 300-16, 160-20)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:activityImages_my[i]]];
        __weak typeof (self)myself = self;
        [imageView sd_setImageWithURL:[NSURL URLWithString:activityImages_my[i]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            imageView.image = [myself grayImage:image];
        }];
        imageView.tag = 1001+i;
        [arrays addObject:imageView];
    }

    gnView =[[GNWheelView alloc]initWithFrame:CGRectMake(0, -20, Mywidth, Myheight-40)];
    gnView.delegate = self;
    [self.view addSubview:gnView];
    [gnView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}
#pragma mark - TabBar的设置
-(void)setTabBar
{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0/255.0 green:180/255.0 blue:204/255.0 alpha:1]];
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeSystem];
    btnLeft.layer.masksToBounds = YES;
    btnLeft.layer.cornerRadius = 20;
    [btnLeft setFrame:CGRectMake(0, 0, 35, 35)];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateNormal];
    [btnLeft setBackgroundImage:[UIImage imageNamed:@"朝左箭头icon@2x.png"] forState:UIControlStateHighlighted];
    [btnLeft setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnLeft addTarget:self action:@selector(didGoBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnLeftitem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems= @[negativeSpacer, btnLeftitem];
        
    }else{
        self.navigationItem.leftBarButtonItem = btnLeftitem;
    }
    
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    if (_type == 1) {
        title.text = @"劲爆预告";
    }else if (_type == 2){
        title.text = @"演出案例";
    }else if (_type == 3){
        title.text = @"演出行程";
    }

    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}

- (NSInteger)numberOfRowsOfWheelView:(GNWheelView *)wheelView{
    
    
    return [arrays count];
}

- (float)rowWidthInWheelView:(GNWheelView *)wheelView{
    
    return Mywidth-20;
    
}

- (float)rowHeightInWheelView:(GNWheelView *)wheelView{
    
    return 180;
    
}


- (UIView *)wheelView:(GNWheelView *)wheelView viewForRowAtIndex:(NSInteger)index{
    
    UIView *viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth-20,180)];
    viewBack.backgroundColor = [UIColor whiteColor];
    [viewBack addSubview:arrays[index]];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 150, viewBack.frame.size.width-95, 25)];
    [self Customlable:label1 text:@"张杰跨年全国巡回演唱会" fontSzie:15 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
    [viewBack addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(viewBack.frame.size.width-90, 151,80, 25)];
    [self Customlable:label2 text:@"2014-11-05" fontSzie:12 textColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] textAlignment:NSTextAlignmentRight adjustsFontSizeToFitWidth:NO numberOfLines:1];
    [viewBack addSubview:label2];
    
    return viewBack;
    
}


#pragma mark - 在这里取到当前滚动索引
- (BOOL)wheelView:(GNWheelView *)wheelView shouldEnterIdleStateForRowAtIndex:(NSInteger)index animated:(BOOL *)animated{
    
    for (UIImageView *vv in arrays) {
        vv.image = [self grayImage:vv.image];
    }
    
    UIImageView *imageV = (UIImageView *)[wheelView viewWithTag:1001+index];
    [imageV sd_setImageWithURL:[NSURL URLWithString:activityImages_my[index]]];
    
    return YES;
}

-(void)wheelView:(GNWheelView *)wheelView didSelectedRowAtIndex:(NSInteger)index
{
    AdvanceNoticeViewController *advanceCtrl = [[AdvanceNoticeViewController alloc] init];
    
    if (_type == 1) {
        advanceCtrl.titleViewStr = @"预告详情";
        advanceCtrl.type = 1;
        
    }else if (_type == 1){
        advanceCtrl.titleViewStr = @"案例详情";
        advanceCtrl.type = 2;
    }else if (_type == 1){
        advanceCtrl.titleViewStr = @"行程详情";
        advanceCtrl.type = 3;
    }
    [self.navigationController pushViewController:advanceCtrl animated:YES];
}

- (void)theAnimationStoped{
    
    
    
}

-(void)didGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - RGB转灰度
-(UIImage *)grayImage:(UIImage *)sourceImage
{
    int bitmapInfo = kCGImageAlphaNone;
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  8,      // bits per component
                                                  0,
                                                  colorSpace,
                                                  bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}

#pragma mark - UIlabel的方法
-(void)Customlable:(UILabel *)label text:(NSString *)textStr fontSzie:(CGFloat)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment adjustsFontSizeToFitWidth:(BOOL)state numberOfLines:(NSInteger)numberOfLines
{
    label.text = textStr;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.adjustsFontSizeToFitWidth = state;
    label.numberOfLines = numberOfLines;
}
@end
