//
//  HTTPMethods.m
//  Hotchpotch
//
//  Created by Harry on 15/8/3.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "HDHTTPManager.h"

#import "HDHTTPSessionRequest.h"

@implementation HDHTTPManager

+ (void)getWeixinJingxuanPageIndex:(NSInteger)pageIndex
                           success:(httpRequestSuccess)success
                           failure:(httpRequestFailure)failure{
    [[HDHTTPSessionRequest shareInstance] post:@"181-1"
                                     paramters:@{@"page" : @(pageIndex)}
                                 configHandler:nil
                                       success:^(NSURLSessionDataTask *httpbase, id responseObject) {
                                           success(responseObject);
                                       }
                                       failure:^(NSURLSessionDataTask *httpbase, NSError *error) {
                                           
                                       }];
}

@end
