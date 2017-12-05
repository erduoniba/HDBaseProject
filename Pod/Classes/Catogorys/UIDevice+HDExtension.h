//
//  UIDevice+HDExtension_h.h
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/11/29.
//

#import <UIKit/UIKit.h>

@interface UIDevice (HDExtension)

#pragma mark -
#pragma mark - UIDevice+Extension

/// 获取iOS系统的版本号
+ (NSString *)hd_systemVersion;

/// 获取手机内存总量, 返回的是字节数
+ (NSUInteger)hd_totalMemoryBytes;

/// 获取手机可用内存, 返回的是字节数
+ (NSUInteger)hd_freeMemoryBytes;

/// 获取手机硬盘空闲空间, 返回的是字节数
+ (long long)hd_freeDiskSpaceBytes;

/// 获取手机硬盘总空间, 返回的是字节数
+ (long long)hd_totalDiskSpaceBytes;

@end
