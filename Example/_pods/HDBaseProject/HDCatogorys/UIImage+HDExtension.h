//
//  UIImage+HDExtension.h
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/11/30.
//

#import <UIKit/UIKit.h>

@interface UIImage (HDExtension)

#pragma mark -
#pragma mark - UIImage+Alpha

/**
 *  @brief  是否有alpha通道
 *
 *  @return 是否有alpha通道
 */
- (BOOL)hd_hasAlpha;

/**
 *  @brief  如果没有alpha通道 增加alpha通道
 *
 *  @return 如果没有alpha通道 增加alpha通道
 */
- (UIImage *)hd_imageWithAlpha;

/**
 *  @brief  增加透明边框
 *
 *  @param borderSize 边框尺寸
 *
 *  @return 增加透明边框后的图片
 */
- (UIImage *)hd_transparentBorderImage:(NSUInteger)borderSize;

//http://stackoverflow.com/questions/6521987/crop-uiimage-to-alpha?answertab=oldest#tab-top
/**
 *  @brief  裁切含透明图片为最小大小
 *
 *  @return 裁切后的图片
 */
- (UIImage *)hd_trimmedBetterSize;


#pragma mark -
#pragma mark - UIImage+Color

/**
 根据颜色生成纯色图片

 @param color 颜色
 @return 纯色图片
 */
+ (UIImage *)hd_imageWithColor:(UIColor *)color;

/**
 改变图片的颜色，比如图片是黑色的箭头，可以使用该方法修改成白色的箭头

 @param color 目标颜色
 @return 目标图片
 */
- (UIImage *)hd_imageWithColor:(UIColor *)color;

/**
 取图片某一点的颜色

 @param point 某一点
 @return 某一点
 */
- (UIColor *)hd_colorAtPoint:(CGPoint )point;

/**
  获得灰度图

 @return  灰度图
 */
- (UIImage*)hd_covertToGrayImage;


#pragma mark -
#pragma mark - UIImage+Transfers

/**
 Returns a copy of the image cropped to the specified rectangle (in image coordinates).

 @param rect rect
 @return image
 */
- (UIImage *)hd_imageCroppedToRect:(CGRect)rect;

/**
 Returns a copy of the image scaled to the specified size. This method may change the aspect ratio of the image.

 @param size specified size
 @return image.
 */
- (UIImage *)hd_imageScaledToSize:(CGSize)size;

/**
 Returns a copy of the image scaled to fit the specified size without changing its aspect ratio. The resultant image may be smaller than the size specified in one dimension if the aspect ratios do not match. No padding will be added.

 @param size specified size
 @return image
 */
- (UIImage *)hd_imageScaledToFitSize:(CGSize)size;

/**
 Returns a copy of the image scaled to fit the specified size without changing its aspect ratio. If the image aspect ratio does not match the aspect ratio of the size specified, the image will be cropped to fit.

 @param size specified size
 @return image
 */
- (UIImage *)hd_imageScaledToFillSize:(CGSize)size;

/**
 Returns a vertically reflected copy of the image that tapers off to transparent with a gradient. The scale parameter determines that point at which the image tapers off and should have a value between 0.0 and 1.0.

 @param scale 0.0 and 1.0
 @return image
 */
- (UIImage *)hd_reflectedImageWithScale:(CGFloat)scale;

/**
 Returns a copy of the image with the corners clipped to the specified curvature radius.

 @param radius radius
 @return image
 */
- (UIImage *)hd_imageWithCornerRadius:(CGFloat)radius;

- (UIImage *)hd_imageWithCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 修正图片的方向

 @return 修正方向后的图片
 */
- (UIImage *)hd_fixOrientation;

/**
 *  @brief  旋转图片
 *
 *  @param degrees 角度
 *
 *  @return 旋转后图片
 */
- (UIImage *)hd_imageRotatedByDegrees:(CGFloat)degrees;

/**
 *  @brief  旋转图片
 *
 *  @param radians 弧度
 *
 *  @return 旋转后图片
 */
- (UIImage *)hd_imageRotatedByRadians:(CGFloat)radians;

/**
 *  @brief  垂直翻转
 *
 *  @return  翻转后的图片
 */
- (UIImage *)hd_flipVertical;
/**
 *  @brief  水平翻转
 *
 *  @return 翻转后的图片
 */
- (UIImage *)hd_flipHorizontal;

/**
 *  @brief  角度转弧度
 *
 *  @param degrees 角度
 *
 *  @return 弧度
 */
+(CGFloat)hd_degreesToRadians:(CGFloat)degrees;
/**
 *  @brief  弧度转角度
 *
 *  @param radians 弧度
 *
 *  @return 角度
 */
+(CGFloat)hd_radiansToDegrees:(CGFloat)radians;


#pragma mark -
#pragma mark - UIImage+Merge

/**
 合并图片

 @param image 需要合成的图片
 @param top 合并后的图片中，if YES:image盖在self上面
 @return 合并后的图片
 */
- (UIImage *)hd_mergeImage:(UIImage *)image mergeImageAtTop:(BOOL)top;


#pragma mark -
#pragma mark - UIImage+Capture

/**
 截图指定view成图片

 @param view view
 @return 图片
 */
+ (UIImage *)hd_captureWithView:(UIView *)view;


#pragma mark -
#pragma mark - UIImage+Blur

/**
 给图片着色

 @param tintColor 图片的着色颜色
 @return 着色后的图片
 */
- (UIImage *)hd_tintedImageWithColor:(UIColor *)tintColor;

/**
 使图片变得模糊

 @param blurRadius 模糊的系数，值越大则越模糊 0-100左右
 @return 模糊后的图片
 */
- (UIImage *)hd_blurredImageWithRadius:(CGFloat)blurRadius;

@end
