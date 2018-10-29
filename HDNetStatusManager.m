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
    }
    return self;
}

- (void)startMonitoring {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    __weak typeof(self) weakSelf = self;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        typeof(self) self = weakSelf;
        [self disposeNetworkStatusChange:status];
        NSLog(@"%0.2f", [[NSDate date] timeIntervalSince1970]);
    }];
    [manager startMonitoring];
}

- (void)stopMonitoring {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager stopMonitoring];
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
    _currenntStauts = status;
    for (NSObject *observer in self.networkObserverMapTable.keyEnumerator.allObjects) {
        HDNetworkStatus networkStatus = [self.networkObserverMapTable objectForKey:observer];
        networkStatus(self, status);
    }
}


- (void)addNetworkChangeObserver:(NSObject *)observer networkStatus:(HDNetworkStatus)networkStatus {
    if (!observer || !networkStatus) {
        return;
    }
    networkStatus(self, self.currenntStauts);
    [_networkObserverMapTable setObject:[networkStatus copy] forKey:observer];
}

@end
