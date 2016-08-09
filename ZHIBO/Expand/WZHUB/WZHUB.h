//
//  WZHUB.h
//  WanZhongProperty
//
//  Created by 万众科技 on 16/7/22.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZHUB : UIView

+ (instancetype)showHUDWithCues:(NSString *)cues;
+ (instancetype)showHUDWithCues:(NSString *)cues toView:(UIView *)view;
- (void)hide;

@end
