//
//  HTTPMethods.m
//  Hotchpotch
//
//  Created by Harry on 15/8/3.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "HTTPManager.h"

#import "HTTPRequest.h"

@implementation HTTPManager

+ (void)getWeixinJingxuanPageIndex:(NSInteger)pageIndex
                           success:(httpRequestSuccess)success
                           failure:(httpRequestFailure)failure{
    [[HTTPRequest shareInstance] GETURLString:@"181-1" parameters:@{@"page" : @(pageIndex)} success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObj) {
        
        DLog(@"response : %@",operation.responseString);
        success(responseObj);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error.description);
    }];
}

@end
