//
//  EvalutionDetailModel.h
//  Stahall
//
//  Created by frankfan on 15/1/12.
//  Copyright (c) 2015年 Rching. All rights reserved.
//
#pragma mark - 估价详情

#import "MTLModel.h"

@interface EvalutionDetailModel : MTLModel

@property (nonatomic, strong) NSString *showTime;
@property (nonatomic, strong) NSArray *valuationRelevances;
@property (nonatomic, assign) double urgent;
@property (nonatomic, assign) id artistIds;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *showAddress;
@property (nonatomic, strong) NSString *alternativeTime;
@property (nonatomic, strong) NSString *valuationId;
@property (nonatomic, strong) NSString *showVenues;
@property (nonatomic, strong) NSString *directArport;
@property (nonatomic, assign) id businessId;
@property (nonatomic, strong) NSString *showName;
@property (nonatomic, assign) double status;
@end
