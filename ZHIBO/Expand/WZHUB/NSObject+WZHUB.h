//
//  NSObject+WZHUB.h
//  WanZhongProperty
//
//  Created by 万众科技 on 16/7/22.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WZHUB;
@interface NSObject (WZHUB)

@property (nonatomic, weak, readonly) WZHUB * HUD;

- (void)ToastMessage:(NSString *)message;

- (void)showAlert:(NSString *)message;

- (void)showLoadingAni;
- (void)showLoadingAniWithCues:(NSString *)cues;
- (void)hideLoadingAni;

@end
