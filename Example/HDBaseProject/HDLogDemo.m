//
//  HDLogDemo.m
//  HDBaseProject_Example
//
//  Created by 邓立兵 on 2019/9/16.
//  Copyright © 2019 Harry. All rights reserved.
//

#import "HDLogDemo.h"

@implementation HDLogDemo

+ (void)hdlogDemo {
    // 设置log日志的文件夹名称
    NSString *userId = @"hd";
    [HDDDLog configurationDDLog:@"hdlogs" logFilePrefix:userId];
    // 设置自定义模块标示
    [HDDDLog registeModules:@[@"HDTest1", @"HDTest2"]];
    // 设置自定义文件输出
    [HDDDLog registeFiles:@[@"HDTest1", @"HDTest2"] contexts:@[@(HDLogContextTest1), @(HDLogContextTest2)]];
}

@end
