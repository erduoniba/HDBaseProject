//
//  UITextField+HDExtension.m
//  HDBaseProject
//
//  Created by 邓立兵 on 2017/11/28.
//

#import "UITextField+HDExtension.h"

#import <objc/runtime.h>

@implementation UITextField (HDExtension)

@dynamic hd_maxLength;

#pragma mark -
#pragma mark - UITextField+Select


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

- (void)hd_selectAllText
{
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}


- (void)hd_setSelectedRange:(NSRange)range
{
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}


#pragma mark -
#pragma mark - UITextField+Limit

static const void *HDTextFieldInputLimitMaxLength = &HDTextFieldInputLimitMaxLength;

- (NSInteger)hd_maxLength {
    return [objc_getAssociatedObject(self, HDTextFieldInputLimitMaxLength) integerValue];
}
- (void)sethd_maxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, HDTextFieldInputLimitMaxLength, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    [self addTarget:self action:@selector(hd_textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)hd_textFieldTextDidChange {
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

#pragma mark -
#pragma mark - UITextField+PlaceHolder
- (void)hd_setPlaceHolderColor:(UIColor *)color {
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

@end
