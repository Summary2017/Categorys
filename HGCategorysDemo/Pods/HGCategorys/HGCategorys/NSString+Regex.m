//
//  NSString+Regex.m
//  CategoryManager
//
//  Created by  ZhuHong on 2017/4/8.
//  Copyright © 2017年 HG_APP. All rights reserved.
//

#import "NSString+Regex.h"

@implementation NSString (Regex)

/**
 * 通过 regexTEXT 进行匹配
 */
- (BOOL)hg_regexMatchWithPattern:(NSString*)pattern {
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:self];
}

/**
 * 基本匹配
 */
- (BOOL)hg_regexMatchWithType:(HGRegexType)rType {
    // 默认支持空字符串返回为YES的情况
    return [self hg_regexMatchWithType:rType returnWhenEmpty:YES];
}

/**
 * 基本匹配: 是否支持空字符串返回为YES的情况
 */
- (BOOL)hg_regexMatchWithType:(HGRegexType)rType returnWhenEmpty:(BOOL)empty {
    if (rType == HGRegexTypeNone) {
        // 没有任何的限制
        return YES;
    }
    
    if (self.length == 0) {
        return empty;
    }
    
    // 非空, 进行基本匹配
    NSString *regex = [self p_regexMatchesWithType:rType];
    return [self hg_regexMatchWithPattern:regex];
}

/**
 * 基本匹配: 默认支持空字符串返回为YES的情况
 * 最大限制为 maxLimit 位
 */
- (BOOL)hg_regexMatchWithType:(HGRegexType)rType maxLimitLength:(NSUInteger)maxLimit {
    return [self hg_regexMatchWithType:rType maxLimitLength:maxLimit returnWhenEmpty:YES ];
}

/**
 * 基本匹配: 是否支持空字符串返回为YES的情况
 * 最大限制为 maxLimit 位
 */
- (BOOL)hg_regexMatchWithType:(HGRegexType)rType maxLimitLength:(NSUInteger)maxLimit returnWhenEmpty:(BOOL)empty {
    if (self.length > maxLimit) {
        return NO;
    }
    
    return [self hg_regexMatchWithType:rType returnWhenEmpty:empty];
}

#pragma mark -
#pragma mark - private
- (NSString*)p_regexMatchesWithType:(HGRegexType)rType {
    
    NSString *regex = @"";
    if (rType & HGRegexTypeDigital) {
        // 数字
        regex = [NSString stringWithFormat:@"%@\\d", regex];
    }
    
    if (rType & HGRegexTypeChinese) {
        // 中文
        regex = [NSString stringWithFormat:@"➋➌➍➎➏➐➑➒%@\u4e00-\u9fa5", regex];
    }
    
    if (rType & HGRegexTypeCharacter) {
        // 字符
        regex = [NSString stringWithFormat:@"%@a-zA-Z", regex];
    }
    
    if (rType & HGRegexTypeSpace) {
        // 空格
        regex = [NSString stringWithFormat:@"%@ ", regex];
    }
    
    if (rType & HGRegexTypeUnderline) {
        // 下划线
        regex = [NSString stringWithFormat:@"%@_", regex];
    }
    
    if (rType & HGRegexTypeDot) {
        // 点
        regex = [NSString stringWithFormat:@"%@.", regex];
    }
    
    if (rType & HGRegexTypeAT) {
        // @
        regex = [NSString stringWithFormat:@"%@@", regex];
    }
    
    regex = [NSString stringWithFormat:@"^[%@]+$", regex];
    return regex;
}

- (NSString *)hg_replaceStringInPattern:(NSString *)pattern withString:(NSString *)toString {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray<NSTextCheckingResult *> *result = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    NSString *retStr = [self copy];
    if (result) {
        for (int i = 0; i<result.count; i++) {
            NSTextCheckingResult *res = result[i];
            retStr = [retStr stringByReplacingOccurrencesOfString:[self substringWithRange:res.range]
                                                       withString:toString];
        }
    }
    return retStr;
}

@end
