//
//  NSDictionary+SuExt.m
//  NewsReader
//
//  Created by KevinSu on 15/10/17.
//  Copyright (c) 2015年 KevinSu. All rights reserved.
//

#import "NSDictionary+SU.h"
#import <objc/runtime.h>

@implementation NSDictionary (SU)

/*
- (int)tCount {
    NSNumber * tCountNum = objc_getAssociatedObject(self, @selector(tCount));
    return tCountNum == nil ? 1 : [tCountNum intValue];
}

- (void)setTCount:(int)tCount {
    objc_setAssociatedObject(self, @selector(tCount), @(tCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
*/

- (NSString *)getObjectFromKey:(NSString *)key {
    
    NSString * obj = [self valueForKey:key];
    
    if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%@",obj];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];

    if(err) {

        return nil;
    }
    
    return dic;
}

/*
- (NSString *)descriptionWithLocale:(id)locale
{
    // 在iOS中，如果数据包含在数组或者字典中，直接打印看不到结果，所以需要重写此方法，修正此BUG
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary * objDic = (NSDictionary *)obj;
            objDic.tCount = self.tCount + 1;
        }
        for (int i = 0; i < self.tCount; i ++) {
            [strM appendString:@"\t"];
        }
        [strM appendFormat:@"%@ : %@,\n", key, obj];
    }];
    
    [strM appendString:@"}"];
    
    return strM;
}
*/
 
@end
