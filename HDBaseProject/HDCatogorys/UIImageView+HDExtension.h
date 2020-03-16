//
//  UIImageView+HDExtension.h
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/11/29.
//

#import <UIKit/UIKit.h>

@interface UIImageView (HDExtension)

#pragma mark -
#pragma mark - UIImageView+Reflect

/**
 *  @brief  倒影
 */
- (void)hd_reflect;


#pragma mark -
#pragma mark - UIImageView+Letter

/**
 Sets the image property of the view based on initial text. A random background color is automatically generated.

 @param string The string used to generate the initials. This should be a user's full name if available
 */
- (void)hd_setImageWithString:(NSString *)string;

/**
 Sets the image property of the view based on initial text and a specified background color.

 @param string The string used to generate the initials. This should be a user's full name if available
 @param color (optional) This optional paramter sets the background of the image. If not provided, a random color will be generated
 */

- (void)hd_setImageWithString:(NSString *)string color:(UIColor *)color;

/**
 Sets the image property of the view based on initial text, a specified background color, and a circular clipping

 @param string The string used to generate the initials. This should be a user's full name if available
 @param color (optional) This optional paramter sets the background of the image. If not provided, a random color will be generated
 @param isCircular This boolean will determine if the image view will be clipped to a circular shape
 */
- (void)hd_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular;

/**
 Sets the image property of the view based on initial text, a specified background color, a custom font, and a circular clipping

 @param string The string used to generate the initials. This should be a user's full name if available
 @param color (optional) This optional paramter sets the background of the image. If not provided, a random color will be generated
 @param isCircular This boolean will determine if the image view will be clipped to a circular shape
 @param fontName This will use a custom font attribute. If not provided, it will default to system font
 */
- (void)hd_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular fontName:(NSString *)fontName;

/**
 Sets the image property of the view based on initial text, a specified background color, custom text attributes, and a circular clipping

 @param string The string used to generate the initials. This should be a user's full name if available
 @param color (optional) This optional paramter sets the background of the image. If not provided, a random color will be generated
 @param isCircular This boolean will determine if the image view will be clipped to a circular shape
 @param textAttributes This dictionary allows you to specify font, text color, shadow properties, etc., for the letters text, using the keys found in NSAttributedString.h
 */
- (void)hd_setImageWithString:(NSString *)string color:(UIColor *)color circular:(BOOL)isCircular textAttributes:(NSDictionary *)textAttributes;


#pragma mark -
#pragma mark - UIImageView+VideoFirstImage

/**
 Async get voide first second image by voide url

 @param url voide url
 @param placeholderImage placeholder image
 */
- (void)hd_setVoideWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage;


#pragma mark -
#pragma mark - UITextView+BetterFace

/**
 Better display of face image. https://github.com/croath/UIImageView-BetterFace

 @param image image that contain faces
 @param performance if YES, choice CIDetectorAccuracyLow mode: Lower accuracy, higher performance
 else choice CIDetectorAccuracyHigh mode: Lower performance, higher accuracy.
 */
- (void)hd_setBetterFaceImage:(UIImage *)image performance:(BOOL)performance;

@end
