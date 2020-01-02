//
//  NSArray+HDExtension.h
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/12/4.
//

#import <Foundation/Foundation.h>

@interface HDSafeCollection : NSObject

/**
 是否使用安全的访问方式去请求 集合（NSArray/NSMutableArray、NSDictionary/NSMutableDictionary）
 类型的可能Crash的接口方法

 @param enabled 默认是NO，使用不当Crash的地方还是会Crash
 */
+ (void)hd_safeCollectionEnable:(BOOL)enabled;

/**
 是否需要在即将Crash的时候打印相关信息

 @param enabled 默认为NO，不打印
 */
+ (void)hd_safeCollectionLogEnable:(BOOL)enabled;

@end
