//
//  NSString+SuExt.h
//  SuUtility
//
//  Created by KevinSu on 15/10/17.
//  Copyright (c) 2015年 SuXiaoMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SU)

/**
 *  将url进行encode成UTF8格式的编码
 */
- (NSString *)URLEncodedString;

/**
 *  将一个对象转成字符串
 */
- (NSString *)stringWith:(id)obj;

/**
 *  追加文档目录
 */
- (NSString *)appendDocumentDir;

/**
 *  追加缓存目录
 */
- (NSString *)appendCacheDir;

/**
 *  追加临时目录
 */
- (NSString *)appendTempDir;

/**
 *  验证手机号码
 */
- (BOOL)valiMobile;

/**
 *  通过label宽度和字体大小计算它的自动换行高度
 */
- (CGFloat)getHeightWithLabelWidth:(float)labelWidth fontSize:(float)fontSize;

/**
 *  计算字符数
 */
- (NSInteger)getCharCount;

@end
