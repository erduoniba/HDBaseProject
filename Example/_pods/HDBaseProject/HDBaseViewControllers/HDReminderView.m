//
//  HDReminderView.m
//  HDBaseProject
//
//  Created by harry on 14-10-15.
//  Copyright (c) 2014年 harry. All rights reserved.
//

#import "HDReminderView.h"

#import "UIView+Helpers.h"
#import "HDGlobalVariable.h"
#import "HDFrameworkBundleImage.h"
#import "UIImage+HDExtension.h"

#define UIColorWithHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1]

@interface HDReminderView ()

@property (strong, nonatomic) UIView *reminderBgView;
@property (strong, nonatomic) UIImageView *reminderImageView;
@property (strong, nonatomic) UILabel *reminderLabel;
@property (strong, nonatomic) UIButton *refreshBt;

@end

@implementation HDReminderView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _reminderBgView = [[UIView alloc] initWithFrame:frame];
        [self addSubview:_reminderBgView];

        _reminderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _reminderImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_reminderBgView addSubview:_reminderImageView];
        [_reminderImageView centerAlignHorizontalForSuperView];

        _reminderLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, _reminderImageView.frameOriginY + 20, frame.size.width - 60, 40)];
        _reminderLabel.textAlignment = NSTextAlignmentCenter;
        _reminderLabel.textColor = UIColorWithHex(0x666666);
        _reminderLabel.font = [UIFont systemFontOfSize:14.0f];
        [_reminderBgView addSubview:_reminderLabel];

        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setReminderType:(HDReminderType)type {
    self.hidden = NO;
    if (type == HDReminderTypeNotNet) {
        _reminderLabel.text = @"网络不给力";
        _reminderImageView.image = [HDFrameworkBundleImage hdBaseProjectBundleImage:@"request_nonet"];
    }
    else if (type == HDReminderTypeRequestNotData) {
        _reminderLabel.text = @"暂无数据";
        _reminderImageView.image = [HDFrameworkBundleImage hdBaseProjectBundleImage:@"request_nodata"];
    }
    else if (type == HDReminderTypeRequestFail) {
        _reminderLabel.text = @"数据请求失败";
        _reminderImageView.image = [HDFrameworkBundleImage hdBaseProjectBundleImage:@"request_fail"];
    }
    _reminderImageView.image = [_reminderImageView.image hd_imageWithColor:UIColorWithHex(0x666666)];

    [self refreshReminderView];
}

- (void)customReminder:(NSString *)reminder {
    _reminderLabel.text = reminder;
    [self refreshReminderView];
}

- (void)customReminderImage:(UIImage *)image {
    _reminderImageView.image = image;
    [self refreshReminderView];
}

- (void)refreshReminderView {
    if (_reminderImageView.image) {
        _reminderImageView.frame = CGRectMake(0, 20, 100, 100);
    }
    else {
        _reminderImageView.frame = CGRectMake(0, 0, 100, 0);
    }
    [_reminderImageView centerAlignHorizontalForSuperView];
    _reminderLabel.frame = CGRectMake(30, _reminderImageView.frameMaxY + 20, self.frame.size.width - 60, 40);
    _reminderBgView.frameSizeHeight = _reminderImageView.frameSizeHeight + _reminderLabel.frameSizeHeight + 40;
    [_reminderBgView centerAlignForSuperview];
}

@end
