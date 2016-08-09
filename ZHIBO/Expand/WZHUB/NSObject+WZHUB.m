//
//  NSObject+WZHUB.m
//  WanZhongProperty
//
//  Created by 万众科技 on 16/7/22.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "NSObject+WZHUB.h"
#import "WZMessage.h"
#import "WZHUB.h"
#import <objc/runtime.h>

@implementation NSObject (WZHUB)

- (void)setHUD:(WZHUB *)HUD {
    objc_setAssociatedObject(self, @selector(HUD), HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WZHUB *)HUD {
    return objc_getAssociatedObject(self, @selector(HUD));
}

#pragma mark - MESSAGE
- (void)ToastMessage:(NSString *)message {
    if ([self isKindOfClass:[UIViewController class]] || [self isKindOfClass:[UIView class]]) {
        [WZMessage showMessage:message animated:YES];
    }
}

#pragma mark - ALERT
- (void)showAlert:(NSString *)message {
    [[[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}

#pragma mark - LOADING_ANI
- (void)showLoadingAni {
    if (![self isKindOfClass:[UIView class]]) return;
    self.HUD = [WZHUB showHUDWithCues:@"加载中..." toView:(UIView *)self];
}

- (void)showLoadingAniWithCues:(NSString *)cues {
    self.HUD = [WZHUB showHUDWithCues:cues toView:nil];
}

- (void)hideLoadingAni {
    if (!self.HUD) return;
    [self.HUD hide];
    self.HUD = nil;
}

#pragma mark - LOADSTATUS_HINT
- (void)showNoDataHintWithCues:(NSString *)cues {
    
}

- (void)showLoadErrorWithRetry:(void(^)())retry {
    
}

@end
