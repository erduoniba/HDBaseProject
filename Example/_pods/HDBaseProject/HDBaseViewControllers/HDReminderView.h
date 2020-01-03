//
//  HDReminderView.h
//  HDBaseProject
//
//  Created by harry on 14-10-15.
//  Copyright (c) 2014年 harry. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HDReminderType) {
    HDReminderTypeNotNet,//无网络
    HDReminderTypeRequestNotData,//请求无数据
    HDReminderTypeRequestFail,//请求失败
};//无数据无网络状态枚举

@interface HDReminderView : UIView

- (void)setReminderType:(HDReminderType)type;
- (void)customReminder:(NSString *)reminder;
- (void)customReminderImage:(UIImage *)image;

@end
