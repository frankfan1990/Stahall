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


@interface ListAdvanceViewController ()<GNWheelViewDelegate>
{
    NSMutableArray *arrays;
    NSMutableArray *activityImages_my;
    GNWheelView *gnView;
}
@end

@implementation ListAdvanceViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1];
    [self setTabBar];
     activityImages_my = [NSMutableArray arrayWithObjects:@"http://pic17.nipic.com/20111102/7015943_083452063000_2.jpg",@"http://pic24.nipic.com/20121015/9095554_134755084000_2.jpg",@"http://pic.nipic.com/2007-12-20/200712206539308_2.jpg",@"http://pic1.nipic.com/2008-10-13/2008101312210298_2.jpg",@"http://pic24.nipic.com/20121014/9095554_130006147000_2.jpg",@"http://pic1a.nipic.com/2008-10-27/2008102793623630_2.jpg",@"http://pic17.nipic.com/20111102/7015943_083452063000_2.jpg",nil];
    
    arrays =[NSMutableArray array];
    for (int i= 0; i<activityImages_my.count; i++) {
        UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 300-16, 160)];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:activityImages_my[i-1]]];
//        __weak typeof (self)myself = self;
//        [imageView sd_setImageWithURL:[NSURL URLWithString:activityImages_my[i-1]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            imageView.image = [myself grayImage:image];
//        }];
        imageView.tag = 1001+i;
        [arrays addObject:imageView];
    }

    gnView =[[GNWheelView alloc]initWithFrame:self.view.bounds];
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
    
    return viewBack;
    
}


#pragma mark - 在这里取到当前滚动索引
- (BOOL)wheelView:(GNWheelView *)wheelView shouldEnterIdleStateForRowAtIndex:(NSInteger)index animated:(BOOL *)animated{
    
    for (UIImageView *vv in arrays) {
        vv.image = [self grayImage:vv.image];
    }
    
    UIImageView *imageV = (UIImageView *)[wheelView viewWithTag:1001+index];
//    [imageV sd_setImageWithURL:[NSURL URLWithString:activityImages_my[index]]];
    
    return YES;
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

@end