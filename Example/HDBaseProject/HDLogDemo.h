//
//  HDLogDemo.h
//  HDBaseProject_Example
//
//  Created by 邓立兵 on 2019/9/16.
//  Copyright © 2019 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <HDBaseProject/HDBaseProject.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HDLogFlag){
    // 系統默認枚舉值的位移範圍是 0 到 4，不要和宿主 app 的自定義枚舉重複（请从10开始）
    HDLogFlagTest   =   (1 << 10),  // Test模块
    HDLogFlagTest2   =   (1 << 11),  // Test2模块
};

typedef NS_ENUM(NSUInteger, HDLogLevel){
    //module
    HDLogLevelTest = HDLogFlagTest,  // Test模块
    HDLogLevelTest2 = HDLogFlagTest2,  // Test2模块
};

static const DDLogLevel ddLogLevel = DDLogLevelAll;

// log日志安装模块添加前缀进行输出
#define HDLogTest(frmt, ...) HDLogModule(HDLogFlagTest, frmt, ##__VA_ARGS__)
#define HDLogTest2(frmt, ...) HDLogModule(HDLogFlagTest2, frmt, ##__VA_ARGS__)

// 使用HDLogFileTest1可以将日志独立成文件保存
#define HDLogContextTest1    100
#define HDLogFileTest1(frmt, ...) HDFileModule(HDLogFlagTest, HDLogContextTest1, frmt, ##__VA_ARGS__)
#define HDLogContextTest2    101
#define HDLogFileTest2(frmt, ...) HDFileModule(HDLogFlagTest, HDLogContextTest2, frmt, ##__VA_ARGS__)


@interface HDLogDemo : NSObject

+ (void)hdlogDemo;

@end

NS_ASSUME_NONNULL_END
