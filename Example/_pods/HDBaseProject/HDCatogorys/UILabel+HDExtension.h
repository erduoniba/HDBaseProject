//
//  UILabel+HDExtension.h
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/12/1.
//

#import <UIKit/UIKit.h>

@interface UILabel (HDExtension)

#pragma mark -
#pragma mark - UIView+Init

+ (instancetype)hd_createLbWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font color:(UIColor *)color;


#pragma mark -
#pragma mark - UIView+SuggestSize

- (CGSize)hd_suggestedSizeForWidth:(CGFloat)width;
- (CGSize)hd_suggestSizeForAttributedString:(NSAttributedString *)string width:(CGFloat)width;
- (CGSize)hd_suggestSizeForString:(NSString *)string width:(CGFloat)width;
- (CGSize)hd_suggestSizeForString:(NSString *)string size:(CGSize)size;


#pragma mark -
#pragma mark - UIView+Space

- (NSAttributedString *)hd_setColumnSpace:(CGFloat)columnSpace;
- (NSAttributedString *)hd_setRowSpace:(CGFloat)rowSpace;

@end
