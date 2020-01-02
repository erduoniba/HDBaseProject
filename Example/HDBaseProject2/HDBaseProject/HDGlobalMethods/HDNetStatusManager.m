//
//  HDNetStatusManager.m
//  HDMasterProject
//
//  Created by 邓立兵 on 2018/10/27.
//  Copyright © 2018年 HarryDeng. All rights reserved.
//

#import "HDNetStatusManager.h"

@interface HDNetStatusManager ()

@property (nonatomic, strong) NSMapTable *networkObserverMapTable;

/**
 记录在delayCallbackTime秒内，已经有多少次没有回调出去
 */
@property (nonatomic, assign) NSInteger delayCallbackCount;

/**
 是否已经在监听中
 */
@property (nonatomic, assign) BOOL isStartMonitoring;

@end

@implementation HDNetStatusManager

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _networkObserverMapTable = [NSMapTable weakToWeakObjectsMapTable];
        _delayCallbackTime = 0.5;
        _delayCallbackCount = 0;
        _maxDelayCallbackCount = 5;
        _isStartMonitoring = NO;
    }
    return self;
}

- (AFNetworkReachabilityStatus)networkReachabilityStatus {
    _networkReachabilityStatus = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    return _networkReachabilityStatus;
}

- (void)startMonitoring {
    if (_isStartMonitoring) {
        return;
    }
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    __weak typeof(self) weakSelf = self;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        __strong typeof(self) self = weakSelf;
        [self disposeNetworkStatusChange:status];
    }];
    [manager startMonitoring];
    _isStartMonitoring = YES;
}

- (void)stopMonitoring {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager stopMonitoring];;
    _isStartMonitoring = NO;
}

- (void)disposeNetworkStatusChange:(AFNetworkReachabilityStatus)status {
    _delayCallbackCount++;
    if (_delayCallbackTime < _maxDelayCallbackCount) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(networkStatusChangeCallback:) object:@(status)];
    }
    [self performSelector:@selector(networkStatusChangeCallback:) withObject:@(status) afterDelay:_delayCallbackTime];
}

- (void)networkStatusChangeCallback:(NSNumber *)statusN {
    AFNetworkReachabilityStatus status = statusN.integerValue;
    _delayCallbackCount = 0;
    _networkReachabilityStatus = status;
    for (NSObject *observer in self.networkObserverMapTable.keyEnumerator.allObjects) {
        HDNetworkStatus networkStatus = [self.networkObserverMapTable objectForKey:observer];
        networkStatus(self, status);
    }
}


- (void)addNetworkChangeObserver:(NSObject *)observer networkStatus:(HDNetworkStatus)networkStatus {
    if (!observer || !networkStatus) {
        return;
    }
    networkStatus(self, self.networkReachabilityStatus);
    [_networkObserverMapTable setObject:[networkStatus copy] forKey:observer];
}

@end
