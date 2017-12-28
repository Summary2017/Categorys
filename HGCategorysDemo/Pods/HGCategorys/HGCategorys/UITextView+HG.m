//
//  UITextView+OKA.m
//  CategoryManager
//
//  Created by  ZhuHong on 2017/2/22.
//  Copyright © 2017年 HG_APP. All rights reserved.
//

#import "UITextView+HG.h"

@implementation UITextView (HG)

/**
 * 获取高亮部分
 */
- (NSInteger)getInputLengthWithText:(NSString *)text
{
    NSInteger textLength = 0;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    if (selectedRange) {
        NSString *newText = [self textInRange:selectedRange];
        textLength = (newText.length + 1) / 2 + [self offsetFromPosition:self.beginningOfDocument toPosition:selectedRange.start] + text.length;
    } else {
        textLength = self.text.length + text.length;
    }
    return textLength;
}


/**
 输入无效,将已经数据的打回原形
 
 @param curContent 希望当前的显示内容
 */
- (void)invalidTextFieldCurContent:(NSString*)curContent {
    // 保留光标的位置信息
    NSRange selectedRange = self.selectedRange;
    // 保留当前文本的内容
    NSString* tmpSTR = self.text;
    
    // 设置了文本,光标到了最后
    self.text = curContent;
    
    // 重新设置光标的位置
    selectedRange.location -= (tmpSTR.length - curContent.length);
    
    [self setSelectedRange:selectedRange];
}

@end
