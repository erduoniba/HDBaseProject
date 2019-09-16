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
    //module
    HDLogFlagTest   =   (1 << 10),  // Test模块
    HDLogFlagTest2   =   (1 << 11),  // Test2模块
};

typedef NS_ENUM(NSUInteger, HDLogLevel){
    //module
    HDLogLevelTest = HDLogFlagTest,  // Test模块
    HDLogLevelTest2 = HDLogFlagTest2,  // Test2模块
};

static const DDLogLevel ddLogLevel = DDLogLevelAll;

#define HDLogTest(frmt, ...) HDLogModule(HDLogFlagTest, frmt, ##__VA_ARGS__)
#define HDLogTest2(frmt, ...) HDLogModule(HDLogFlagTest2, frmt, ##__VA_ARGS__)


@interface HDLogDemo : NSObject

+ (void)hdlogDemo;

@end

NS_ASSUME_NONNULL_END
