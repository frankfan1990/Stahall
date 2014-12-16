//
//  StahallEvalueCollectionViewCell.h
//  Stahall
//
//  Created by frankfan on 14/12/16.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol StarNameInput <NSObject>

@optional
- (void)starNameInputName:(NSString *)inputName;
- (void)deletaButtonClicked:(UICollectionViewCell *)cell andButton:(UIButton *)deleteButton;

@end


@interface StahallEvalueCollectionViewCell : UICollectionViewCell<UITextFieldDelegate>

@property (nonatomic,strong)UIImageView *starHeaderImage;//艺人头像
@property (nonatomic,strong)UIButton *deleteButton;//删除按钮
@property (nonatomic,strong)UITextField *starName;//艺人姓名
@property (nonatomic,strong)UIImageView *addIcon;

@property (nonatomic,assign)id<StarNameInput>delegate;
@end
