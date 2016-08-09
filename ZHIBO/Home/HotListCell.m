//
//  HotListCell.m
//  ZHIBO
//
//  Created by 万众科技 on 16/7/26.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "HotListCell.h"
#import "HotListModel.h"

@interface HotListCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIButton    *locationBtn;
@property (weak, nonatomic) IBOutlet UILabel     *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *startView;
@property (weak, nonatomic) IBOutlet UILabel     *chaoyangLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bigPicView;
@end

@implementation HotListCell

- (void)setModel:(HotListModel *)model
{
    _model = model;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.smallpic] placeholderImage:[UIImage imageNamed:@"placeholder_head"]];
    self.nameLabel.text = model.myname;
    [self.locationBtn setTitle:model.gps.length > 0 ? model.gps : @"来自喵星" forState:UIControlStateNormal];
    [self.bigPicView sd_setImageWithURL:[NSURL URLWithString:model.bigpic] placeholderImage:[UIImage imageNamed:@"placeholder_star"]];
    if (model.starlevel > 0) {
        self.startView.hidden = NO;
        self.startView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_star%ld", model.starlevel]];
    }else {
        self.startView.hidden = YES;
    }
    //观众数量
    NSString *fullChaoyang = [NSString stringWithFormat:@"%ld人在看", model.allnum];
    NSRange range = [fullChaoyang rangeOfString:[NSString stringWithFormat:@"%ld", model.allnum]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:fullChaoyang];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range: range];
    [attr addAttribute:NSForegroundColorAttributeName value:WZBaseColor range:range];
    self.chaoyangLabel.attributedText = attr;
}

@end
