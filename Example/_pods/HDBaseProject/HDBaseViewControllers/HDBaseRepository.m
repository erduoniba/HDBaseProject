//
//  HDBaseRepository.m
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/9/17.
//
//

#import "HDBaseRepository.h"

#import "HDBaseModel.h"

@interface HDBaseRepository ()

@property (nonatomic, strong) HDRequestConvertManager *requestConvertManager;
@property (nonatomic, strong) HDRequestManagerConfig *configuration;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation HDBaseRepository

- (instancetype)init {
    self = [super init];
    if (self) {
        self.requestConvertManager = [HDRequestConvertManager sharedInstance];

        [self initialConfig];
    }
    return self;
}

- (void)initialConfig {
    //添加我们需要的类型，接口返回的是 text/html
    [self.requestConvertManager.configuration.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

    [self.requestConvertManager setLoggerLevel:AFLoggerLevelInfo];

    //通过configuration来统一处理输出的数据，比如对token失效处理、对需要重新登录拦截
    self.requestConvertManager.configuration.resposeHandle = ^id (NSURLSessionTask *dataTask, id responseObject) {
        return responseObject;
    };

    self.configuration = self.requestConvertManager.configuration;
}

- (void)setBaseURL:(NSString *)baseURL {
    _baseURL = baseURL;
    self.requestConvertManager.configuration.baseURL = baseURL;
}


#pragma mark - HDBaseViewModelProtocol
- (NSString *)hdRequestURL {
    NSAssert(NO, @"子类需要实现该协议");
    return @"";
}

- (Class)hdResposeClass {
    NSAssert(NO, @"子类需要实现该协议");
    return [HDBaseModel class];
}

- (HDRequestMethod)hdRequestMethodType {
    return HDRequestMethodGet;
}

- (NSDictionary *)hdRequestParamters {
    //通过configuration来设置通用的请求体
    NSMutableDictionary *builtinBodys = [NSMutableDictionary dictionary];
    return builtinBodys;
}

- (NSString *)hdRequestIdentifier {
    return nil;
}

- (void)hdRequestConfiguration:(HDRequestManagerConfig *)configuration {

}

- (void)requestCache:(HDRequestManagerCache _Nullable )cache
             success:(HDRequestManagerSuccess _Nullable )success
             failure:(HDRequestManagerFailure _Nullable )failure {
    id (^disposeJsonResponse)(id) = ^ id (id jsonResponse) {
        Class resposeClass = [self hdResposeClass];
        if ([resposeClass conformsToProtocol:@protocol(HDBaseModelJsonResponseToModel)]) {
            if ([resposeClass respondsToSelector:@selector(disposeJsonRepose:)]) {
                id response = [resposeClass performSelector:@selector(disposeJsonRepose:) withObject:jsonResponse];
                return response;
            }
            else {
                NSLog(@"⚠️ 虽然model遵循了HDBaseModelJsonResponseToModel协议，但是model却没有实现disposeJsonRepose:方法。⚠️");
                return jsonResponse;
            }
        }
        return jsonResponse;
    };

    _dataTask = [self.requestConvertManager requestMethod:[self hdRequestMethodType]
                                                URLString:[self hdRequestURL]
                                               parameters:[self hdRequestParamters]
                                     configurationHandler:^(HDRequestManagerConfig * _Nullable configuration) {
                                         [self hdRequestConfiguration:configuration];
                                     } cache:^(id  _Nullable responseObject) {
                                         cache(disposeJsonResponse(responseObject));
                                     } success:^(NSURLSessionTask * _Nullable httpbase, id  _Nullable responseObject) {
                                         success(httpbase, disposeJsonResponse(responseObject));
                                     } failure:^(NSURLSessionTask * _Nullable httpbase, HDError * _Nullable error) {
                                         failure(httpbase, error);
                                     }];
}

- (void)canncel {
    [_dataTask cancel];
}

/**
 清除该url下所有的缓存数据，例如该方法可以清除所有商品详情下的缓存
 */
- (void)clearRequestUrlCache {
    [_requestConvertManager clearRequestCache:[self hdRequestURL]];
}

/**
 清除该url下，指定的缓存数据，例如该方法可以清除商品详情id=123456的缓存数据
 */
- (void)clearRequestUrlAndFormulateCache {
    [_requestConvertManager clearRequestCache:[self hdRequestURL] identifier:[self hdRequestIdentifier]];
}

/**
 清除网络缓存的所有数据
 */
- (void)clearAllCache {
    [_requestConvertManager clearAllCache];
}

@end
