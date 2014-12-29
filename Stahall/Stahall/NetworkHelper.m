//
//  NetworkHelper.m
//  Stahall
//
//  Created by frankfan on 14/12/29.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import "NetworkHelper.h"


@implementation NetworkHelper

+ (AFHTTPRequestOperationManager *)createRequestManagerWithContentType:(const NSString *)contentType{

    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:contentType];
    return manager;
}
@end
