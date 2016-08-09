//
//  WZUserConfig.m
//  WanZhongProperty
//
//  Created by 万众科技 on 16/7/13.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "WZUserConfig.h"

@implementation WZUserConfig

+ (instancetype)shareConfig {
    static WZUserConfig * userConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userConfig = [[WZUserConfig alloc]init];
    });
    return userConfig;
}

@end
