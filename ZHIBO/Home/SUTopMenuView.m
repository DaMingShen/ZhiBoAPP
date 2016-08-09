//
//  SUTopTabView.m
//  ZHIBO
//
//  Created by 万众科技 on 16/7/26.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "SUTopMenuView.h"

#define TOP_VIEW_Leading 50.0
#define TOP_VIEW_Height 44.0
#define TOP_ITEM_Count 3.0
#define TOP_ITEM_Width self.w / 3
#define TOP_LINE_Height 2.0

@interface SUTopMenuView ()

@property (nonatomic, strong) UIButton * currentMenu;
@property (nonatomic, strong) UIButton * menuHot;
@property (nonatomic, strong) UIButton * menuNew;
@property (nonatomic, strong) UIButton * menuFocus;
@property (nonatomic, strong) UIView * underLine;

@end

@implementation SUTopMenuView

+ (instancetype)topMenuView {
    return [[self alloc]initWithFrame:CGRectMake(TOP_VIEW_Leading, 0, ScreenW - TOP_VIEW_Leading * 2, TOP_VIEW_Height)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadMenus];
    }
    return self;
}

- (void)loadMenus {
    self.menuHot = [self menuWithTitle:@"热门" menuType:TopMenuHot];
    self.menuNew = [self menuWithTitle:@"最新" menuType:TopMenuNew];
    self.menuFocus = [self menuWithTitle:@"关注" menuType:TopMenuFocus];
    
    self.underLine = [[UIView alloc]initWithFrame:CGRectMake(0, TOP_VIEW_Height - TOP_LINE_Height * 3, TOP_ITEM_Width, TOP_LINE_Height)];
    self.underLine.backgroundColor = ClearColor;
    UIView * lineShow = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TOP_ITEM_Width * 2 / 3, TOP_LINE_Height)];
    lineShow.backgroundColor = WhiteColor;
    lineShow.layer.masksToBounds = YES;
    lineShow.layer.cornerRadius = TOP_LINE_Height / 2;
    lineShow.centerX = self.underLine.centerX;
    [self.underLine addSubview:lineShow];
    [self addSubview:self.underLine];
    
    self.underLineProgress = 0;
}


- (UIButton *)menuWithTitle:(NSString *)title menuType:(TopMenu)menuType {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(TOP_ITEM_Width * menuType, 0, TOP_ITEM_Width, TOP_VIEW_Height);
    button.tag = menuType;
    button.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
    [button setTitleColor:WhiteColor forState:UIControlStateSelected];
    [button setTitleColor:WhiteColor forState:UIControlStateSelected | UIControlStateHighlighted];
    [button addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}


- (void)menuAction:(UIButton *)button {
    if (button == self.currentMenu) {
        return;
    }
    if (self.chosenBlock) {
        self.chosenBlock(button.tag);
    }
}

- (void)repleceCurrentMenu:(UIButton *)menu {
    if (menu == self.currentMenu) {
        return;
    }
//    self.currentMenu.userInteractionEnabled = YES;
    self.currentMenu.selected = NO;
    self.currentMenu = menu;
    self.currentMenu.selected = YES;
//    self.currentMenu.userInteractionEnabled = NO;
}

- (void)setUnderLineProgress:(CGFloat)underLineProgress {
    _underLineProgress = underLineProgress;
    self.underLine.x = self.w * underLineProgress;
    if (self.underLine.x < self.menuHot.w / 2) {
        [self repleceCurrentMenu:self.menuHot];
    }
    else if (self.underLine.x + self.underLine.w > self.menuFocus.x + self.menuFocus.w / 2) {
        [self repleceCurrentMenu:self.menuFocus];
    }
    else {
        [self repleceCurrentMenu:self.menuNew];
    }
}

@end
