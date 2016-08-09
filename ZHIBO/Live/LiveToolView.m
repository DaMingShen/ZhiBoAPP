//
//  LiveToolView.m
//  ZHIBO
//
//  Created by 万众科技 on 16/8/1.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "LiveToolView.h"

#define itemLen 40.0

@implementation LiveToolView

- (instancetype)init {
    if (self = [super initWithFrame:CGRectMake(0, ScreenH - itemLen - 10, ScreenW, itemLen)]) {
        [self loadItems];
    }
    return self;
}

- (void)loadItems {
    NSArray * items = @[@"tool_public", @"tool_private", @"tool_sendgift", @"tool_rank", @"tool_share", @"tool_close"];
    CGFloat itemSpace = (ScreenW - itemLen * items.count) / (items.count + 1);
    for (NSInteger i = 0; i < items.count; i ++) {
        UIButton * item = [UIButton createButtonWithFrame:CGRectMake(itemSpace + (itemLen + itemSpace) * i, 0, itemLen, itemLen) Target:self Selector:@selector(itemDidClick:) Image:items[i] ImagePressed:items[i]];
        item.showsTouchWhenHighlighted = YES;
        item.tag = i;
        [self addSubview:item];
    }
}

- (void)itemDidClick:(UIButton *)sender {
    if (self.chooseBlock) {
        self.chooseBlock(sender.tag);
    }
}

@end
