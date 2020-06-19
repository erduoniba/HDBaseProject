//
//  UITextView+HDExtensions.m
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/11/29.
//

#import "UITextView+HDExtension.h"

#import <objc/runtime.h>

static const void *HDTextViewInputLimitMaxLength = &HDTextViewInputLimitMaxLength;

@implementation UITextView (HDExtension) 


#pragma mark -
#pragma mark - UITextView+InputLimit

- (NSInteger)hd_maxLength {
    return [objc_getAssociatedObject(self, HDTextViewInputLimitMaxLength) integerValue];
}
- (void)setHd_maxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, HDTextViewInputLimitMaxLength, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hd_textViewTextDidChange:)
                                                name:@"UITextViewTextDidChangeNotification" object:self];

}
- (void)hd_textViewTextDidChange:(NSNotification *)notification {
    NSString *toBeString = self.text;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];

    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //在iOS7下,position对象总是不为nil
    if ( (!position ||!selectedRange) && (self.hd_maxLength > 0 && toBeString.length > self.hd_maxLength))
    {
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.hd_maxLength];
        if (rangeIndex.length == 1)
        {
            self.text = [toBeString substringToIndex:self.hd_maxLength];
        }
        else
        {
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.hd_maxLength)];
            NSInteger tmpLength;
            if (rangeRange.length > self.hd_maxLength) {
                tmpLength = rangeRange.length - rangeIndex.length;
            }else{
                tmpLength = rangeRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark - UITextView+PlaceHolder

static const char *hd_placeHolderTextView = "hd_placeHolderTextView";

- (UITextView *)hd_placeHolderTextView {
    return objc_getAssociatedObject(self, hd_placeHolderTextView);
}

- (void)setHd_placeHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, hd_placeHolderTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)hd_addPlaceHolder:(NSString *)placeHolder {
    if (![self hd_placeHolderTextView]) {
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setHd_placeHolderTextView:textView];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];

    }
    self.hd_placeHolderTextView.text = placeHolder;
}

- (void)textViewDidBeginEditing:(NSNotification *)noti {
    self.hd_placeHolderTextView.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)noti {
    if (self.text && [self.text isEqualToString:@""]) {
        self.hd_placeHolderTextView.hidden = NO;
    }
}

#pragma mark -
#pragma mark - UITextView+Select

/**
 *  @brief  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)hd_selectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;

    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;

    NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];

    return NSMakeRange(location, length);
}

/**
 *  @brief  选中所有文字
 */
- (void)hd_selectAllText
{
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}

/**
 *  @brief  选中指定范围的文字
 *
 *  @param range NSRange范围
 */
- (void)hd_setSelectedRange:(NSRange)range
{
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

- (NSAttributedString *)hd_setRowSpace:(CGFloat)rowSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = rowSpace;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
    return attributedString;
}

- (NSMutableAttributedString *)hd_setAttributedString:(NSString *)title color:(UIColor *)color value:(NSString *)value {
    NSRange range = [self.text rangeOfString:title];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attributedString addAttribute:NSLinkAttributeName value:value range:range];
    //字体颜色
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.attributedText = attributedString;
    return attributedString;
}

@end
