//
//  HDBaseRepository.h
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/9/17.
//
//

#import <Foundation/Foundation.h>

#import "HDBaseRepositoryProtcol.h"

/**
 分布式处理网络请求，该类做为父类，提供公共部分及抽象方法，子类需要实现HDBaseRepositoryProtcol的必须方法
 */
@interface HDBaseRepository: NSObject <HDBaseRepositoryProtcol>

@property (nonatomic, strong) NSString * _Nullable baseURL;
@property (nonatomic, strong, readonly) HDRequestManagerConfig * _Nullable configuration;
@property (nonatomic, assign) NSInteger hdPageIndex;
@property (nonatomic, assign) NSInteger hdPageSize;

- (void)requestCache:(HDRequestManagerCache _Nullable )cache
             success:(HDRequestManagerSuccess _Nullable )success
             failure:(HDRequestManagerFailure _Nullable )failure;
- (void)canncel;

/**
 清除该url下所有的缓存数据，例如该方法可以清除所有商品详情下的缓存
 */
- (void)clearRequestUrlCache;

/**
 清除该url下，指定的缓存数据，例如该方法可以清除商品详情id=123456的缓存数据
 */
- (void)clearRequestUrlAndFormulateCache;

/**
 清除网络缓存的所有数据
 */
- (void)clearAllCache;

@end

