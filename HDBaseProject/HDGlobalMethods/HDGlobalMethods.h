//
//  GlobalMethods.h
//  Hotchpotch
//
//  Created by Harry on 15/8/3.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <AVFoundation/AVFoundation.h>

/**
 *  GlobalMethods 定位为对objc工具类, 不涉及具体业务，便于下个项目使用。
 *  涉及具体业务的操作统一放到CommonTool中
 */
@interface HDGlobalMethods : NSObject


//时间转换 传入时间戳和样式字符串 如@"YYYY-MM-dd HH:mm" 毫秒级别
+ (NSString *)stringFromTimeIntervalSince1970:(CGFloat)time dateFormat:(NSString *)format;
+ (NSString *)getDateString:(NSDate *)date withFormat:(NSString*)format;


+ (UIButton *)createButton:(CGRect)frame title:(NSString *)title font:(UIFont *)font textCol:(UIColor *)textColor;
+ (UIButton *)createBackButton:(UIImage *)image1 hilight:(UIImage *)image2;
+ (UILabel *)createLabel:(CGRect)frame title:(NSString *)title font:(UIFont *)font textCol:(UIColor *)textColor;


+ (CGSize)getSizeWithString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)size;


#pragma mark - 数据加密
//md5非对称加密
+ (NSString *)hd_md5Encrypt:(NSString *)key;
//aes对称加密
+ (NSString *)hd_aes128Encrypt:(NSString *)plainText key:(NSString *)key;
+ (NSString *)hd_aes128Decrypt:(NSString *)encryptText key:(NSString *)key;


/**
 *  通过经纬度获取该经纬度的地理信息 (使用苹果自带的转换方法，其实有很大的误差)
 *
 *  @param location        目标经纬度
 *  @param handlePlaceName 回调 经纬度对应的 具体地理信息
 */
+ (void )getPlaceNameWithLocation:(CLLocation *)location finish:(void (^)(NSString *))handlePlaceName;


/**
 *  通过经纬度获取该经纬度的地理信息 (使用苹果自带的转换方法，其实有很大的误差)
 *
 *  @param location        目标经纬度
 *  @param handlePlaceName 回调 经纬度对应的 城市名称
 */
+ (void )getCityNameWithLocation:(CLLocation *)location finish:(void (^)(NSString *))handlePlaceName;


//其实网上建议 不要频繁的使用NSDateFormatter，可以把它设置为单例
+ (NSDateFormatter*) dateformatterForFormatter:(NSString*) formatter;

///根据url来判断是非是图片
+ (BOOL) isImageTypeWithUrl:(NSString *)url;

///获取视频的第一帧的截图(本地地址)
+ (void)fFirstVideoFrame:(NSString *)path;

///获取视频的第一帧的截图（网络地址）
+(UIImage *)getImage:(NSString *)videoURL;

///视频压缩
+ (void) lowQuailtyWithInputURL:(NSURL*)inputURL
                      outputURL:(NSURL*)outputURL
                   blockHandler:(void (^)(AVAssetExportSession*))handler;

+ (NSString *)sha1:(NSString *)input;


//传2个字符串以及样式 返回一个NSMutableAttributedString
+ (NSMutableAttributedString *)hd_getNewColorStr:(NSString *)headStr
                                        headFont:(UIFont *)headFont
                                       headColor:(UIColor *)headColor
                                         lastStr:(NSString *)lastStr
                                        lastFont:(UIFont *)lastFont
                                       lastColor:(UIColor *)lastColor;

@end
