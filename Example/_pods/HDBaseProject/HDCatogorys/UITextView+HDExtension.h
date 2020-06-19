//
//  UITextView+HDExtensions.h
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/11/29.
//

#import <UIKit/UIKit.h>

@interface UITextView (HDExtension) <UITextViewDelegate>

#pragma mark -
#pragma mark - UITextView+InputLimit

/**
 Set UITextView max length if <=0, no limit
 */
@property (assign, nonatomic)  NSInteger hd_maxLength;


#pragma mark -
#pragma mark - UITextView+PlaceHolder

@property (nonatomic, strong) UITextView *hd_placeHolderTextView;

- (void)hd_addPlaceHolder:(NSString *)placeHolder;


#pragma mark -
#pragma mark - UITextView+Select

/**
 *  @brief  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)hd_selectedRange;
/**
 *  @brief  选中所有文字
 */
- (void)hd_selectAllText;
/**
 *  @brief  选中指定范围的文字
 *
 *  @param range NSRange范围
 */
- (void)hd_setSelectedRange:(NSRange)range;


- (NSAttributedString *)hd_setRowSpace:(CGFloat)rowSpace;

- (NSMutableAttributedString *)hd_setAttributedString:(NSString *)title color:(UIColor *)color value:(NSString *)value;

@end
