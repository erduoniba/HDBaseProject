//
//  UIColor+HDExtension.h
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/11/29.
//

#import <UIKit/UIKit.h>

@interface UIColor (HDExtension)

#pragma mark -
#pragma mark - UIColor+Random

+ (UIColor *)hd_randomColor;


#pragma mark -
#pragma mark - UIColor+Hex

/**
 Generated color through the hexadecimal int

 @param hex example 0x666666
 @return hex:0x666666 correspondence color
 */
+ (UIColor *)hd_colorWithHex:(UInt32)hex;

+ (UIColor *)hd_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;

/**
 Generated color through the hexadecimal string

 @param hexString example @"#666666"
 @return hex:@"#666666" correspondence color
 */
+ (UIColor *)hd_colorWithHexString:(NSString *)hexString;

/**
 颜色转换
 
 @param hexString 支持ARGB/RGB格式，例如#DF1342/0xDF1342，或者#FFDF1342/0xFFDF1342
 @return 颜色
 */
+ (UIColor *)colorWithHexAlphaString:(NSString *)hexString;

/**
 Generated hexadecimal string through color

 @return color correspondence hexString (@"#666666")
 */
- (NSString *)hd_HEXString;

///值不需要除以255.0
+ (UIColor *)hd_colorWithWholeRed:(CGFloat)red
                            green:(CGFloat)green
                             blue:(CGFloat)blue
                            alpha:(CGFloat)alpha;
///值不需要除以255.0
+ (UIColor *)hd_colorWithWholeRed:(CGFloat)red
                            green:(CGFloat)green
                             blue:(CGFloat)blue;


#pragma mark -
#pragma mark - UIColor+Gradient

/**
 Genertated gradient color through c1 to c2

 @param c1 start color
 @param c2 end color
 @param height color gradient height
 @return gradient color
 */
+ (UIColor*)hd_gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height;

+ (UIColor*)hd_gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withWidth:(int)width;


#pragma mark -
#pragma mark - UIColor+Darken

/**
 使得颜色值便暗

 @param value 变暗的系数 0-1之间 （0：显示原色  1：黑色）
 @return 返回变化后的颜色
 */
- (UIColor *)hd_colorByDarkeningColorWithValue:(CGFloat)value;

@end
