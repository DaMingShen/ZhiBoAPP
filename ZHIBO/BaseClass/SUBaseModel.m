//
//  SUModel.m
//  ZHIBO
//
//  Created by 万众科技 on 16/7/26.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "SUBaseModel.h"

@implementation SUBaseModel

+ (instancetype)modelFromDict:(NSDictionary *)dict {
    //JSON KEY MAPPING
    if ([self jsonKeyMapping]) {
        [self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return [self jsonKeyMapping];
        }];
    }
    //ARRAY KEY MAPPING
    if ([self arrayKeyMapping]) {
        [self mj_setupObjectClassInArray:^NSDictionary *{
            return [self arrayKeyMapping];
        }];
    }
    return [self mj_objectWithKeyValues:dict];
}

+ (NSArray *)modelArrayFromDict:(NSDictionary *)dict {
    NSArray * dictArray = [dict objectForKey:API_RESULT_DATA];
    return [[self class] modelArrayFromDictArray:dictArray];
}

+ (NSArray *)modelArrayFromDictArray:(NSArray *)array {
    NSMutableArray * infos = [NSMutableArray array];
    for (NSDictionary * dict in array) {
        [infos addObject:[[self class] modelFromDict:dict]];
    }
    return infos;
}

#pragma mark - override
//模型中的属性名和字典中的key不相同(或者需要多级映射)
+ (NSDictionary *)jsonKeyMapping {
    return nil;
    /* example:
     return @{
     @"ID" : @"id",
     @"desc" : @"desciption",
     @"oldName" : @"name.oldName",
     @"nowName" : @"name.newName",
     @"nameChangedTime" : @"name.info[1].nameChangedTime",
     @"bag" : @"other.bag"
     };
     */
}

//模型中有个数组属性，数组里面又要装着其他模型
+ (NSDictionary *)arrayKeyMapping {
    return nil;
    /* example:
     return @{
     @"statuses" : @"Status",
     // @"statuses" : [Status class],
     @"ads" : @"Ad"
     // @"ads" : [Ad class]
     };
     */
}

@end
