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
#import "NSDate+Category.h"
#import "ProgressHUD.h"
#import "StahallEvalutionDetailInfoViewController.h"
#import "StarModel.h"
#import "UIImageView+WebCache.h"

#import "NetworkHelper.h"
#import "ProgressHUD.h"
#import "Reachability.h"
#import "FrankfanApis.h"
#import "StarModel.h"
//#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa.h>

bool selected;//是否是出于编辑模式的标志位
@interface StahallValuationViewController ()<UITextFieldDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,StarNameInput>
{
    NSMutableArray *starsSelected;//
    
    BOOL deleteMode;
    
    UIButton *editable;
    
    UIDatePicker *datePicker;
    
    UIView *datePickerBackView;//时间选择器的承载
    
    NSDateFormatter *dateFormatter;
    
    Reachability *_reachability;
    
    //
    UITextField *showNameTextField;
    UITextField *showAddressTextField;
    UITextField *showTimeTextField;
    UITextField *anotherTimeTextField;
    UITextField *airPlane;
    UITextField *showPlcae;
}
@property (nonatomic,strong)TPKeyboardAvoidingScrollView *tpscrollerView;
@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation StahallValuationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    //初始化变量
    starsSelected =[NSMutableArray arrayWithObject:@"end"];
    deleteMode = NO;
    dateFormatter =[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    _reachability =[Reachability reachabilityWithHostName:@"www.baidu.com"];
    
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
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
    
    /**
     *  @author frankfan, 14-12-16 13:12:21
     *
     *  创建文本框
     */
    
    
    self.tpscrollerView =[[TPKeyboardAvoidingScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.tpscrollerView];
    
    //演出名
    showNameTextField =[self createTextFieldWithTag:1001 andPlceholder:@"演出名称" andFrame:CGRectMake(10, 10, self.view.bounds.size.width/2.0-25, 35)];
    [self.tpscrollerView addSubview:showNameTextField];
    
    //演出地点
    showAddressTextField =[self createTextFieldWithTag:1002 andPlceholder:@"演出地点" andFrame:CGRectMake(self.view.bounds.size.width/2.0-25+40, 10, self.view.bounds.size.width/2.0-25, 35)];
    [self.tpscrollerView addSubview:showAddressTextField];
    
    //演出时间
    showTimeTextField =[self createTextFieldWithTag:1003 andPlceholder:@"演出时间" andFrame:CGRectMake(10,35+10+10, self.view.bounds.size.width/2.0-25, 35)];
    showTimeTextField.delegate = self;
    showTimeTextField.tag = 3000;
    [self.tpscrollerView addSubview:showTimeTextField];
    [showTimeTextField resignFirstResponder];
    
    //备选时间
    anotherTimeTextField =[self createTextFieldWithTag:1004 andPlceholder:@"备选时间" andFrame:CGRectMake(self.view.bounds.size.width/2.0-25+40, 35+10+10, self.view.bounds.size.width/2.0-25, 35)];
    anotherTimeTextField.delegate = self;
    anotherTimeTextField.tag = 3001;
    [self.tpscrollerView addSubview:anotherTimeTextField];
    
    //直飞机场
    airPlane =[self createTextFieldWithTag:1005 andPlceholder:@"直飞机场" andFrame:CGRectMake(10, 35+10+10+35+10, self.view.bounds.size.width/2.0-25, 35)];
    [self.tpscrollerView addSubview:airPlane];
    
    //演出场馆
    showPlcae =[self createTextFieldWithTag:1006 andPlceholder:@"演出场馆" andFrame:CGRectMake(self.view.bounds.size.width/2.0-25+40, 35+10+10+35+10, self.view.bounds.size.width/2.0-25, 35)];
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
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 20, 0);
    
    flowLayout.minimumLineSpacing = 20;
    flowLayout.minimumInteritemSpacing = 10;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 220, self.view.bounds.size.width-20, self.view.bounds.size.height-200-130) collectionViewLayout:flowLayout];
    
    
    [self.collectionView registerClass:[StahallEvalueCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.tpscrollerView addSubview:self.collectionView];
//     [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    //编辑按钮
    editable =[UIButton buttonWithType:UIButtonTypeCustom];
    editable.frame = CGRectMake(self.view.bounds.size.width-50, 35+10+10+35+10+10+35+15+32+5, 45, 18);
    editable.backgroundColor =[UIColor orangeColor];
    editable.layer.cornerRadius = 2;
    editable.layer.masksToBounds = YES;
    editable.titleLabel.font =[UIFont systemFontOfSize:12];
    [editable setTitle:@"编辑" forState:UIControlStateNormal];
    [editable setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:editable];
    [editable addTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //提交估价
    UIButton *commitEvalution =[UIButton buttonWithType:UIButtonTypeCustom];
    commitEvalution.frame = CGRectMake(10, self.view.bounds.size.height-115,self.view.bounds.size.width-20 , 35);
    commitEvalution.backgroundColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:204/255.0 alpha:1];
    [commitEvalution setTitle:@"提交估价" forState:UIControlStateNormal];
    [commitEvalution setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [commitEvalution setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:commitEvalution];
    commitEvalution.layer.cornerRadius = 3;
    commitEvalution.titleLabel.font =[UIFont systemFontOfSize:12];
    [commitEvalution addTarget:self action:@selector(commitTheHallEvalution) forControlEvents:UIControlEventTouchUpInside];
    
    
    //创建时间选择器
    datePickerBackView =[[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.height, 230)];
    datePickerBackView.backgroundColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:204/255.0 alpha:1];
    
    
    datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, datePickerBackView.bounds.size.width, datePickerBackView.bounds.size.height)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePickerBackView addSubview:datePicker];
    [self.view addSubview:datePickerBackView];
    
    //
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:@"clearAllData" object:nil]subscribeNext:^(NSNotification *notification) {
        
        //清空数据
        showNameTextField.text = nil;
        showAddressTextField.text = nil;
        showTimeTextField.text = nil;
        anotherTimeTextField.text = nil;
        airPlane.text = nil;
        showPlcae.text = nil;
        
        if([[starsSelected lastObject]isKindOfClass:[NSString class]]){
        
            [starsSelected removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [starsSelected count]-1)]];
        }else{
        
            [starsSelected removeAllObjects];
            [starsSelected addObject:@"end"];
            
        }
        
        [self.collectionView reloadData];
        
    }];
    

    
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


#pragma mark - 编辑按钮触发

- (void)editButtonClicked:(UIButton *)sender{

    if([starsSelected count]==1){
    
        return;
    }
    
    if(!selected){//打开编辑
    
        selected = YES;
        [sender setTitle:@"取消" forState:UIControlStateNormal];
        [self.collectionView reloadData];
        
    }else{//关闭编辑
    
        selected = NO;
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        [self.collectionView reloadData];
    }
}


#pragma mark - 提交堂估价
- (void)commitTheHallEvalution{

    if([[starsSelected firstObject]isKindOfClass:[NSString class]]){
    
        [ProgressHUD showError:@"提交前请至少估价一位艺人"];
        return;
        
    }else{
    
        
        if(!(showNameTextField.text.length && showAddressTextField.text.length && showTimeTextField.text.length && anotherTimeTextField.text.length && airPlane.text.length && showPlcae.text.length)){
        
            [ProgressHUD showError:@"请完善信息"];
            return;
        }
        
        AFHTTPRequestOperationManager *manager = [NetworkHelper createRequestManagerWithContentType:application_json];
        manager.responseSerializer =[AFJSONResponseSerializer serializer];
        manager.requestSerializer =[AFJSONRequestSerializer serializer];
        
        NSMutableArray *starIDs = [NSMutableArray array];
        NSMutableArray *tempMutablArray;
        if([[starsSelected lastObject]isKindOfClass:[NSString class]]){
        
            tempMutablArray = [starsSelected mutableCopy];
            [tempMutablArray removeLastObject];
            
            for (NSDictionary *dict in tempMutablArray) {
                
                StarModel *starModel =[StarModel modelWithDictionary:dict error:nil];
                [starIDs addObject:starModel.artistId];
            }
            
        }
        
 

#warning 这里的字段:"businessId"为演出商ID，暂时使用fake data
        NSDictionary *parameters = @{@"showName":showNameTextField.text,
                                     @"showAddress":showAddressTextField.text,
                                 @"showTime":showTimeTextField.text,
                                 @"alternativeTime":anotherTimeTextField.text,
                                 @"directArport":airPlane.text,
                                 @"showVenues":showPlcae.text,
                                 @"artistIds":starIDs,
                                 @"businessId":@"47e92fdc-d546-46c9-af66-436568094d5c"};
        
        
        
        if(![_reachability isReachable]){
        
            [ProgressHUD showError:@"网络异常"];
            return;
        }
        
        [ProgressHUD show:nil];
        [manager POST:API_PostStaHallValutionInfo parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"response:%@",responseObject);
            NSDictionary *dict_data = responseObject[@"data"];
            [ProgressHUD dismiss];
            
            UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:nil message:@"提交成功!24小时后..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alertView show];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [alertView dismissWithClickedButtonIndex:0 animated:YES];
                
                StahallEvalutionDetailInfoViewController *stahallEvalutionDetail =[StahallEvalutionDetailInfoViewController new];
                stahallEvalutionDetail.isCouldSpeedModle = YES;
                
                stahallEvalutionDetail.showName = showNameTextField.text;
                stahallEvalutionDetail.showAddress = showAddressTextField.text;
                stahallEvalutionDetail.showTime = showTimeTextField.text;
                stahallEvalutionDetail.showAnotherTime = anotherTimeTextField.text;
                stahallEvalutionDetail.airPlane = airPlane.text;
                stahallEvalutionDetail.showPlace = showPlcae.text;
                stahallEvalutionDetail.starsList = tempMutablArray;
                stahallEvalutionDetail.isFirstPort = YES;
                stahallEvalutionDetail.valuationId = dict_data[@"valuationId"];
                
                [self.navigationController pushViewController:stahallEvalutionDetail animated:YES];
                
            });
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"error:%@",[error localizedDescription]);
            [ProgressHUD showError:@"网络错误"];
        }];
        
    }

}




#pragma mark - textField开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.35 animations:^{
        
        datePickerBackView.transform = CGAffineTransformMakeTranslation(0, -230);
        
    }];
    
    textField.inputView =[[UIView alloc]initWithFrame:CGRectZero];
 
}


#pragma mark - textfield代理
- (void)textFieldDidEndEditing:(UITextField *)textField{

  
    NSString *dateString =[dateFormatter stringFromDate:datePicker.date];
    
    NSString *todayString = [NSString stringWithFormat:@"%@",[NSDate date]];
    NSArray *timeArray =[todayString componentsSeparatedByString:@" "];
    NSString *timeString = [timeArray firstObject];
    
    if(![datePicker.date isInFuture] && ![todayString isEqualToString:timeString]){//过去时间
        
        [ProgressHUD showError:@"非法时间"];
        textField.text = nil;
        NSLog(@"过去时间");
        
    }else{//未来时间
        
        textField.text = dateString;
    }
    
    NSLog(@"date:%@",dateString);
    
    
    [UIView animateWithDuration:0.35 animations:^{
        
        datePickerBackView.transform = CGAffineTransformMakeTranslation(0, 230);
        
    }];
   
    
}


#pragma mark - section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

#pragma mark - cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{


    return [starsSelected count];
}

#pragma mark - 创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StahallEvalueCollectionViewCell *stahallEvalueCell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    stahallEvalueCell.delegate = self;
    if(!selected){
    
        stahallEvalueCell.deleteButton.hidden = YES;
    }else{
        
        if(indexPath.row!=[starsSelected count]-1){
        
            stahallEvalueCell.deleteButton.hidden = NO;
        }else{
        
            if([starsSelected count]!=20){
        
                stahallEvalueCell.deleteButton.hidden = YES;

            }else{
            
                stahallEvalueCell.deleteButton.hidden = NO;
            }
            
        }
        
    }

    if([starsSelected count]==1){//如果数据源只有一个数据
        
        stahallEvalueCell.addIcon.image =[UIImage imageNamed:@"fz加"];
        if(stahallEvalueCell.starHeaderImage.image){
        
            stahallEvalueCell.starHeaderImage.image = nil;
            stahallEvalueCell.starName.text = nil;
        }
        
    }else{//如果数据源超过一个数据
    
        NSInteger indexRow = [starsSelected count]-1;
        if(indexPath.row==indexRow){
        
            stahallEvalueCell.addIcon.image =[UIImage imageNamed:@"fz加"];
            if(stahallEvalueCell.starHeaderImage.image){
                
                stahallEvalueCell.starHeaderImage.image = nil;
                stahallEvalueCell.starName.text = nil;
            }
            
        }else{
        
            stahallEvalueCell.addIcon.image = nil;
        }
        
        if(indexRow==20 || ![[starsSelected lastObject]isKindOfClass:[NSString class]]){
        
            stahallEvalueCell.addIcon.image =nil;
        }
    }
    
//    stahallEvalueCell.starName.text = starsSelected[indexPath.row];
    
    
    
    if([starsSelected count]==9 || [starsSelected count]==13){
        
        [self.collectionView setContentOffset:CGPointMake(0, 120) animated:YES];
        
    }
    
    if([starsSelected count]==17){
        
        [self.collectionView setContentOffset:CGPointMake(0, 220) animated:YES];
    }

    
    //
   
    if([starsSelected count]>1){
        
        if(![starsSelected[indexPath.row] isKindOfClass:[NSString class]]){
        
            NSDictionary *starDict = starsSelected[indexPath.row];
            StarModel *starModel =[StarModel modelWithDictionary:starDict error:nil];
            [stahallEvalueCell.starHeaderImage sd_setImageWithURL:[NSURL URLWithString:starModel.header] placeholderImage:nil];
            stahallEvalueCell.starName.text = starModel.artistName;

        
        }
        
    }
    
  
    return stahallEvalueCell;
}


#pragma mark - 获取艺人名字代理方法
- (void)starNameInputName:(NSString *)inputName{

    NSLog(@"inputName:%@",inputName);
}


#pragma mark - cell被选中
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if(selected){
    
        return;
    }
    

    if(indexPath.row == [starsSelected count]-1 && [[starsSelected lastObject]isKindOfClass:[NSString class]]){//跳到选艺人界面

        StarHallViewController *staHallViewController =[StarHallViewController new];
        staHallViewController.delegate = self;
        staHallViewController.isSearchMode = YES;
        [self.navigationController pushViewController:staHallViewController animated:YES];
        
        NSLog(@"跳到挑选艺人界面");

    
    }else{//跳到艺人详情
    
        
        StarDetaiInfoViewController *starDetailInfo =[StarDetaiInfoViewController new];
        starDetailInfo.starDict = starsSelected[indexPath.row];
        StarModel *starModel =[StarModel modelWithDictionary:starDetailInfo.starDict error:nil];
        starDetailInfo.starId = starModel.artistId;
        
        [self.navigationController pushViewController:starDetailInfo animated:YES];
        NSLog(@"跳到艺人详情");
    }
    
}


#pragma mark - 删除按钮代理
- (void)deletaButtonClicked:(UICollectionViewCell *)cell andButton:(UIButton *)deleteButton{

    CGPoint buttonPosition =[deleteButton convertPoint:CGPointZero toView:self.collectionView];
    NSIndexPath *indexPath =[self.collectionView indexPathForItemAtPoint:buttonPosition];
    
    if([starsSelected count]>1){

        [starsSelected removeObjectAtIndex:indexPath.row];
        [self.collectionView reloadData];

    }
    
    if([starsSelected count]==1){
    
        [editable setTitle:@"编辑" forState:UIControlStateNormal];
        selected = NO;
        
    }
   
    
    NSLog(@"删除的indexPath:%ld",(long)indexPath.row);
}


#pragma mark - 获取来自下页选中的cells代理
- (void)theSelectedCells:(NSMutableArray *)selectedCells{

    NSLog(@"selected:%@",selectedCells);
    if([starsSelected count]<=20){
    
        [starsSelected removeLastObject];
        [starsSelected addObjectsFromArray:selectedCells];
        [starsSelected addObject:@"end"];

        
        if([starsSelected count]>20){
 
            [starsSelected removeObjectsInRange:NSMakeRange(20, [starsSelected count]-20)];
        
        }
        
        [self.collectionView reloadData];
       
    }
  
}





#pragma mark - 导航栏回退按钮触发
- (void)buttonClicked:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
    [ProgressHUD dismiss];
}

#pragma mark - view将要出现
- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:115/255.0 green:199/255.0 blue:228/255.0 alpha:1]];

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
