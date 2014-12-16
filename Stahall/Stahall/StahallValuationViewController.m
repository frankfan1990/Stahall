//
//  StahallValuationViewController.m
//  Stahall
//
//  Created by frankfan on 14/12/16.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "StahallValuationViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "StahallEvalueCollectionViewCell.h"

@interface StahallValuationViewController ()<UITextFieldDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,StarNameInput>

@property (nonatomic,strong)TPKeyboardAvoidingScrollView *tpscrollerView;
@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation StahallValuationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
 
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0/255.0 green:180/255.0 blue:204/255.0 alpha:1]];
    
    /*title*/
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:76/255.0 green:60/255.0 blue:136/255.0 alpha:1]];
    
    UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    title.text = @"堂估价";
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
    /*回退*/
    UIButton *backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.tag = 10006;
    backButton.frame = CGRectMake(0, 0, 30, 30);
    [backButton setImage:[UIImage imageNamed:@"朝左箭头icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftitem =[[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftitem;
    
    
    /**
     *  @author frankfan, 14-12-16 13:12:21
     *
     *  创建文本框
     */
    
    
    self.tpscrollerView =[[TPKeyboardAvoidingScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.tpscrollerView];
    
    //演出名
    UITextField *showNameTextField =[self createTextFieldWithTag:1001 andPlceholder:@"演出名称" andFrame:CGRectMake(10, 10, self.view.bounds.size.width/2.0-25, 35)];
    [self.tpscrollerView addSubview:showNameTextField];
    
    //演出地点
    UITextField *showAddressTextField =[self createTextFieldWithTag:1002 andPlceholder:@"演出地点" andFrame:CGRectMake(self.view.bounds.size.width/2.0-25+40, 10, self.view.bounds.size.width/2.0-25, 35)];
    [self.tpscrollerView addSubview:showAddressTextField];
    
    //演出时间
    UITextField *showTimeTextField =[self createTextFieldWithTag:1003 andPlceholder:@"演出时间" andFrame:CGRectMake(10,35+10+10, self.view.bounds.size.width/2.0-25, 35)];
    [self.tpscrollerView addSubview:showTimeTextField];
    
    //备选时间
    UITextField *anotherTimeTextField =[self createTextFieldWithTag:1004 andPlceholder:@"备选时间" andFrame:CGRectMake(self.view.bounds.size.width/2.0-25+40, 35+10+10, self.view.bounds.size.width/2.0-25, 35)];
    [self.tpscrollerView addSubview:anotherTimeTextField];
    
    //直飞机场
    UITextField *airPlane =[self createTextFieldWithTag:1005 andPlceholder:@"直飞机场" andFrame:CGRectMake(10, 35+10+10+35+10, self.view.bounds.size.width/2.0-25, 35)];
    [self.tpscrollerView addSubview:airPlane];
    
    //演出场馆
    UITextField *showPlcae =[self createTextFieldWithTag:1006 andPlceholder:@"演出场馆" andFrame:CGRectMake(self.view.bounds.size.width/2.0-25+40, 35+10+10+35+10, self.view.bounds.size.width/2.0-25, 35)];
    [self.tpscrollerView addSubview:showPlcae];
    
    UITextField *plcaeTextField =[self createTextFieldWithTag:1007 andPlceholder:@"" andFrame:CGRectMake(10, 35+10+10+35+10+10+35, self.view.bounds.size.width/2.0-25, 35)];
    [self.tpscrollerView addSubview:plcaeTextField];
    
    
    UITextField *plcaeTextField2 =[self createTextFieldWithTag:1008 andPlceholder:@"" andFrame:CGRectMake(self.view.bounds.size.width/2.0-25+40, 35+10+10+35+10+10+35, self.view.bounds.size.width/2.0-25, 35)];
    [self.tpscrollerView addSubview:plcaeTextField2];

    UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, 35+10+10+35+10+10+35+15+32, self.view.bounds.size.width, 1)];
    line.backgroundColor =[UIColor grayColor];
    [self.tpscrollerView addSubview:line];
    
    
#pragma mark - 创建collecView

    
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(65, 70);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 220, self.view.bounds.size.width-20, self.view.bounds.size.height-200-55) collectionViewLayout:flowLayout];
    
    
    [self.collectionView registerClass:[StahallEvalueCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.tpscrollerView addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    //编辑按钮
    UIButton *editable =[UIButton buttonWithType:UIButtonTypeCustom];
    editable.frame = CGRectMake(self.view.bounds.size.width-50, 35+10+10+35+10+10+35+15+32+5, 45, 18);
    editable.backgroundColor =[UIColor orangeColor];
    editable.layer.cornerRadius = 2;
    editable.layer.masksToBounds = YES;
    editable.titleLabel.font =[UIFont systemFontOfSize:12];
    [editable setTitle:@"编辑" forState:UIControlStateNormal];
    [editable setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:editable];
    
}


#pragma mark - 创建uitextField
- (UITextField *)createTextFieldWithTag:(NSInteger)tag andPlceholder:(NSString *)plcerHolder andFrame:(CGRect)frame{

    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.tag = tag;
    textField.layer.borderColor = [UIColor grayColor].CGColor;
    textField.layer.borderWidth = 1;
    textField.placeholder = plcerHolder;
    textField.layer.cornerRadius = 2;
    textField.font =[UIFont systemFontOfSize:14];

    return textField;
}



#pragma mark - textfield代理
- (void)textFieldDidEndEditing:(UITextField *)textField{


}


#pragma mark - section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

#pragma mark - cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{


    return 12;
}

#pragma mark - 创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StahallEvalueCollectionViewCell *stahallEvalueCell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    stahallEvalueCell.userInteractionEnabled = YES;
    stahallEvalueCell.delegate = self;

    return stahallEvalueCell;
}


#pragma mark - 获取艺人名字代理方法
- (void)starNameInputName:(NSString *)inputName{

    NSLog(@"inputName:%@",inputName);
}



#pragma mark - 导航栏回退按钮触发
- (void)buttonClicked:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - view将要出现
- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0/255.0 green:180/255.0 blue:204/255.0 alpha:1]];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
