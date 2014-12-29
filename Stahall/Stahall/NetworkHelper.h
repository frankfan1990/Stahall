//
//  NetworkHelper.h
//  Stahall
//
//  Created by frankfan on 14/12/29.
//  Copyright (c) 2014年 Rching. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking/AFNetworking/AFNetworking.h"

static const NSString *text_html = @"text/html";
static const NSString *application_json = @"application/json";

@interface NetworkHelper : NSObject

+ (AFHTTPRequestOperationManager *)createRequestManagerWithContentType:(const NSString *)contentType;
@end
