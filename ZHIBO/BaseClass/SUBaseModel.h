//
//  SUModel.h
//  ZHIBO
//
//  Created by 万众科技 on 16/7/26.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SUBaseModel : NSObject

//从字典获取modol实例
+ (instancetype)modelFromDict:(NSDictionary *)dict;

//从字典获取model数组
+ (NSArray *)modelArrayFromDict:(NSDictionary *)dict;

//从字典数组获取model数组
+ (NSArray *)modelArrayFromDictArray:(NSArray *)array;

@end
