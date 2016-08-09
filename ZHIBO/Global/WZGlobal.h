//
//  FxGlobal.h
//  FxHejinbo
//
//  Created by hejinbo on 15/5/12.
//  Copyright (c) 2015年 MyCos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZGlobal : NSObject


#pragma mark - 设置ROOTVC
/*
 * 用户是否已登陆 YES:已经登录 NO:未登录
 */
+ (BOOL)checkLogin;
+ (void)setLoginStatus:(BOOL)status;

/*
 * APP是否刚启动 YES:刚启动 NO:不是刚启动
 */
+ (BOOL)checkLauch;
+ (void)setLauchStatus:(BOOL)status;

/*
 * APP是否第一次打开 YES:第一次 NO:不是第一次
 */
+ (BOOL)checkFirstOpenAPP;
+ (void)setFirstOpenStatus:(BOOL)status;

/*
 * 设置rootViewController
 */
+ (void)setRootVC;

/*
 * 客户端版本 例：2.6.0
 */
+ (NSString *)clientVersion;

/*
 * 系统版本 例：iOS9.3.2
 */
+ (NSString *)platform;

/*
 * 缓存路径
 */
+ (NSString *)getRootPath; //Root路径
+ (NSString *)getCacheImage:(NSString *)fileName; //图片缓存
+ (NSString *)getUserDBFile; //数据库


@end
