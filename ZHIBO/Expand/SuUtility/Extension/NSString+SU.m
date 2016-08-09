//
//  NSString+SuExt.m
//  SuUtility
//
//  Created by KevinSu on 15/10/17.
//  Copyright (c) 2015年 SuXiaoMing. All rights reserved.
//

#import "NSString+SU.h"

@implementation NSString (SU)

/**
 *  将url进行encode成UTF8格式的编码
 */
- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                    (CFStringRef)self,
                                                                                                    (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                                                    NULL,
                                                                                                    kCFStringEncodingUTF8));
    return encodedString;
}

/**
 *  将一个对象转成字符串
 */
- (NSString *)stringWith:(id)obj {
    
    return [NSString stringWithFormat:@"%@",obj];
}

/**
 *  追加文档目录
 */
- (NSString *)appendDocumentDir{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    return [self appendWithPath:path];
}

/**
 *  追加缓存目录
 */
- (NSString *)appendCacheDir{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    return [self appendWithPath:path];
}

/**
 *  追加临时目录
 */
- (NSString *)appendTempDir{
    NSString *path = NSTemporaryDirectory();
    return [self appendWithPath:path];
}

// 在传入的路径后拼接当前的字符串
- (NSString *)appendWithPath:(NSString *)path{
    return [path stringByAppendingPathComponent:self];
}

- (BOOL)valiMobile {
    
    if (self.length < 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:self];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:self];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:self];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

- (CGFloat)getHeightWithLabelWidth:(float)labelWidth fontSize:(float)fontSize {
    
    CGSize size = CGSizeMake(labelWidth, CGFLOAT_MAX);
    CGRect rect = [self boundingRectWithSize:size
                                     options:NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]}
                                     context:NULL];
    return rect.size.height;
}

- (NSInteger)getCharCount {
    NSUInteger len = self.length;
    // 汉字字符集
    NSString * pattern  = @"[\u4e00-\u9fa5]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    // 计算中文字符的个数
    NSInteger numMatch = [regex numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, len)];
    return len + numMatch;
}


@end
