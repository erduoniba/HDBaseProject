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
    [HDDDLog configurationDDLog:@"hdlogs" logFilePrefix:@"xx"];
    // 设置自定义模块标示
    [HDDDLog registeModules:@[@"HDTest", @"HDTest2"]];
}

@end
