//
//  HDCustomCache.m
//  Pod
//
//  Created by Harry on 14-7-28.
//  Copyright (c) 2014年 Harry. All rights reserved.
//

#import "HDCustomCache.h"

static NSMutableDictionary *cacheData;

@implementation HDCustomCache

+ (void)saveCache:(NSString *)keyword byObject:(NSObject *)object {
    [self saveCache:keyword byData:[NSKeyedArchiver archivedDataWithRootObject:object]];
}

+ (void)saveCache:(NSString *)keyword byData:(NSData *)data {
    NSString *key = [NSString stringWithFormat:@"%@", [keyword stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
    BOOL success = [data writeToFile:[self getCustomCachePathForFileName:key] atomically:YES];
    if (success) {
        NSLog(@"save success!");
        NSLog(@"%@", [self getCustomCachePathForFileName:key]);
    }
}

+ (NSData *)getCache:(NSString *)keyword {
    NSString *key = [NSString stringWithFormat:@"%@",[keyword stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
    return [NSData dataWithContentsOfFile:[self getCustomCachePathForFileName:key]];
}


+ (NSObject *)getObjectCache:(NSString *)keyword {
    return [NSKeyedUnarchiver unarchiveObjectWithData:[self getCache:keyword]];
}

+ (void)clearCache:(NSString *)keyword {
    NSString *key = [NSString stringWithFormat:@"%@", [keyword stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
    NSString *imageDir = [self getCustomCachePathForFileName:key];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:imageDir error:nil];
}

+ (void)clearAllCache {
    NSString *imageDir = [self getCustomCachePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [fileManager removeItemAtPath:imageDir error:nil];
}

+ (NSString *)getCustomCachePathForFileName:(NSString *)fileName {
    if ([fileName length] <= 0) {
        fileName = @"";
    }
    
    NSString *dirs = [self getCustomCachePath];
    return [dirs stringByAppendingFormat:@"/%@",fileName];
}

+ (NSString *)getCustomCachePath {
    NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [dirs objectAtIndex:0];
    NSString *imageDir = [NSString stringWithFormat:@"%@/CustomCaches", documentsPath];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    
    if ( !(isDir == YES && existed == YES) ) {
        [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return imageDir;
}

@end
