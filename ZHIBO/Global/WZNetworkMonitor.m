//
//  WZNetworkMonitor.m
//  WanZhongProperty
//
//  Created by 万众科技 on 16/7/22.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "WZNetworkMonitor.h"
#import "Reachability.h"

@interface WZNetworkMonitor ()<UIAlertViewDelegate>

@property (nonatomic, strong) Reachability * internetReachability;
@property (nonatomic, strong) UIAlertView * alertView;

@end

@implementation WZNetworkMonitor

+ (instancetype)monitor {
    static WZNetworkMonitor * monitor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monitor = [[WZNetworkMonitor alloc]init];
    });
    return monitor;
}

- (void)start {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
}

- (void)reachabilityChanged:(NSNotification *)note {
    Reachability * reachability = [note object];
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    switch (netStatus) {
        case NotReachable: {
            WZLog(@"无网络");
            //如果当前有显示，则不再继续显示
            if (self.alertView) return;
            if (iOS_8_Later) {
                self.alertView = [[UIAlertView alloc]initWithTitle:nil message:@"当前没有网络\n请检查您的网络设置" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"设置", nil];
            }else {
                self.alertView = [[UIAlertView alloc]initWithTitle:nil message:@"当前没有网络\n请检查您的网络设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            }
            [self.alertView show];
            break;
        }
        case ReachableViaWWAN: {
            WZLog(@"Wi-Fi");
            if (self.alertView) {
                [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
                self.alertView = nil;
            }
            break;
        }
        case ReachableViaWiFi: {
            WZLog(@"移动数据");
            if (self.alertView) {
                [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
                self.alertView = nil;
            }
            break;
        }
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex) {
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];  //跳转到系统设置
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url];
        }
    }
    self.alertView = nil;
}

- (void)dealloc {
    [self.internetReachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

#pragma mark -
+ (BOOL)networkEnable {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

@end
