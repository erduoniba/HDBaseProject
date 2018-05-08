//
//  UIButton+HDExtension.h
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/11/28.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HDImagePosition) {
    HDImagePositionLeft = 0,              //图片在左，文字在右，默认
    HDImagePositionRight = 1,             //图片在右，文字在左
    HDImagePositionTop = 2,               //图片在上，文字在下
    HDImagePositionBottom = 3,            //图片在下，文字在上
};

@interface UIButton (HDExtension)

#pragma mark -
#pragma mark - UIButton+Position

/**
 https://github.com/Phelthas/Demo_ButtonImageTitleEdgeInsets
 利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列，
 注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing

 @param postion HDImagePosition
 @param spacing 图片和文字的间隔
 */
- (void)hd_setImagePosition:(HDImagePosition)postion spacing:(CGFloat)spacing;


#pragma mark -
#pragma mark - UIButton+TouchAreaInsets

/**
 Change UIButton touch area

 @param edgeInsets UIEdgeInsets, if edgeInsets is positive, UIButton touch area bigger
 */
- (void)hd_setTouchAreaInsets:(UIEdgeInsets)edgeInsets;


#pragma mark -
#pragma mark - UIButton+Indicator

/**
 This method will show the activity indicator in place of the button text.

 @param activityIndicatorViewStyle activity indicator style
 */
- (void)hd_showIndicator:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle;

/**
 This method will remove the indicator and put thebutton text back in place.
 */
- (void)hd_hideIndicator;


#pragma mark -
#pragma mark - UIButton+BackgroundColor

/**
 使用颜色设置按钮背景

 @param backgroundColor 背景颜色
 @param state 按钮状态
 */
- (void)hd_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
