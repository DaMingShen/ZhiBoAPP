//
//  LiveToolView.h
//  ZHIBO
//
//  Created by 万众科技 on 16/8/1.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "SUBaseView.h"

typedef enum : NSUInteger {
    LiveToolPublic = 0,
    LiveToolPrivate,
    LiveToolGift,
    LiveToolRank,
    LiveToolShare,
    LiveToolClose
} LiveTool;

@interface LiveToolView : SUBaseView

@property (nonatomic, copy) void(^chooseBlock)(LiveTool liveTool);

@end
