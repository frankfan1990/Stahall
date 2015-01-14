//
//  EvalutionStarsDetail.h
//  Stahall
//
//  Created by frankfan on 15/1/12.
//  Copyright (c) 2015年 Rching. All rights reserved.
//
#pragma mark - 估价艺人-艺人个人数据

#import "MTLModel.h"

@interface EvalutionStarsDetail : MTLModel

@property (nonatomic, strong) NSString *artistId;
@property (nonatomic, assign) double showRate;
@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSString *showTime;
@property (nonatomic, strong) NSString *alternativeTime;
@property (nonatomic, assign) double alternativeRate;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSString *relevanceId;
@property (nonatomic, strong) NSString *valuationId;

@end
