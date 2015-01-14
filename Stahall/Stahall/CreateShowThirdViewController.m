//
//  CreateShowThirdViewController.m
//  Stahall
//
//  Created by JM_Pro on 14-12-23.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "CreateShowThirdViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "MyShowViewController.h"
#import "AFNetworking.h"
#import "ProgressHUD.h"
#import "Marcos.h"
@interface CreateShowThirdViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    UITableView *_tableView;
    UIActionSheet *sheetView;
    NSArray *arrOfrule;
    NSMutableArray *arrOfname;
    UICollectionView *_colloectionView;
    UIImagePickerController *imagePicker;
    NSMutableArray *arrOfImages;
    NSInteger cell_indexPath_row;
    
    UITextField *field1;
    UITextField *field2;
    
    UIButton *btnLeft;
    
}
@property (nonatomic,strong)TPKeyboardAvoidingScrollView *tpscrollerView;
@end

@implementation CreateShowThirdViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [ProgressHUD dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    arrOfrule = @[@"艺人到达演出会场如发现演出名称与实际不符，有权拒绝演出",@"艺人到达演出会场如发现演出名称与实际不符，有权拒绝演出艺人到达演出会场如发现演出名称与实际不符，有权拒绝演出"];
    arrOfname = [NSMutableArray arrayWithObjects:@"申请人",@"所在公司", nil];
    
    self.tpscrollerView =[[TPKeyboardAvoidingScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.tpscrollerView];
    self.view.backgroundColor = [UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.sectionFooterHeight = 0.1;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tpscrollerView addSubview:_tableView];
    
    sheetView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //系统照片
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
    }else{
        //手机相册
        imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    arrOfImages = [NSMutableArray array];
    imagePicker.delegate = self;

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
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1]];
    
    
    btnLeft = [UIButton buttonWithType:UIButtonTypeSystem];
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
    title.text = @"商业演出";
    
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}



#pragma mark - _tableView的代理
#pragma mark - 好多section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
#pragma mark - 每一个section好多cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return arrOfrule.count;
    }else if (section == 1){
        return 1;
    }else {
        return arrOfname.count;
    }
}

#pragma mark -  头部的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 90;
    }else if (section == 1){
        return 35;
    } else{
        return 25;
    }
    
}

#pragma mark -  cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 20+[self caculateTheTextHeight:arrOfrule[indexPath.row] andFontSize:14 andDistance:Mywidth-65];
    }else if (indexPath.section ==1){
        return 150;
    } else{
        return 45;
    }
    
}

#pragma mark -  头部
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 2) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 20)];
        headView.backgroundColor = [UIColor clearColor];
        return headView;
    }else{
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 80-5)];
        headView.backgroundColor = [UIColor clearColor];
        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        nextBtn.frame = CGRectMake(60, 32-5, Mywidth-120, 40);
        nextBtn.backgroundColor = [UIColor colorWithRed:78/255.0 green:218/255.0 blue:68/255.0 alpha:1];
        nextBtn.layer.masksToBounds = YES;
        nextBtn.layer.cornerRadius = 20;
        [nextBtn setTitle:@"申请创建演出" forState:UIControlStateNormal];
        [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [nextBtn addTarget:self action:@selector(didNextBtn) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:nextBtn];
        return headView;
    }
}

#pragma mark -  cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 1){
        
        UITableViewCell *cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 0, Mywidth-10, 30);
        [self Customlable:label text:@"授权书/委托函" fontSzie:16 textColor:[UIColor colorWithRed:22/255.0 green:89/255.0 blue:134/255.0 alpha:1] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
        [cell2.contentView addSubview:label];
        
        UICollectionViewFlowLayout *laytoutView = [[UICollectionViewFlowLayout alloc] init];
        laytoutView.itemSize = CGSizeMake(90, 80);
        laytoutView.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        [laytoutView setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _colloectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, Mywidth, 110) collectionViewLayout:laytoutView];
        _colloectionView.delegate = self;
        _colloectionView.dataSource = self;
        _colloectionView.backgroundColor = [UIColor clearColor];
        [_colloectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"My_cell"];
        [cell2.contentView addSubview:_colloectionView];
        
        return cell2;
    }
    else if(indexPath.section == 2){
        static NSString * cellName = @"cell3";
        UITableViewCell *cell3 = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell3 == nil) {
            cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            cell3.selectionStyle = UITableViewCellSelectionStyleNone;
            cell3.backgroundColor = [UIColor clearColor];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, Mywidth-65, [self caculateTheTextHeight:arrOfrule[indexPath.row] andFontSize:14 andDistance:Mywidth-65])];
            label.tag = 1114;
            [self Customlable:label text:@"" fontSzie:14 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:100];
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(22, label.frame.origin.y+6, 10, 10)];
            view.backgroundColor = [UIColor whiteColor];
            view.alpha = 0.9;
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = view.frame.size.width/2;
            [cell3.contentView addSubview:view];
            [cell3.contentView addSubview:label];
        }
        UILabel *label = (UILabel *)[cell3.contentView viewWithTag:1114];
        label.text = arrOfrule[indexPath.row];
        return cell3;
    }
    else{
        static NSString *str = @"cell1";
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            cell1.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 10,120, 25)];
            [self Customlable:label text:@"" fontSzie:15 textColor:[UIColor colorWithRed:22/255.0 green:89/255.0 blue:134/255.0 alpha:1] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
            label.tag = 112;
            
            UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, Mywidth-135, 25)];
            field.userInteractionEnabled = YES;
            field.delegate = self;
            field.textColor = [UIColor whiteColor];
            field.textAlignment = NSTextAlignmentRight;
            field.font = [UIFont systemFontOfSize:15];
            field.returnKeyType = UIReturnKeyDone;
            field.tag = 113;
            [cell1.contentView addSubview:label];
            [cell1.contentView addSubview:field];
            
            if (indexPath.row != 0) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 0.5)];
                line.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
                [cell1.contentView addSubview:line];
            }
        }
        
        
        UILabel *label = (UILabel *)[cell1.contentView viewWithTag:112];
        UITextField *feild = (UITextField *)[cell1.contentView viewWithTag:113];
        
        if (indexPath.row == 0) {
            feild.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入申请人名字" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
            field1 = feild;
        }else if (indexPath.row == 1){
            feild.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入所在公司名称" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
            field2 = feild;
        }
        label.text = arrOfname[indexPath.row];
        return cell1;
    }
    
}



#pragma mark -  UICollectionView的代理
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrOfImages.count + 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell_my = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"My_cell" forIndexPath:indexPath];
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didlong:)];
    [cell_my addGestureRecognizer:longPress];
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 80)];
        if (indexPath.row == arrOfImages.count)
        {
            cell_my.tag = 555;
            image1.image = [UIImage imageNamed:@"lc添加照片"];
        }
        else
        {
            if ([arrOfImages[indexPath.row] isKindOfClass:[UIImage class]]) {
                image1.image = arrOfImages[indexPath.row];
            }
            else{
                image1.image = [UIImage imageNamed:arrOfImages[indexPath.row]];
            }
        }
    
    cell_my.backgroundView = image1;
    
    return cell_my;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //用一个数记住点的是哪一个cell
    cell_indexPath_row = indexPath.row;
    
    [sheetView showInView:self.view];
}

#pragma mark - UIImagePickerController代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    imagev.image=[info objectForKey:UIImagePickerControllerOriginalImage];
    NSIndexPath *index = [NSIndexPath indexPathForRow:cell_indexPath_row inSection:0];
    if (cell_indexPath_row == arrOfImages.count) {
        [arrOfImages addObject:[info objectForKey:UIImagePickerControllerOriginalImage]];
        [_colloectionView insertItemsAtIndexPaths:@[index]];
    }else
    {
        [arrOfImages removeObjectAtIndex:cell_indexPath_row];
        [arrOfImages insertObject:[info objectForKey:UIImagePickerControllerOriginalImage] atIndex:cell_indexPath_row];
        [_colloectionView reloadItemsAtIndexPaths:@[index]];
        
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - sheetView的代理
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.showsCameraControls = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }else if (buttonIndex == 1){
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
}

#pragma mark - textField代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - 返回
-(void)didGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 创建演出按钮
-(void)didNextBtn
{
    
    if (![field1.text length]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"\n请填写申请人" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }else if (![field2.text length]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"\n请填写所在公司" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }else if (arrOfImages.count<2) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"\n请至少上传两张照片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    [ProgressHUD show:@"正在提交" Interaction:NO];
    btnLeft.userInteractionEnabled = NO;
    
    /*
     
    图片上传
     
    */
    __block NSString *dataStr=[NSString string];
    __block NSInteger count = 0;
    __weak typeof (self)mySelf = self;
    for (int i =0; i<arrOfImages.count; i++) {
        
        AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json", nil];
        
        [manager POST:ImageUpLoadIP parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            NSData *data = UIImageJPEGRepresentation(arrOfImages[i], 0.8);
            [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"image_d.jpg"] mimeType:@"image/jpeg"];
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict = responseObject;
            if ([dict[@"success"] intValue] == 1) {
                count++;
                if ([dataStr length]) {
                    dataStr = [NSString stringWithFormat:@"%@,%@",dataStr,dict[@"data"]];
                }else{
                    dataStr = dict[@"data"];
                }
                
                if (count == arrOfImages.count) {
                    [mySelf postPlist:dataStr];
                }
                
            }
           
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [ProgressHUD dismiss];
            btnLeft.userInteractionEnabled = YES;
            UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"图片上传失败" message:@"\n请检查网络设置" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [aler show];
        }];
    }

}

-(void)postPlist:(NSString *)dataStr
{
    
    [_dictData setObject:dataStr forKey:@"businessLicense"];
    [_dictData setObject:@"0" forKey:@"status"];//状态
    [_dictData setObject:@"47e92fdc-d546-46c9-af66-436568094d5c" forKey:@"businessId"];// 演出商编号 登陆信息给出
    [_dictData setObject:field1.text forKey:@"applicant"];
    [_dictData setObject:field2.text forKey:@"company"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    
    __weak typeof (self)Myself = self;
    [manager POST:AddNewShowIP parameters:_dictData success:^(AFHTTPRequestOperation *operation, id responseObject) {
        btnLeft.userInteractionEnabled = YES;
        NSDictionary *dict = responseObject;
        if ([dict[@"success"] intValue] == 1) {
            [ProgressHUD showSuccess:@"提交成功"];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                MyShowViewController *myShowCtrl = Myself.navigationController.viewControllers[Myself.navigationController.viewControllers.count-4];
                [myShowCtrl getData];
                [Myself.navigationController popToViewController:myShowCtrl animated:YES];
                
            });
            
        }else{
            [ProgressHUD dismiss];
            UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"提交失败" message:@"\n网络异常" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [aler show];
        }
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD dismiss];
         btnLeft.userInteractionEnabled = YES;
        UIAlertView *aler=[[UIAlertView alloc] initWithTitle:@"提交失败" message:@"\n请检查网络设置" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [aler show];
        NSLog(@"%@",error);
    }];
    
    //    [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count-4] animated:YES];

}

#pragma mark - 长按删除
-(void)didlong:(UILongPressGestureRecognizer *)longpress
{
    if(longpress.state == UIGestureRecognizerStateBegan)
    {
        UICollectionViewCell *cell = (UICollectionViewCell *)longpress.view
        ;
        NSIndexPath * indexpath = [_colloectionView indexPathForCell:cell];
        if (indexpath.row < arrOfImages.count) {
            [arrOfImages removeObjectAtIndex:indexpath.row];
            [_colloectionView deleteItemsAtIndexPaths:@[indexpath]];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 根据字长算 高度或宽度
- (CGFloat)caculateTheTextHeight:(NSString *)string andFontSize:(int)fontSize andDistance:(CGFloat)distance{
    
    /*非彻底性封装*/
    CGSize constraint = CGSizeMake(distance, CGFLOAT_MAX);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontSize] forKey:NSFontAttributeName];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:string
     attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    return size.height;
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
