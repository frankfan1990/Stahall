//
//  StarHallViewController.h
//  Stahall
//
//  Created by frankfan on 14/12/14.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SendTheSelectedCellsDelegate<NSObject>

@optional
- (void)theSelectedCells:(NSMutableArray *)selectedCells;

@end

@interface StarHallViewController : UIViewController

@property (nonatomic,assign)BOOL isSearchMode;//标志位
@property (nonatomic,weak)id<SendTheSelectedCellsDelegate>delegate;

@property (nonatomic,strong)NSMutableArray *reciveTheHasSelecedStars;//接受上个页面传下来的已选艺人
@end
