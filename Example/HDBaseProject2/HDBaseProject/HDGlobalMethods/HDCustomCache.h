//
//  HDCustomCache.h
//  Pods
//
//  Created by Harry on 14-7-28.
//  Copyright (c) 2014年 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDCustomCache : NSObject

+ (void)saveCache:(NSString *)keyword byObject:(NSObject *)object;
+ (void)saveCache:(NSString *)keyword byData:(NSData *)data;

+ (NSData *)getCache:(NSString *)keyword;
+ (NSObject *)getObjectCache:(NSString *)keyword;

+ (void)clearAllCache;
+ (void)clearCache:(NSString *)keyword;

@end
