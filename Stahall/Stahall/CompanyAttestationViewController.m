//
//  CompanyAttestationViewController.m
//  Stahall
//
//  Created by JM_Pro on 15-1-15.
//  Copyright (c) 2015年 Rching. All rights reserved.
//

#import "CompanyAttestationViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "Email_Phone.h"
#import "Marcos.h"
#import "AFNetworking.h"

#pragma mark - 公司认证
@interface CompanyAttestationViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    UITableView *_tableView;
    UIActionSheet *sheetView;
    
    NSArray *arrOfname;
    NSArray *arrOfContent;
    NSArray *arrOfKeys;
    
    UICollectionView *_colloectionView;
    UIImagePickerController *imagePicker;
    
    NSInteger cell_indexPath_row;
    NSIndexPath *myIndexPath;
    
    int btnindex;
    UITextField *_textField;
    
    NSMutableArray *arrOfImages;
    NSMutableArray *arrOfImage1;
    NSMutableArray *arrOfImage2;
    NSMutableArray *arrOfImage3;
    NSMutableArray *arrOfImage4;
    NSMutableArray *arrOfImage5;
    NSMutableArray *arrOfImage6;
    
    //
    NSMutableDictionary *datadic1;
    NSMutableDictionary *datadic2;

}
@property (nonatomic,strong)TPKeyboardAvoidingScrollView *tpscrollerView;
@end

@implementation CompanyAttestationViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setTabBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    datadic1 = [NSMutableDictionary dictionary];
    datadic2 = [NSMutableDictionary dictionary];
    arrOfname = [NSArray arrayWithObjects:@"公司名称",@"企业法人",@"公司申请人", @"申请人职位", @"固定电话",@"手机号码", nil];
    arrOfContent = @[@"税务登记证(只需要一张)",@"营业执照(只需要一张)",@"组织机构代码证(只需要一张)",@"法人身份证（请上传正反两面照片）",@"申请人身份证（请上传正反两面照片）",@"办公场所照片(需上传三张)"];
    arrOfKeys = @[@"companyName",@"LegalpersonName",@"ApplicantName",@"ApplicantPosition",@"Fixedtelephone",@"phoneNumber"];
    
    arrOfImages = [NSMutableArray array];
    arrOfImage1 = [NSMutableArray array];
    arrOfImage2 = [NSMutableArray array];
    arrOfImage3 = [NSMutableArray array];
    arrOfImage4 = [NSMutableArray array];
    arrOfImage5 = [NSMutableArray array];
    arrOfImage6 = [NSMutableArray array];
    
    [arrOfImages addObject:arrOfImage1];
    [arrOfImages addObject:arrOfImage2];
    [arrOfImages addObject:arrOfImage3];
    [arrOfImages addObject:arrOfImage4];
    [arrOfImages addObject:arrOfImage5];
    [arrOfImages addObject:arrOfImage6];
    
    
    self.tpscrollerView =[[TPKeyboardAvoidingScrollView alloc]initWithFrame:self.view.bounds];
    _tpscrollerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tpscrollerView];
    self.view.backgroundColor = [UIColor colorWithRed:81/255.0 green:185/255.0 blue:222/255.0 alpha:1];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, Myheight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.sectionFooterHeight = 0.1;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tpscrollerView addSubview:_tableView];
    
  
    
    imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //系统照片
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
    }else{
        //手机相册
        imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
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
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:114/255.0 green:190/255.0 blue:222/255.0 alpha:1]];
    
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
    title.text = @"公司认证";
    title.font = [UIFont systemFontOfSize:19];
    title.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = title;
    
}


#pragma mark - _tableView的代理
#pragma mark - 好多section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrOfContent.count+1;
}
#pragma mark - 每一个section好多cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 if (section > 0){
        return 1;
    }else {
        return arrOfname.count;
    }
}

#pragma mark -  头部的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section > 1) {
        return 20;
    }
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == arrOfContent.count) {
        return 100;
    }
    return 0.01;
}
#pragma mark -  cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
   if (indexPath.section >0){
        return 145;
    } else{
        return 45;
    }
    
}

#pragma mark -  头headView
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 20)];
    headView.backgroundColor = [UIColor clearColor];
    return headView;
}

#pragma mark -  footView
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == arrOfContent.count) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 100)];
        footView.backgroundColor = [UIColor clearColor];
        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        nextBtn.frame = CGRectMake(60, 25, Mywidth-120, 40);
        nextBtn.backgroundColor = [UIColor colorWithRed:78/255.0 green:218/255.0 blue:68/255.0 alpha:1];
        
        nextBtn.layer.masksToBounds = YES;
        nextBtn.layer.cornerRadius = 20;
        [nextBtn setTitle:@"申请认证" forState:UIControlStateNormal];
        [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [nextBtn addTarget:self action:@selector(didNextBtn) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:nextBtn];
        
        return footView;
    }
    return nil;
}

#pragma mark -  cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section > 0){
        static NSString *str2 = @"cell2";
        UITableViewCell *cell2 = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:str2];
        if (cell2 == nil) {
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            cell2.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(10, 10, Mywidth-10, 20);
            label.tag = 10001;
            [self Customlable:label text:nil fontSzie:16 textColor:[UIColor colorWithRed:22/255.0 green:89/255.0 blue:134/255.0 alpha:1] textAlignment:NSTextAlignmentLeft adjustsFontSizeToFitWidth:NO numberOfLines:1];
            [cell2.contentView addSubview:label];
            
            UICollectionViewFlowLayout *laytoutView = [[UICollectionViewFlowLayout alloc] init];
            laytoutView.itemSize = CGSizeMake(90, 80);
            laytoutView.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
            [laytoutView setScrollDirection:UICollectionViewScrollDirectionHorizontal];
            UICollectionView *colloectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 35, Mywidth, 110) collectionViewLayout:laytoutView];
            colloectionView.delegate = self;
            colloectionView.dataSource = self;
            colloectionView.tag = 10006;
            colloectionView.backgroundColor = [UIColor clearColor];
            [colloectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"My_cell"];
            [cell2.contentView addSubview:colloectionView];
        }
        
        UILabel *label  = (UILabel*)[cell2.contentView viewWithTag:10001];
        label.text = arrOfContent[indexPath.section-1];

        return cell2;
    }else{
        
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
            
 
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mywidth, 0.5)];
            line.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
            line.tag = 114;
            [cell1.contentView addSubview:line];
            
        }
        
        UIView *line = (UIView *)[cell1.contentView viewWithTag:114];
        if (indexPath.row == 0) {
            line.hidden = YES;
        }else{
            line.hidden = NO;
        }
        
        UILabel *label = (UILabel *)[cell1.contentView viewWithTag:112];
        UITextField *feild = (UITextField *)[cell1.contentView viewWithTag:113];
          feild.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"请输入%@",arrOfname[indexPath.row]] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

        label.text = arrOfname[indexPath.row];
        feild.text = datadic1[arrOfKeys[indexPath.row]];
        return cell1;
    }
    
}



#pragma mark -  UICollectionView的代理
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   
    //下面代码是确定点击的哪一个UICollectionView
    CGPoint position = [collectionView convertPoint:CGPointZero toView:_tableView];
    NSIndexPath *index = [_tableView indexPathForRowAtPoint:position];
    
    return [arrOfImages[index.section-1] count]+1;

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //下面代码是确定点击的哪一个UICollectionView
    CGPoint position = [collectionView convertPoint:CGPointZero toView:_tableView];
    NSIndexPath *index = [_tableView indexPathForRowAtPoint:position];
    
    UICollectionViewCell *cell_my = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"My_cell" forIndexPath:indexPath];
    
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 80)];
    if (indexPath.row == [arrOfImages[index.section-1] count])
    {
        cell_my.tag = 555;
        image1.image = [UIImage imageNamed:@"lc添加照片"];
    }
    else
    {
        image1.image = arrOfImages[index.section-1][indexPath.row];
    }
    
    cell_my.backgroundView = image1;
    
    if ((index.section-1)< 3) {
        if (indexPath.row >0) {
            cell_my.hidden = YES;
        }else{
            cell_my.hidden = NO;
        }
    }else if((index.section-1)< 5){
        if (indexPath.row >1) {
            cell_my.hidden = YES;
        }else{
           cell_my.hidden = NO;
        }
    }else if((index.section-1) == 5){
        if (indexPath.row > 2) {
            cell_my.hidden = YES;
        }else{
           cell_my.hidden = NO;
        }
    }
    
    
    return cell_my;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [_textField resignFirstResponder];
    
    //下面四行代码是确定点击的哪一个UICollectionView
    CGPoint position = [collectionView convertPoint:CGPointZero toView:_tableView];
    NSIndexPath *index = [_tableView indexPathForRowAtPoint:position];
    myIndexPath = index;
    UITableViewCell  *mytableViewcell = [_tableView cellForRowAtIndexPath:index];
    _colloectionView  = (UICollectionView *)[mytableViewcell.contentView viewWithTag:10006];

    
    //用一个数记住点的是哪一个cell
    cell_indexPath_row = indexPath.row;
    btnindex = 10;
    
    if (indexPath.row == [arrOfImages[myIndexPath.section-1] count]) {
         sheetView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
        btnindex = 10;
    }else {
          sheetView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", @"删除",nil];
        btnindex = 2;
    }
    
    
    
    [sheetView showInView:self.view];
}

#pragma mark - UIImagePickerController代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    
    //    imagev.image=[info objectForKey:UIImagePickerControllerOriginalImage];
//    NSIndexPath *index = [NSIndexPath indexPathForRow:cell_indexPath_row inSection:0];
    
    if (cell_indexPath_row == [arrOfImages[myIndexPath.section-1] count]) {
        [arrOfImages[myIndexPath.section-1] addObject:[info objectForKey:UIImagePickerControllerOriginalImage]];
//        [_colloectionView insertItemsAtIndexPaths:@[index]];
        [_colloectionView reloadData];
       
    }else
    {
        [arrOfImages[myIndexPath.section-1] removeObjectAtIndex:cell_indexPath_row];
        [arrOfImages[myIndexPath.section-1] insertObject:[info objectForKey:UIImagePickerControllerOriginalImage] atIndex:cell_indexPath_row];
//        [_colloectionView reloadItemsAtIndexPaths:@[index]];
        [_colloectionView reloadData];
       
        
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
    }else if (buttonIndex == btnindex){
        
        NSIndexPath * indexpath = [NSIndexPath indexPathForRow:cell_indexPath_row inSection:0];
        if (indexpath.row < [arrOfImages[myIndexPath.section-1] count]) {
            [arrOfImages[myIndexPath.section-1] removeObjectAtIndex:cell_indexPath_row];
            //    [_colloectionView deleteItemsAtIndexPaths:@[indexpath]];
            [_colloectionView reloadData];
        }
    }
    
}






#pragma mark - textField代理
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - textField代理
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _textField = textField;
    CGPoint position = [textField convertPoint:CGPointZero toView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:position];
    myIndexPath = indexPath;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (myIndexPath.section == 0) {
        [datadic1 setObject:textField.text forKey:arrOfKeys[myIndexPath.row]];
    }
   
}

#pragma mark - 点击申请认证
-(void)didNextBtn
{
    [_textField resignFirstResponder];
     NSString * msg;
    for (int i = 0; i< arrOfKeys.count; i++) {
       
        if (![datadic1[arrOfKeys[i]] length]) {
            msg = [NSString stringWithFormat:@"\n请输入%@",arrOfname[i]];
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            break;
        }
       
    }
    if ([msg length]) {
        return;
    }

    if (!isValidatePhone(datadic1[arrOfKeys[5]])){
        msg = @"\n请输入正确的手机号";
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    
    NSLog(@"%@",datadic1);
    
}

#pragma mark - 返回
-(void)didGoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
