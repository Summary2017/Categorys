//
//  NSString+Regex.h
//  CategoryManager
//
//  Created by  ZhuHong on 2017/4/8.
//  Copyright © 2017年 HG_APP. All rights reserved.
//

#import <Foundation/Foundation.h>

// 基本匹配 : 数字, 汉字, 字符, 空格, 下划线, 点, @
typedef NS_OPTIONS(NSUInteger, HGRegexType) {
    HGRegexTypeNone      = 0 << 0, // 未知
    HGRegexTypeDigital   = 1 << 0, // 数字
    HGRegexTypeChinese   = 1 << 1, // 汉字
    HGRegexTypeCharacter = 1 << 2, // 字符
    HGRegexTypeSpace     = 1 << 3, // 空格
    HGRegexTypeUnderline = 1 << 4, // 下划线
    HGRegexTypeDot       = 1 << 5, // 点
    HGRegexTypeAT        = 1 << 6, // @
};

// 是否支持空字符串

@interface NSString (Regex)

/**
 * 通过 pattern 进行匹配
 */
- (BOOL)hg_regexMatchWithPattern:(NSString*)pattern;

/**
 * 基本匹配: 默认支持空字符串返回为YES的情况
 */
- (BOOL)hg_regexMatchWithType:(HGRegexType)rType;

/**
 * 基本匹配: 是否支持空字符串返回为YES的情况
 */
- (BOOL)hg_regexMatchWithType:(HGRegexType)rType returnWhenEmpty:(BOOL)empty;

/**
 * 基本匹配: 默认支持空字符串返回为YES的情况
 * 最大限制为 maxLimit 位
 */
- (BOOL)hg_regexMatchWithType:(HGRegexType)rType
                maxLimitLength:(NSUInteger)maxLimit;

/**
 * 基本匹配: 是否支持空字符串返回为YES的情况
 * 最大限制为 maxLimit 位
 */
- (BOOL)hg_regexMatchWithType:(HGRegexType)rType maxLimitLength:(NSUInteger)maxLimit returnWhenEmpty:(BOOL)empty ;


- (NSString*)hg_replaceStringInPattern:(NSString *)pattern withString:(NSString*)toString;

@end
