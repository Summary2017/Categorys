//
//  UITextField+OKA.h
//  CategoryManager
//
//  Created by  ZhuHong on 2017/2/22.
//  Copyright © 2017年 HG_APP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (HG)


/** 跟随UITextView的脚步 */
@property (nonatomic, assign) NSRange hg_selectedRange;

/** 是否高亮 */
@property (nonatomic, readonly) BOOL hg_isHighLighted;


/**
 输入无效,将已经数据的打回原形
 
 @param curContent 希望当前的显示内容
 */
- (void)invalidTextFieldCurContent:(NSString*)curContent;


@end
