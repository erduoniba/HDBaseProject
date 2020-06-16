//
//  UIDevice+HDExtension_h.m
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/11/29.
//

#import "UIDevice+HDExtension.h"

#import "HDGlobalVariable.h"

#include <sys/types.h>
#include <sys/sysctl.h>

#import <sys/socket.h>
#import <sys/param.h>
#import <sys/mount.h>
#import <sys/stat.h>
#import <sys/utsname.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <mach/processor_info.h>

@implementation UIDevice (HDExtension)

#pragma mark -
#pragma mark - UIDevice+Extension

+ (NSString *)hd_systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSUInteger)hd_totalMemoryBytes
{
    return [self hd_getSysInfo:HW_PHYSMEM];
}

+ (NSUInteger)hd_freeMemoryBytes
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;

    host_page_size(host_port, &pagesize);
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        return 0;
    }
    unsigned long mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}

+ (long long)hd_freeDiskSpaceBytes
{
    struct statfs buf;
    long long freespace;
    freespace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        freespace = (long long)buf.f_bsize * buf.f_bfree;
    }
    return freespace;
}

+ (long long)hd_totalDiskSpaceBytes
{
    struct statfs buf;
    long long totalspace;
    totalspace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        totalspace = (long long)buf.f_bsize * buf.f_blocks;
    }
    return totalspace;
}

#pragma mark - sysctl utils

+ (NSUInteger)hd_getSysInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

+ (CGFloat)hd_statusHeight {
    CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    if ([self hd_safeAreaDevice]) {
        if (statusHeight > 44) {
            //打电话或者开启热点的时候，statusHeight的高度是40
            statusHeight = 44;
        }
    }
    else {
        if (statusHeight > 20) {
            //打电话或者开启热点的时候，statusHeight的高度是40
            statusHeight = 20;
        }
    }
    return statusHeight;
}

+ (CGFloat)hd_navgationBarHeight:(UINavigationController *)navigationController {
    CGFloat navgationBarHeight = navigationController.navigationBar.frame.size.height;
    return navgationBarHeight;
}

+ (CGFloat)hd_safeAreaTopHeight {
    if ([self hd_safeAreaDevice]) {
        return 44;
    }
    return 0;
}

+ (CGFloat)hd_safeAreaBottomHeight {
    if ([self hd_safeAreaDevice]) {
        return 34;
    }
    return 0;
}

+ (CGFloat)hd_statusAndNavigationBarHeight:(UINavigationController *)navigationController {
    CGFloat statusHeight = [self hd_statusHeight];
    CGFloat navgationBarHeight = navigationController.navigationBar.frame.size.height;
    return statusHeight + navgationBarHeight;
}

//是否是刘海设备
+ (BOOL)hd_safeAreaDevice {
    if ( ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812) ||
        ([UIScreen mainScreen].bounds.size.width == 414 && [UIScreen mainScreen].bounds.size.height == 896) ) {
        return YES;
    }
    if ( ([UIScreen mainScreen].bounds.size.width == 812 && [UIScreen mainScreen].bounds.size.height == 375) ||
        ([UIScreen mainScreen].bounds.size.width == 896 && [UIScreen mainScreen].bounds.size.height == 414) ) {
        return YES;
    }
    return NO;
}

+ (BOOL)hd_interfaceOrientationPortrait {
    if(([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) ||
       ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)){
        return YES;
    }
    return NO;
}

@end
