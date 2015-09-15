//
//  HTTPMethods.h
//  Hotchpotch
//
//  Created by Harry on 15/8/3.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

/******************************************************************************************************
 *  1.所有网络请求方法都在这里
 ****************************************************************************************************/

#import <Foundation/Foundation.h>

#pragma mark -返回码
static NSString* const HTTPManagerRequestSuccessReturnCode = @"000000";//请求成功返回码

///上传文件的业务标识
typedef NS_ENUM(NSInteger, POST_FILE_BIZCODE_TYPE) {
    POST_FILE_BIZCODE_USERDYNAMIC,  //member.userDynamic:动态信息文件
    POST_FILE_BIZCODE_USERPHOTO,    //member.userPhoto:用户头像 文件
};

///上传文件的文件类型
typedef NS_ENUM(NSInteger, POST_FILE_FILE_TYPE) {
    POST_FILE_FILE_VOIDE = 0,    //0:视频 1:图片
    POST_FILE_FILE_PHOTO,    //0:视频 1:图片
};

typedef void(^ httpRequestSuccess)(id responseObject);
typedef void(^ httpRequestFailure)(NSString *errorResult);

@interface HTTPManager : NSObject

//DEMO
+ (void)getWeixinJingxuanPageIndex:(NSInteger)pageIndex
                           success:(httpRequestSuccess)success
                           failure:(httpRequestFailure)failure;

@end
