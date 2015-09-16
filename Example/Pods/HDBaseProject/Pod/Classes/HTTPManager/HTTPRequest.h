//
//  HTTPRequest.h
//  Shop
//
//  Created by Harry on 13-12-25.
//  Copyright (c) 2013年 Harry. All rights reserved.
//

/************************************************************************************************************
 *  1.继承AFHTTPRequestOperationManager，能获取他的属性和方法；
 *
 *  2.网络请求类，有标准得GET POST PUT DELETE；
 *
 *  3.可以在 GET POST PUT DELETE 中的timeout方法中设置request的一些属性，比如缓存策略，缓存地址，http头部等等。。。
 *
 *  4.可以通过设置 OfficialEnvironment 的值来切换网络环境；
 *
 *  5.每次请求都包含了例行请求数据，比如 mac地址，请求时间戳，token等等。。。
 *
 *  6.所有请求都是异步处理，若要实现同步，则需要实现线程堵塞处理
 *
 *  7.快速的到项目缓存数据及清空缓存，快速的到当前网络状态
 ************************************************************************************************************/

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>

#define kGeneralServiceURL			@"http://lixin.ecs31.tomcats.pw"   //通用服务

#define BaseDemain          @"http://112.74.26.160"

#define DefineTimeout       20.0
#define PAGESIZE           @"20"

#ifdef DEBUG
#define DLog(...) NSLog(__VA_ARGS__)
#else
#define DLog(...)
#endif


@interface HTTPRequest : AFHTTPRequestOperationManager

@property (nonatomic, strong) NSData *sessionCookies;

+ (instancetype)shareInstance;

//内存缓存：默认为4M，可以提高url加载速度，但是当内存过大时，会影响运行速度
/**
 *  获取内存缓存大小
 *
 *  @return 获取内存缓存大小
 */
+ (NSUInteger)getCacheData;

/**
 *  清除内存缓存（不建议）
 */
+ (void)clearAllCacheData;

//cookies保存
- (void)saveCookies;
- (void)loadCookies;

// GET： timeout默认为20秒 ,默认有缓存
- (void)GETURLString:(NSString *)URLString
          parameters:(NSDictionary *)parameters
             success:(void (^)(AFHTTPRequestOperation *operation,id responseObj))success
             failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;

// GET： timeout自定义设置，也可以在方法实现中设置request（比如缓存策略）,默认有缓存
- (void)GETURLString:(NSString *)URLString
         withTimeOut:(CGFloat )timeout
          parameters:(NSDictionary *)parameters
             success:(void (^)(AFHTTPRequestOperation *operation,id responseObj))success
             failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;

// GET： timeout自定义设置，也可以在方法实现中设置request（比如缓存策略）,默认无缓存
- (void)GETURLString:(NSString *)URLString
           userCache:(BOOL)isCache
          parameters:(NSDictionary *)parameters
             success:(void (^)(AFHTTPRequestOperation *operation,id responseObj))success
             failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))failure;

//POST
- (void)POSTURLString:(NSString *)URLString
           parameters:(NSDictionary *)parameters
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)POSTURLString:(NSString *)URLString
          withTimeout:(CGFloat )timeout
           parameters:(NSDictionary *)parameters
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)POSTURLString:(NSString *)URLString
           parameters:(NSDictionary *)parameters
            imageData:(NSData *)data
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

//PUT
- (void )PUTURLString:(NSString *)URLString
           parameters:(NSDictionary *)parameters
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void )PUTURLString:(NSString *)URLString
          withTimeout:(CGFloat )timeout
           parameters:(NSDictionary *)parameters
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

//DELETE
- (void )DELETEURLString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void )DELETEURLString:(NSString *)URLString
             withTimeout:(CGFloat )timeout
              parameters:(NSDictionary *)parameters
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
