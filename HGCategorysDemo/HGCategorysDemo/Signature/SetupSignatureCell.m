//
//  SetupSignatureCell.m
//  HGTextView
//
//  Created by  ZhuHong on 2017/6/1.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "SetupSignatureCell.h"
#import "UITextView+HG.h"

@interface SetupSignatureCell () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@property (nonatomic, assign) NSInteger maxCount;
@end

@implementation SetupSignatureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textView.textContainerInset = UIEdgeInsetsMake(10.0, 6.5, 0, 0);
    self.maxCount = 30;
    
}

- (void)setSignatureTEXT:(NSString *)signatureTEXT {
    _signatureTEXT = signatureTEXT.copy;
    
    self.placeholderLabel.hidden = (signatureTEXT.length > 0);
    self.countLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.signatureTEXT.length, (self.maxCount - self.signatureTEXT.length)];;
    
    self.textView.text = self.signatureTEXT;
}

- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
    
    self.countLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.signatureTEXT.length, (self.maxCount - self.signatureTEXT.length)];;
}

#pragma mark -
#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    // 必须要在这里弄.
    self.placeholderLabel.hidden = (textView.text.length > 0);;
    
    // 如果在变化中是高亮部分在变，就不要计算字符了
    if (textView.hg_isHighLighted) {
        return ;
    }
    
    // 主要是处理当输入超出限制时的优化
    if (textView.text.length > self.maxCount) {
        [textView hg_invalidTextFieldCurContent:_signatureTEXT];
    }
    
    // 代理
    if (self.delegate && [self.delegate respondsToSelector:@selector(setupSignatureCell:didChangedValue:)]) {
        [self.delegate setupSignatureCell:self didChangedValue:textView.text];
    }
    
    // 保留
    // 不能这么调用
//    self.signatureTEXT = textView.text;
    
    // 正确的姿势是这样的
    _signatureTEXT = textView.text;
    _countLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.signatureTEXT.length, (self.maxCount - self.signatureTEXT.length)];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    // 只要是删除,都可以
    if ([text isEqualToString:@""]) {
        return YES;
    }

    // 如果在变化中是高亮部分在变，就不要计算字符了
    if (textView.hg_isHighLighted) {
        return YES;
    }
    
    // 当前输入框 大于等于 最大限制都不可以输入
    if (textView.text.length >= self.maxCount) {
        return NO;
    }
    
    return YES;
}

@end
