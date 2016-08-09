//
//  WZMessage.m
//  WanZhongProperty
//
//  Created by 万众科技 on 16/7/22.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "WZMessage.h"

@implementation WZMessage

+ (instancetype)showMessage:(NSString *)message animated:(BOOL)animated {
    WZMessage * messageView = [[self alloc] initWithMessage:message];
    [[UIApplication sharedApplication].windows.lastObject addSubview:messageView];
    [messageView show:animated];
    return messageView;
}

- (void)show:(BOOL)animated {
    if (animated) {
        CGAffineTransform originTransfrom = self.transform;
        self.alpha = 0.f;
        self.transform = CGAffineTransformMakeScale(1.2, 1.2);
        [UIView animateWithDuration:0.35 delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = originTransfrom;
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
            [self performSelector:@selector(hide) withObject:nil afterDelay:1.5];
        }];
    }else {
        [self performSelector:@selector(hide) withObject:nil afterDelay:1.5];
    }
    
}

- (void)hide {
    [UIView animateWithDuration:0.35 delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.f;
        self.y += 10.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (instancetype)initWithMessage:(NSString *)message {
    if (self = [super init]) {
        //计算字符串的尺寸
        CGSize size = [message sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0f]}];
        CGSize textSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
        
        //创建Label
        UILabel * msg = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, textSize.width + 30, textSize.height + 20)];
        msg.text = message;
        msg.font = [UIFont systemFontOfSize:15.0];
        msg.textAlignment = NSTextAlignmentCenter;
        msg.backgroundColor = [UIColor darkGrayColor];
        msg.textColor = [UIColor whiteColor];
        msg.layer.masksToBounds = YES;
        msg.layer.cornerRadius = (textSize.height + 20) / 2;
        [self addSubview:msg];
        //
        self.frame = CGRectMake(ScreenW / 2 - msg.w / 2, ScreenH * 7.0 / 9.0, msg.w, msg.h);
    }
    return self;
}


@end
