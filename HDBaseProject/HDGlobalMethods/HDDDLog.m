//
//  HDDDLog.m
//  HDMasterProject
//
//  Created by 邓立兵 on 2019/9/11.
//  Copyright © 2019 HarryDeng. All rights reserved.
//

#import "HDDDLog.h"

#import <libkern/OSAtomic.h>

static NSString *const hd_dateFormatString = @"yyyy/MM/dd HH:mm:ss";

NSMutableDictionary *HDFormatDictionary() {
    static NSMutableDictionary *dic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = [NSMutableDictionary dictionaryWithDictionary:@{@"0":@"HDError",
                                                              @"1":@"HDWarning",
                                                              @"2":@"HDInfo",
                                                              @"3":@"HDDebug",
                                                              @"4":@"HDVerbose"
                                                              }];
    });
    return dic;
}


@implementation HDCustomWhiteFormatter {
    DDAtomicCounter *atomicLoggerCounter;
    NSDateFormatter *threadUnsafeDateFormatter;
}

- (NSString *)stringFromDate:(NSDate *)date {
    int32_t loggerCount = [atomicLoggerCounter value];
    if (loggerCount <= 1) {
        // Single-threaded mode.
        if (threadUnsafeDateFormatter == nil) {
            threadUnsafeDateFormatter = [[NSDateFormatter alloc] init];
            [threadUnsafeDateFormatter setDateFormat:hd_dateFormatString];
        }
        return [threadUnsafeDateFormatter stringFromDate:date];
    }
    else {
        // Multi-threaded mode.
        // NSDateFormatter is NOT thread-safe.
        NSString *key = @"HDCustomFormatter_NSDateFormatter";
        NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
        NSDateFormatter *dateFormatter = [threadDictionary objectForKey:key];
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:hd_dateFormatString];
            [threadDictionary setObject:dateFormatter forKey:key];
        }
        return [dateFormatter stringFromDate:date];
    }
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    // 非白名单需要过滤掉
    if (![self isOnWhitelist:logMessage->_context]) {
        return nil;
    }
    
    int n = (int) log2(logMessage->_flag);
    NSString *key = [NSString stringWithFormat:@"%d", n];
    NSString *logLevel = [HDFormatDictionary() objectForKey:key];
    if (!logLevel) {
        logLevel = @"Unknow";
    }
    
    NSString *dateAndTime = [self stringFromDate:(logMessage.timestamp)]; // 日期和时间
    NSString *logFileName = logMessage -> _fileName; // 文件名
    NSString *logFunction = logMessage -> _function; // 方法名
    NSUInteger logLine = logMessage -> _line;        // 行号
    NSString *logMsg = logMessage->_message;         // 日志消息
    // 日志格式：<日志等级> 日期和时间 文件名 方法名 : 行数 日志消息
    return [NSString stringWithFormat:@"<%@> %@ %@ %@ : %lu %@", logLevel, dateAndTime, logFileName, logFunction, logLine, logMsg];
}

- (void)didAddToLogger:(id <DDLogger>)logger {
    [atomicLoggerCounter increment];
}

- (void)willRemoveFromLogger:(id <DDLogger>)logger {
    [atomicLoggerCounter decrement];
}

@end



/**
 自定义log日志
 https://www.jianshu.com/p/107c3ba8e325
 */
@interface HDCustomFormatter: NSObject <DDLogFormatter>

@end

@implementation HDCustomFormatter {
    DDAtomicCounter *atomicLoggerCounter;
    NSDateFormatter *threadUnsafeDateFormatter;
}

- (NSString *)stringFromDate:(NSDate *)date {
    int32_t loggerCount = [atomicLoggerCounter value];
    if (loggerCount <= 1) {
        // Single-threaded mode.
        if (threadUnsafeDateFormatter == nil) {
            threadUnsafeDateFormatter = [[NSDateFormatter alloc] init];
            [threadUnsafeDateFormatter setDateFormat:hd_dateFormatString];
        }
        return [threadUnsafeDateFormatter stringFromDate:date];
    }
    else {
        // Multi-threaded mode.
        // NSDateFormatter is NOT thread-safe.
        NSString *key = @"HDCustomFormatter_NSDateFormatter";
        NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
        NSDateFormatter *dateFormatter = [threadDictionary objectForKey:key];
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:hd_dateFormatString];
            [threadDictionary setObject:dateFormatter forKey:key];
        }
        return [dateFormatter stringFromDate:date];
    }
}


- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    int n = (int) log2(logMessage->_flag);
    NSString *key = [NSString stringWithFormat:@"%d", n];
    NSString *logLevel = [HDFormatDictionary() objectForKey:key];
    if (!logLevel) {
        logLevel = @"Unknow";
    }
    
    NSString *dateAndTime = [self stringFromDate:(logMessage.timestamp)]; // 日期和时间
    NSString *logFileName = logMessage -> _fileName; // 文件名
    NSString *logFunction = logMessage -> _function; // 方法名
    NSUInteger logLine = logMessage -> _line;        // 行号
    NSString *logMsg = logMessage->_message;         // 日志消息
    // 日志格式：<日志等级> 日期和时间 文件名 方法名 : 行数 日志消息
    return [NSString stringWithFormat:@"<%@> %@ %@ %@ : %lu %@", logLevel, dateAndTime, logFileName, logFunction, logLine, logMsg];
}

- (void)didAddToLogger:(id <DDLogger>)logger {
    [atomicLoggerCounter increment];
}

- (void)willRemoveFromLogger:(id <DDLogger>)logger {
    [atomicLoggerCounter decrement];
}

@end



@implementation HDCustomFileManager

// 需要重载该方法来实现自定义log名称
// 默认路径在沙盒的Library/Caches/Logs/目录下, 文件名为bundleid+空格+日期.log
-(NSString *)newLogFileName {
    if (_logFilePrefix.length == 0) {
        _logFilePrefix = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    }
    NSString *timeStamp = [self getTimestamp];
    NSString *logFileName = [NSString stringWithFormat:@"%@_%@.log", _logFilePrefix, timeStamp];
    NSLog(@"=================================================\n logFileName : %@\n=================================================", logFileName);
    return logFileName;
}

-(BOOL)isLogFile:(NSString *)fileName {
    return NO;
}

-(NSString *)getTimestamp {
    static dispatch_once_t onceToken;
    static NSDateFormatter *dateFormatter;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"YYYYMMdd_HHMMss"];
    });
    return [dateFormatter stringFromDate:NSDate.date];
}

@end


@implementation HDDDLog

+ (void)configurationDDLog:(NSString *)logFolderName {
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    [self configurationDDLog:logFolderName logFilePrefix:appName];
}

NSString *_logFolderName;
NSString *_logFilePrefix;
+ (void)configurationDDLog:(NSString *)logFolderName logFilePrefix:(NSString *)logFilePrefix {
    _logFolderName = logFolderName;
    _logFilePrefix = logFilePrefix;
    
    // 自定义的log格式 日志格式：<日志等级> 日期和时间 文件名 方法名 : 行数 日志消息
    HDCustomFormatter *customFormatter = [[HDCustomFormatter alloc] init];
    [DDTTYLogger sharedInstance].logFormatter = customFormatter;
    
    // DDTTYLogger，你的日志语句将被发送到Xcode控制台 TTY = Xcode 控制台
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    // DDASLLogger，你的日志语句将被发送到苹果文件系统、你的日志状态会被发送到 Console.app (Xcode 控制台会打印两份，所以注释掉)
    // [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs 苹果系统日志
    
    // 自定义log日志存放的路径（文件存放在沙盒中）
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logPath = [paths[0] stringByAppendingPathComponent:@"DDLogs"];
    NSString *customLogPath = [logPath stringByAppendingPathComponent:logFolderName];
    NSLog(@"=================================================\n customLogPath : %@\n=================================================", customLogPath);
    
    // 自定义log文件名称
    HDCustomFileManager *fileManager = [[HDCustomFileManager alloc] initWithLogsDirectory:customLogPath];
    fileManager.logFilePrefix = logFilePrefix;
    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:fileManager]; // 本地文件日志
    fileLogger.rollingFrequency = 3600 * 24;    // 每24小时创建一个新文件
    fileLogger.maximumFileSize = 1024 * 1024 * 1;   // 文件最大是1M
    fileLogger.doNotReuseLogFiles = YES;            // 每次启动生成新的log日志文件
    fileLogger.logFileManager.maximumNumberOfLogFiles = 50; // 最多允许创建50个文件
    fileLogger.logFormatter = [[HDCustomFormatter alloc] init];
    [DDLog addLogger:fileLogger];
}

+ (void)registeModules:(NSArray <NSString *>*)modules {
    NSMutableDictionary *dic = HDFormatDictionary();
    [modules enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dic setValue:obj forKey:[NSString stringWithFormat:@"%lu",10+idx]];
    }];
}

+ (void)registeFiles:(NSArray <NSString *>*)files contexts:(NSArray <NSNumber *> *)contexts {
    [files enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (contexts.count > idx) {
            [self configurationDDLogFile:obj context:contexts[idx]];
        }
    }];
}

+ (void)configurationDDLogFile:(NSString *)file context:(NSNumber *)context {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logPath = [paths[0] stringByAppendingPathComponent:@"DDLogs"];
    NSString *customLogPath = [logPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@", _logFolderName, file]];
    
    HDCustomFileManager *fileManager = [[HDCustomFileManager alloc] initWithLogsDirectory:customLogPath];
    fileManager.logFilePrefix = _logFilePrefix;
    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:fileManager]; // 本地文件日志
    fileLogger.rollingFrequency = 3600 * 24;    // 每24小时创建一个新文件
    fileLogger.maximumFileSize = 1024 * 1024 * 1;   // 文件最大是1M
    fileLogger.doNotReuseLogFiles = NO;            // 每次启动不生成新的log日志文件
    fileLogger.logFileManager.maximumNumberOfLogFiles = 50; // 最多允许创建50个文件
    HDCustomWhiteFormatter *whiteFormatter = [[HDCustomWhiteFormatter alloc] init];
    [whiteFormatter addToWhitelist:context.integerValue];
    fileLogger.logFormatter = whiteFormatter;
    [DDLog addLogger:fileLogger];
}

@end
