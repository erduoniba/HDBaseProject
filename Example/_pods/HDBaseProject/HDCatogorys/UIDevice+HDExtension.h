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

/**
 获取status的高度，根据屏幕的高度和宽度判断是否iPhoneX

 @return iPhoneX：44px other:20px
 */
+ (CGFloat)hd_statusHeight;


/**
 获取导航栏的高度，都是44px

 @return 44px
 */
+ (CGFloat)hd_navgationBarHeight;

/**
 获取TabBar下面的高度，根据屏幕的高度和宽度判断是否iPhoneX

 @return iPhoneX：34px other:0px
 */
+ (CGFloat)hd_tabBarBottomHeight;

@end
