//
//  WZOperation.h
//  WanZhongProperty
//
//  Created by 万众科技 on 16/7/22.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZOperation : NSObject

@end

@interface WZOperation (networkManager)

+ (void)GET:(NSString *)URLString success:(void (^)(id data))success failure:(void (^)(NSString * msg, NSError * error))failure;
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id data))success failure:(void (^)(NSString * msg, NSError * error))failure;

@end
