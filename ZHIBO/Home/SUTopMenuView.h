//
//  SUTopTabView.h
//  ZHIBO
//
//  Created by 万众科技 on 16/7/26.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "SUBaseView.h"

typedef enum : NSUInteger {
    TopMenuHot = 0,
    TopMenuNew = 1,
    TopMenuFocus = 2,
} TopMenu;

@interface SUTopMenuView : SUBaseView

@property (nonatomic, copy) void(^chosenBlock)(TopMenu menu);
@property (nonatomic, assign) CGFloat underLineProgress;

+ (instancetype)topMenuView;

@end
