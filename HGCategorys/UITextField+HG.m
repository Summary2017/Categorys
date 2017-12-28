//
//  UITextField+OKA.m
//  CategoryManager
//
//  Created by  ZhuHong on 2017/2/22.
//  Copyright © 2017年 HG_APP. All rights reserved.
//

#import "UITextField+HG.h"

@implementation UITextField (HG)

- (NSRange)hg_selectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

- (void)setHg_selectedRange:(NSRange)hg_selectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:hg_selectedRange.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:hg_selectedRange.location + hg_selectedRange.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    
    [self setSelectedTextRange:selectionRange];
}

- (BOOL)hg_isHighLighted {
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *pos = [self positionFromPosition:selectedRange.start offset:0];
    return (selectedRange && pos);
    
}


/**
 输入无效,将已经数据的打回原形
 
 @param curContent 希望当前的显示内容
 */
- (void)invalidTextFieldCurContent:(NSString*)curContent {
    // 保留光标的位置信息
    NSRange selectedRange = self.hg_selectedRange;
    // 保留当前文本的内容
    NSString* tmpSTR = self.text;
    
    // 设置了文本,光标到了最后
    self.text = curContent;
    
    // 重新设置光标的位置
    selectedRange.location -= (tmpSTR.length - curContent.length);
    
    [self setHg_selectedRange:selectedRange];
}

@end
