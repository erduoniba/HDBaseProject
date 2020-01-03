//
//  NSString+HDExtension.h
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/11/25.
//

#import <Foundation/Foundation.h>

@interface NSString (HDExtension)

#pragma mark - 
#pragma mark - NSString+Encode

/**
 URLEncode：
    原因:1、是因为当字符串数据以url的形式传递给web服务器时,字符串中是不允许出现空格和特殊字符的；
        2、因为 url 对字符有限制，比如把一个邮箱放入 url，就需要使用 urlencode 函数，因为 url 中不能包含 @ 字符；
        3、url转义其实也只是为了符合url的规范而已。因为在标准的url规范中中文和很多的字符是不允许出现在url中的。
    originUrl:   http://www.example.com?name=勇神战五渣
    urlencode:   http%3A%2F%2Fwww.example.com%3Fname%3D%E5%8B%87%E7%A5%9E%E6%88%98%E4%BA%94%E6%B8%A3

 @return URLEncode
 */
- (NSString *)hd_urlEncode;


/**
 URLDecode

 @return URLDecode
 */
- (NSString *)hd_urlDecode;

/**
 UTF-8Encode：
    utf-8是一种针对Unicode的可变长度字符编码，又称万国码。
    originUrl:  http://www.example.com?name=勇神战五渣
    utf8encode: http://www.example.com?name=%E5%8B%87%E7%A5%9E%E6%88%98%E4%BA%94%E6%B8%A3

 @return UTF-8Encode
 */
- (NSString *)hd_utf8Encode;


/**
 UTF-8Decode

 @return UTF-8Decode
 */
- (NSString *)hd_utf8Decode;


/*
 base64Encode:

 */


/**
 base64Encode
    base64编码之所以称为base64，是因为其使用64个字符来对任意数据进行编码 http://www.jianshu.com/p/b8a5e1c770f9
    originString:   http://www.example.com?name=勇神战五渣
    base64String:   aHR0cDovL3d3dy5leGFtcGxlLmNvbT9uYW1lPeWLh+elnuaImOS6lOa4ow==

 @return base64Encode
 */
- (NSString *)hd_base64Encode;


/**
 base64Decode

 @return base64Decode
 */
- (NSString *)hd_base64Decode;


#pragma mark -
#pragma mark - NSString+FontSize

/**
 get label size of constraine width and font

 @param font label font, default system font
 @param width  label constraine width
 @return label's fit size
 */
- (CGSize)hd_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;


/**
 get label size of constraine height and font

 @param font label font, default system font
 @param height label constraine height
 @return label's fit size
 */
- (CGSize)hd_sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;


#pragma mark -
#pragma mark - NSString+Trims

/**
 trimming whitespace

 @return after trimming whitespace string
 */
- (NSString *)hd_trimmingWhitespace;

/**
 trimming whitespace and newlines

 @return after trimming whitespace and newlines string
 */
- (NSString *)hd_trimmingWhitespaceAndNewlines;

@end
