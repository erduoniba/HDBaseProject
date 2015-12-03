//
//  CustomCache.h
//  FreeBrokers
//
//  Created by guoning on 14-7-28.
//  Copyright (c) 2014年 guoning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NHFDDCustomCache : NSObject

+ (void)saveCache:(NSString *)keyword byDictionary:(NSDictionary *)dictionary;
+ (void)saveCache:(NSString *)keyword byObject:(NSObject *)object;
+ (void)saveCache:(NSString *)keyword byArray:(NSArray *)array;
+ (void)saveCache:(NSString *)keyword byData:(NSData *)data;

+ (NSMutableArray *)getArrayCache:(NSString *)keyword;
+ (NSData *)getCache:(NSString *)keyword;
+ (NSObject *)getObjectCache:(NSString *)keyword;

+ (void)clearAllCache;
+ (void)clearCache:(NSString *)keyword;
@end
