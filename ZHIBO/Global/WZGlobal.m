//
//  FxGlobal.m
//  FxHejinbo
//
//  Created by hejinbo on 15/5/12.
//  Copyright (c) 2015年 MyCos. All rights reserved.
//

#import "WZGlobal.h"
#import <sys/utsname.h>
#import <sys/sysctl.h>


@implementation WZGlobal

#pragma mark - 用户是否已经登陆
+ (BOOL)checkLogin {
    return [SuAppSetting getBool:isLogin];
}

+ (void)setLoginStatus:(BOOL)status {
    [SuAppSetting setBool:status forKey:isLogin];
}

#pragma mark - APP是否刚启动
+ (BOOL)checkLauch {
    return ![SuAppSetting getBool:isLauch];
}

+ (void)setLauchStatus:(BOOL)status {
    [SuAppSetting setBool:!status forKey:isLauch];
}

#pragma mark - APP是否第一次打开
+ (BOOL)checkFirstOpenAPP {
    return ![SuAppSetting getBool:isFirstOpen];
}

+ (void)setFirstOpenStatus:(BOOL)status {
    [SuAppSetting setBool:!status forKey:isFirstOpen];
}

#pragma mark - 设置rootViewController
+ (void)setRootVC {
    //登录页面
//    id loginVC = [[NSClassFromString(@"WZLoginViewController") alloc]init];
//    UINavigationController * NVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
//    [self restoreRootViewController:NVC];
    
    SuTabBarController * tabbarVC = [[SuTabBarController alloc]init];
    tabbarVC.VCs = @[@"HomeViewController",
                     @"MyViewController"
                     ];
    tabbarVC.Imgs = @[@"tabbar_home",
                     @"tabbar_my"
                     ];
    tabbarVC.SelectedImgs = @[@"tabbar_home_sel",
                              @"tabbar_my_sel"
                              ];
    [tabbarVC creatCustomTabbar];
    [self restoreRootViewController:tabbarVC];
}

+ (void)restoreRootViewController:(UIViewController *)rootViewController {
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [UIView transitionWithView:window
                      duration:0.3f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        //第一种效果: 淡入淡出
                        BOOL oldState = [UIView areAnimationsEnabled];                        [UIView setAnimationsEnabled:NO]; //取消激活动画
                        window.rootViewController = rootViewController;
                        [UIView setAnimationsEnabled:oldState]; //激活动画
                        //第二种效果: 有一点扩张的感觉
                        //           window.rootViewController = rootViewController;
                    }
                    completion:nil];
}



#pragma mark - 系统版本
+ (NSString *)clientVersion {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark - 设备型号
+ (NSString *)platform {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone6Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone6sPlus";
    //iPad
    if ([deviceString isEqualToString:@"iPad4,1"]
        ||[deviceString isEqualToString:@"iPad4,2"]
        ||[deviceString isEqualToString:@"iPad4,3"])      return @"iPadAir";
    if ([deviceString isEqualToString:@"iPad5,3"]
        ||[deviceString isEqualToString:@"iPad5,4"])      return @"iPadAir2";
    if ([deviceString isEqualToString:@"iPad4,4"]
        ||[deviceString isEqualToString:@"iPad4,5"]
        ||[deviceString isEqualToString:@"iPad4,6"])      return @"iPadMini2";
    if ([deviceString isEqualToString:@"iPad4,7"]
        ||[deviceString isEqualToString:@"iPad4,8"]
        ||[deviceString isEqualToString:@"iPad4,9"])      return @"iPadMini3";
    //simulator
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";

    return deviceString;
}


#pragma mark - 缓存路径
+ (NSString *)getRootPath {
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:RootPath];
    [SuFile createPath:path];
    return path;
}

+ (NSString *)getCacheImage:(NSString *)fileName {
    NSString *path = [NSString stringWithFormat:@"%@/%@", [WZGlobal getRootPath], CacheImagePath];
    [SuFile createPath:path];
    path = [NSString stringWithFormat:@"%@/%@.jpg", path, fileName];
    return path;
}

+ (NSString *)getUserDBFile {
    NSString *path = [WZGlobal getRootPath];
    return [path stringByAppendingPathComponent:WZDBFile];
}

@end
