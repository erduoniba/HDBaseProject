//
//  HDNetStatusManager.h
//  HDMasterProject
//
//  Created by 邓立兵 on 2018/10/27.
//  Copyright © 2018年 HarryDeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@class HDNetStatusManager;

typedef void (^ HDNetworkStatus)(HDNetStatusManager *manager, AFNetworkReachabilityStatus status);

@interface HDNetStatusManager : NSObject

/**
 当前网络状态
 */
@property (nonatomic, assign) AFNetworkReachabilityStatus networkReachabilityStatus;

/**
 延时多久再将网络状态回调出去，默认是0.5秒之后回调
 */
@property (nonatomic, assign) NSTimeInterval delayCallbackTime;

/**
 如果网络状态在delayCallbackTime秒内变化，网络状态一直等待，直到maxDelayCallbackCount次后才回调出去，默认5次
 */
@property (nonatomic, assign) NSInteger maxDelayCallbackCount;

+ (instancetype)sharedInstance;

- (void)startMonitoring;
- (void)stopMonitoring;

- (void)addNetworkChangeObserver:(NSObject *)observer networkStatus:(HDNetworkStatus)networkStatus;

@end

NS_ASSUME_NONNULL_END
