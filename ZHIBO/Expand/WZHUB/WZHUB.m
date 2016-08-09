//
//  WZHUB.m
//  WanZhongProperty
//
//  Created by 万众科技 on 16/7/22.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "WZHUB.h"

@implementation WZHUB

+ (instancetype)showHUDWithCues:(NSString *)cues {
    return [[self alloc]initWithCues:cues toView:nil onPanel:NO];
}

+ (instancetype)showHUDWithCues:(NSString *)cues toView:(UIView *)view {
    return [[self alloc]initWithCues:cues toView:view onPanel:NO];
}

- (instancetype)initWithCues:(NSString *)cues toView:(UIView *)view onPanel:(BOOL)isOnPanel {
    if (self = [super initWithFrame:ScreenB]) {
        self.backgroundColor = ClearColor;
        if (isOnPanel) {
            UIView * bg = [[UIView alloc]initWithFrame:ScreenB];
            bg.backgroundColor = BlackColor;
            bg.alpha = 0.3;
            [self addSubview:bg];
            
            UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
            effe.frame = CGRectMake(0, 0, 160, 80);
            effe.center = CGPointMake(ScreenW / 2, ScreenH / 2 + 10);
            effe.layer.masksToBounds = YES;
            effe.layer.cornerRadius = 15.0;
            [self addSubview:effe];
        }
        //动画
        UIImageView * aniIv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        aniIv.center = CGPointMake(ScreenW / 2, ScreenH / 2);
        aniIv.animationImages = [NSArray arrayWithObjects:
                                 [UIImage imageNamed:@"reflesh1"],
                                 [UIImage imageNamed:@"reflesh2"],
                                 [UIImage imageNamed:@"reflesh3"], nil];
        
        aniIv.animationDuration = 0.4;
        aniIv.animationRepeatCount = 2000;
        [aniIv startAnimating];
        [self addSubview:aniIv];
        //提示
        UILabel * msg = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 20)];
        msg.center = CGPointMake(ScreenW / 2, aniIv.y + aniIv.h + 10);
        msg.text = cues;
        msg.textColor = WZBaseColor;
        msg.font = [UIFont systemFontOfSize:14.0];
        msg.textAlignment = NSTextAlignmentCenter;
        msg.backgroundColor = ClearColor;
        self.alpha = 0.02f;
        [self addSubview:msg];
        //加到视图中
        if (view) {
            [view addSubview:self];
        }else {
            [[UIApplication sharedApplication].windows.lastObject addSubview:self];
        }
        [self performSelector:@selector(delayShowAniView) withObject:nil afterDelay:0.f];
    }
    return self;
}

- (void)delayShowAniView {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1.0;
    }];
}

- (void)hide {
    [self removeFromSuperview];
}

@end
