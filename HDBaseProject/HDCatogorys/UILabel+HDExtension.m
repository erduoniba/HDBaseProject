//
//  UILabel+HDExtension.m
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/12/1.
//

#import "UILabel+HDExtension.h"

#import <CoreText/CoreText.h>

@implementation UILabel (HDExtension)


#pragma mark -
#pragma mark - UIView+Init

+ (instancetype)hd_createLbWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font color:(UIColor *)color
{
    UILabel *lb = [[UILabel alloc] initWithFrame:frame];
    lb.text = text;
    lb.font = font;
    lb.textColor = color;
    return lb;
}


#pragma mark -
#pragma mark - UIView+Init

- (CGSize)hd_suggestedSizeForWidth:(CGFloat)width {
    if (self.attributedText)
        return [self hd_suggestSizeForAttributedString:self.attributedText width:width];

    return [self hd_suggestSizeForString:self.text width:width];
}

- (CGSize)hd_suggestSizeForAttributedString:(NSAttributedString *)string width:(CGFloat)width {
    return [self hd_suggestSizeForAttributedString:string size:CGSizeMake(width, CGFLOAT_MAX)];
}

- (CGSize)hd_suggestSizeForString:(NSString *)string width:(CGFloat)width {
    return [self hd_suggestSizeForAttributedString:[[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.font}] width:width];
}

- (CGSize)hd_suggestSizeForString:(NSString *)string size:(CGSize)size
{
    return [self hd_suggestSizeForAttributedString:[[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.font}] size:size];
}

- (CGSize)hd_suggestSizeForAttributedString:(NSAttributedString *)string size:(CGSize)size {
    if (!string) {
        return CGSizeZero;
    }
    return [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
}


#pragma mark -
#pragma mark - UIView+Space

- (NSAttributedString *)hd_setColumnSpace:(CGFloat)columnSpace
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整间距
    [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName value:@(columnSpace) range:NSMakeRange(0, [attributedString length])];
    self.attributedText = attributedString;
    return attributedString;
}

- (NSAttributedString *)hd_setRowSpace:(CGFloat)rowSpace
{
    self.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = rowSpace;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
    return attributedString;
}

@end
