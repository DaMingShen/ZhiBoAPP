//
//  NewListCell.m
//  ZHIBO
//
//  Created by 万众科技 on 16/7/29.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "NewListCell.h"
#import "NewListModel.h"

@implementation NewListCell

- (void)setModel:(NewListModel *)model {
    _model = model;
    //
    [self.starImg sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"placeholder_head"]];
    [self.starLocation setTitle:model.position.length > 0 ? model.position : @"来自喵星" forState:UIControlStateNormal];
    self.isNewStar.hidden = model.isNew ? NO : YES;
    if (model.starlevel > 0) {
        self.starLevelImg.hidden = NO;
        self.starLevelImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_star%ld", model.starlevel]];
    }else {
        self.starLevelImg.hidden = YES;
    }
    self.starName.text = model.nickname;
}

@end
