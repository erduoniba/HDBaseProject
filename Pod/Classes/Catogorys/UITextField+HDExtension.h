//
//  UITextField+HDExtension.h
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/11/28.
//

#import <UIKit/UIKit.h>

@interface UITextField (HDExtension)

#pragma mark -
#pragma mark - UITextField+Select

/**
 当前选中的字符串范围

 @return NSRange
 */
- (NSRange)hd_selectedRange;

/**
 选中所有文字
 */
- (void)hd_selectAllText;

/**
 选中指定范围的文字

 @param range NSRange范围
 */
- (void)hd_setSelectedRange:(NSRange)range;


#pragma mark -
#pragma mark - UITextField+InputLimit

/**
 Set UITextField max length if <=0, no limit
 */
@property (assign, nonatomic) NSInteger hd_maxLength;


#pragma mark -
#pragma mark - UITextField+PlaceHolder

- (void)hd_setPlaceHolderColor:(UIColor *)color;

@end
