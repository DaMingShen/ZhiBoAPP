//
//  WZOperation.m
//  WanZhongProperty
//
//  Created by 万众科技 on 16/7/22.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "WZOperation.h"
#import "WZNetworkMonitor.h"

#define NO_NETWORK_HINT @"当前无网络连接"

@implementation WZOperation

+ (void)findSellerWithID:(NSString *)sellerID success:(void(^)(NSArray * typeInfos))success failure:(void(^)(NSString * msg, NSError * error))failure {
    [self GET:@"www.baidu.com" success:^(id data) {
        NSDictionary * dict = (NSDictionary *)data;
        //转换成model
    } failure:failure];
}





@end

@implementation WZOperation (networkManager)

+ (AFHTTPSessionManager *)manager {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.requestSerializer.timeoutInterval = RequestTimeout;
    return manager;
}

+ (void)GET:(NSString *)URLString success:(void (^)(id data))success failure:(void (^)(NSString * msg, NSError * error))failure {
    [[self manager]GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        WZLog_INFO(responseObject);
        if ([[responseObject objectForKey:API_RESULT_CODE] intValue] == 100) {
            if (success) {
                success([responseObject objectForKey:API_RESULT_DATA]);
            }
        }else {
            if (failure) {
                failure([responseObject objectForKey:API_RESULT_MESSAGE], nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(NO_NETWORK_HINT, error);
        }
    }];
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id data))success failure:(void (^)(NSString * msg, NSError * error))failure {
    /*
     //如果无网络连接，不作请求
    if (![WZNetworkMonitor networkEnable]) {
        if (failure) {
            failure(NO_NETWORK_HINT, nil);
        }
        return;
    }
     */
    [[self manager]POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:API_RESULT_CODE] intValue] == 100) {
            if (success) {
                success([responseObject objectForKey:API_RESULT_DATA]);
            }
        }else {
            if (failure) {
                failure([responseObject objectForKey:API_RESULT_MESSAGE], nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(NO_NETWORK_HINT, error);
        }
    }];
}

@end
