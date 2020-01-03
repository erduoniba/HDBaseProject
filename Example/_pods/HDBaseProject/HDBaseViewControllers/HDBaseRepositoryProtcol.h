//
//  HDBaseRepositoryProtcol.h
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/9/30.
//

#if __has_include(<midea_common_network/HDNetworking.h>)
    #import <midea_common_network/HDNetworking.h>
#else
    #import "HDNetworking.h"
#endif

@protocol HDBaseRepositoryProtcol <NSObject>

/**
 请求的URL，已经添加baseURL

 @return 请求的URL，已经添加baseURL
 */
- (NSString *_Nullable)hdRequestURL;

/**
 返回的数据是哪个类，必须是HDBaseModel的子类

 @return 数据类型
 */
- (Class _Nullable)hdResposeClass;

@optional
/**
 请求的方法，默认是GET

 @return 请求的方法，默认是GET
 */
- (HDRequestMethod)HDRequestMethodType;

/**
 请求的参数

 @return 请求的参数，默认返回通用的参数
 */
- (NSDictionary *_Nullable)hdRequestParamters;


/**
 缓存数据的惟一标示，用于清除缓存，一般使用id=123456形式

 @return 缓存数据的惟一标示
 */
- (NSString *_Nullable)hdRequestIdentifier;

/**
 请求的一些配置，子类初始化的时候会做统一的配置，子类需要特殊需要实现该协议

 @param configuration 请求的一些配置
 */
- (void)hdRequestConfiguration:(HDRequestManagerConfig *_Nullable)configuration;

@end
