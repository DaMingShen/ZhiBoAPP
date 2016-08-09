//
//  WZNetworkMonitor.h
//  WanZhongProperty
//
//  Created by 万众科技 on 16/7/22.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZNetworkMonitor : NSObject

+ (instancetype)monitor;

- (void)start;

+ (BOOL)networkEnable;

@end
