//
//  HDDDLog.h
//  HDMasterProject
//
//  Created by 邓立兵 on 2019/9/11.
//  Copyright © 2019 HarryDeng. All rights reserved.
//

// 日志等级控制说明
/*
 1、
 static const int ddLogLevel = DDLogLevelInfo;
 设置 ddLogLevel 的时候，该类使用 DDLogError、DDLogWarn、DDLogInfo 会打印出来，使用DDLogDebug、DDLogVerbose不会
 
 2、不同的类有不同的日志等级，**需要在不同的类中调用**，可以在pch设置一个合适的值
 static const int ddLogLevel = DDLogLevelInfo;
 来控制
 */

#import <Foundation/Foundation.h>

#import <CocoaLumberjack/CocoaLumberjack.h>

// 自定义模块作为前缀宏定义
#define HDLogModule(flag, frmt, ...) LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, (DDLogFlag)flag, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)

// 自定义Log生成独立文件
#define HDFileModule(flag, log_context, frmt, ...) LOG_MAYBE(LOG_ASYNC_ENABLED, LOG_LEVEL_DEF, (DDLogFlag)flag, log_context, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)

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

/**
 注册自定义的模块标示

 @param modules 模块前缀，日志打印会带上该模块名称
 */
+ (void)registeModules:(NSArray <NSString *>*)modules;

+ (void)registeFiles:(NSArray <NSString *>*)files contexts:(NSArray <NSNumber *> *)contexts;

@end


/**
 自定义log文件名称
 https://codeday.me/bug/20190624/1281511.html
 */
@interface HDCustomFileManager : DDLogFileManagerDefault

@property (nonatomic, strong) NSString *logFilePrefix;

@end


/**
 日志分文件保存
 https://www.twblogs.net/a/5bcbadd32b71776a052bf945
 https://medium.com/@jongwonwoo/logging-to-multiple-files-d1305d83223c#.nheqx8hfn
 */
@interface HDCustomWhiteFormatter: DDContextWhitelistFilterLogFormatter

@end

NS_ASSUME_NONNULL_END
