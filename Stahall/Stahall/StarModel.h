//
//  StarModel.h
//  Stahall
//
//  Created by frankfan on 14/12/29.
//  Copyright (c) 2014年 Rching. All rights reserved.
//
//FIXME: 艺人数据层对象

#import "MTLModel.h"

@interface StarModel : MTLModel

@property (nonatomic, strong) NSString *languageName;
@property (nonatomic, strong) NSString *areaName;
@property (nonatomic, assign) id pagesViews;
@property (nonatomic, assign) id typeName;
@property (nonatomic, assign) id company;
@property (nonatomic, assign) double appearanceFees;
@property (nonatomic, assign) double rangeId;
@property (nonatomic, assign) double sex;
@property (nonatomic, strong) NSString *artistId;
@property (nonatomic, assign) id region;
@property (nonatomic, assign) id hotName;
@property (nonatomic, assign) double areaId;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSString *rangeName;
@property (nonatomic, assign) id hotId;
@property (nonatomic, assign) id appearanceFee;
@property (nonatomic, assign) id provinceName;
@property (nonatomic, assign) double provinceId;
@property (nonatomic, assign) id head;
@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSString *labelName;
@property (nonatomic, strong) NSString *introduction;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, assign) id typeId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userId;

@end
