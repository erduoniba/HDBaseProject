//
//  HDDDLog.h
//  HDMasterProject
//
//  Created by 邓立兵 on 2019/9/11.
//  Copyright © 2019 HarryDeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 基于DDLog的一套log日志，自定义log文件名称，自定义log日志路径，自定义log内容
 https://link.jianshu.com/?t=https://github.com/CocoaLumberjack/CocoaLumberjack
 https://www.jianshu.com/p/107c3ba8e325
 */
@interface HDDDLog : NSObject

+ (void)configurationDDLog:(NSString *)logFolderName;

@end

NS_ASSUME_NONNULL_END
