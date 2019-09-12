//
//  HDDDLog.h
//  HDMasterProject
//
//  Created by 邓立兵 on 2019/9/11.
//  Copyright © 2019 HarryDeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CocoaLumberjack/CocoaLumberjack.h>

NS_ASSUME_NONNULL_BEGIN

/**
 基于DDLog的一套log日志，自定义log文件名称，自定义log日志路径，自定义log内容
 https://link.jianshu.com/?t=https://github.com/CocoaLumberjack/CocoaLumberjack
 https://www.jianshu.com/p/107c3ba8e325
 */
@interface HDDDLog : NSObject

/**
 配置自定义DDLog信息

 @param logFolderName log日志存放的文件夹名称（文件存放在沙盒中/DDLogs/logFolderName/）
 */
+ (void)configurationDDLog:(NSString *)logFolderName;

/**
 配置自定义DDLog信息

 @param logFolderName log日志存放的文件夹名称（文件存放在沙盒中/DDLogs/logFolderName/）
 @param logFilePrefix log日志名的前缀（默认是bundleid）(完整文件命名：logFilePrefix_YYYYMMdd_HHMMss.log)
 */
+ (void)configurationDDLog:(NSString *)logFolderName logFilePrefix:(NSString *)logFilePrefix;

@end

NS_ASSUME_NONNULL_END
