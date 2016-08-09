//
//  SuDefine.h
//  NewsReader
//
//  Created by KevinSu on 15/10/15.
//  Copyright (c) 2015年 KevinSu. All rights reserved.
//

#ifndef SuDefine_h
#define SuDefine_h

#if DEBUG
#define WZLog(format, ...) NSLog(@"INFO:[%@ %@] " format, NSStringFromClass([self class]), NSStringFromSelector(_cmd), ## __VA_ARGS__)
#define WZLog_INFO(info)   NSLog(@"INFO:[%@ %@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), info)
#define WZLog_ERROR(err)   NSLog(@"ERROR:[%@ %@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), err)
#else
#define WZLog(format, ...)
#define WZLog_INFO(info)
#define WZLog_ERROR(error)
#endif

//弱引用的创建
#define WEAKSELF __weak __typeof(&*self)weakSelf = self;

// 设备类型判断
#define ScreenW    ([[UIScreen mainScreen] bounds].size.width)
#define ScreenH    ([[UIScreen mainScreen] bounds].size.height)
#define ScreenMaxL (MAX(ScreenW, ScreenH))
#define ScreenMinL (MIN(ScreenW, ScreenH))
#define ScreenB    [[UIScreen mainScreen] bounds]

#define IsiPhone4   (IsiPhone && ScreenMaxL < 568.0)
#define IsiPhone5   (IsiPhone && ScreenMaxL == 568.0)
#define IsiPhone6   (IsiPhone && ScreenMaxL == 667.0)
#define IsiPhone6P  (IsiPhone && ScreenMaxL == 736.0)
#define IsiPad      (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IsiPhone    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IsRetain    ([[UIScreen mainScreen] scale] >= 2.0)


// 消息通知
#define RegisterNotify(_name, _selector)                    \
[[NSNotificationCenter defaultCenter] addObserver:self  \
selector:_selector name:_name object:nil];

#define RemoveNofify            \
[[NSNotificationCenter defaultCenter] removeObserver:self];

#define SendNotify(_name, _object)  \
[[NSNotificationCenter defaultCenter] postNotificationName:_name object:_object];

// 设置颜色值
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define ClearColor      [UIColor clearColor]
#define WhiteColor      [UIColor whiteColor]
#define BlackColor      [UIColor blackColor]
#define WZBaseColor       [UIColor colorWithHexRGB:@"#f75398"]
#define WZBackgroundColor [UIColor colorWithHexRGB:@"#f5f5f5"]
#define WZBtnPressedColor [UIColor colorWithHexRGB:@"#eeeeee"]

// 文件缓存路径
#define RootPath            @"Library/.WanZhongLife"
#define CacheImagePath      @"CacheImages"
#define WZDBFile            @"WanZhongLife.db"

// iOS系统版本
#define iOS_9     9.0
#define iOS_8     8.0
#define iOS_7     7.0

#define iOS_9_Later      [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0
#define iOS_8_Later      [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define iOS_7_Later      [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

//用户信息
#define UserID      @"mobile"
#define UserToken   @"token"
#define UserSig     @"userSig"
#define isLogin     @"userIsLogin"
#define isLauch     @"appIsJustLauch"
#define isFirstOpen @"appFirstOpen"
#define LoginSUCC   @"loginSUCC"
#define LoginFAIL   @"LoginFAIL"
#define UpdateCitySucc @"UpdateCitySucc"

//商城
#define UpdateCar @"updateShoppingCarInfo"
#define UpdateCarCount @"updateShoppingCarCount"


//网络相关
#define NetResult           @"result"
#define NetResultCode       @"code"
#define NetOk               0
#define NetData             @"data"
#define NetMessage          @"msg"
#define NetInvalidateToken  @"invalidetoken"
#define HTTPSchema          @"http:"
#define HTTPGET             @"GET"
#define HTTPPOST            @"POST"
#define RequestTimeout      8

//网络变化
#define NetworkEnable  @"NetworkIsReachability"
#define NetworkDisable @"NetworkIsNotReachability"

//通知
#define UpdateUserInfoSUCC @"UpdateUserInfoSUCC"
#define UpdateUserInfoFAIL @"UpdateUserInfoFAIL"

//默认图片
#define DefaultImg [UIImage imageNamed:@"Public_default.png"]

//按比例缩放值
#define WZScaleRatio ScreenW / 375.0

//公共值
#define WZNavHeight    64.0
#define WZTabbarHeight 49.0

#endif
