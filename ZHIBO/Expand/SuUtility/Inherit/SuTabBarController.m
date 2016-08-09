//
//  SuTabBarController.m
//  tabbartest
//
//  Created by KevinSu on 15/11/4.
//  Copyright (c) 2015年 SuXiaoMing. All rights reserved.
//

#import "SuTabBarController.h"

const CGFloat oneKeyLen = 69.0;

@interface SuTabBarController () {
    UIButton * _currentItem;
}

@end

@implementation SuTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.buttonItemArray = [NSMutableArray array];
    self.msgTitleArray = [NSMutableArray array];
    //设置tabbar样式
    [self configUI];
}

- (void)configUI {
    self.tabBar.barTintColor = WhiteColor;
    self.tabBar.tintColor = [UIColor colorWithHexRGB:@"#ff9600"];
}

#pragma mark - 自定义tabbar
- (void)creatCustomTabbar {
    for (int i = 0; i < self.VCs.count; i ++) {
        [self addVCWithClass:self.VCs[i] Title:self.Titles[i] Image:self.Imgs[i] SelectedImage:self.SelectedImgs[i]];
    }
    [self setupCustomTabbar];
}

- (void)addVCWithClass:(NSString *)class Title:(NSString *)title Image:(NSString *)image SelectedImage:(NSString *)selectedImage {
    //创建一个界面(包含导航)
    UIViewController * VC = [[NSClassFromString(class) alloc]init];
    VC.title = title;
    UINavigationController * NVC = [[UINavigationController alloc]initWithRootViewController:VC];
    NVC.tabBarItem.image = [UIImage imageNamed:image];
    NVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];// 始终绘制图片原始状态，不使用Tint Color
    //添加到tabBar中
    NSMutableArray * viewControllers = [[NSMutableArray alloc]initWithArray:self.viewControllers];
    [viewControllers addObject:NVC];
    self.viewControllers = viewControllers;
}

- (void)setupCustomTabbar {
    //隐藏原生tabbar
    self.tabBar.hidden = YES;
    
    //自定义tabbar
    _customTabbar = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenH - WZTabbarHeight, ScreenW, WZTabbarHeight)];
    _customTabbar.backgroundColor = WhiteColor;
    [self.view addSubview:_customTabbar];
    
    //左item
    UIButton * leftItem = [self tabbarItemWithIndex:0 frame:CGRectMake(0, 0, ScreenW / 3.0, WZTabbarHeight)];
    [self.buttonItemArray addObject:leftItem];
    [_customTabbar addSubview:leftItem];
    
    _currentItem = leftItem;
    _currentItem.selected = YES;
    
    //右item
    UIButton * rightItem = [self tabbarItemWithIndex:1 frame:CGRectMake((ScreenW / 3.0) * 2, 0, ScreenW / 3.0, WZTabbarHeight)];
    [self.buttonItemArray addObject:rightItem];
    [_customTabbar addSubview:rightItem];
    
    //中item
    UIButton * middleItem = [self tabbarItemWithIndex:666 frame:CGRectMake(ScreenW / 3.0, 0, ScreenW / 3.0, WZTabbarHeight)];
    [_customTabbar addSubview:middleItem];
    
    //分割线
    UIView * topLine = [UIView drawHorizonLineWithFrame:CGRectMake(0, 0, ScreenW, 1)];
    [_customTabbar addSubview:topLine];
}

- (UIButton *)tabbarItemWithIndex:(NSInteger)index frame:(CGRect)frame {
    UIButton * item = [UIButton buttonWithType:UIButtonTypeCustom];
    item.tag = index;
    item.frame = frame;
    if (index == 666) {
        [item setImage:[UIImage imageNamed:@"tabbar_show"] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:@"tabbar_show"] forState:UIControlStateHighlighted];
        [item setImage:[UIImage imageNamed:@"tabbar_show"] forState:UIControlStateSelected];
        [item addTarget:self action:@selector(specialItemDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }else {
        if (self.Titles) {
            //标题
            [item setTitle:self.Titles[index] forState:UIControlStateNormal];
            item.titleLabel.font = [UIFont systemFontOfSize:11.0];
            //颜色
            [item setTitleColor:[UIColor colorWithHexRGB:@"#a0a0a0"] forState:UIControlStateNormal];
            [item setTitleColor:WZBaseColor forState:UIControlStateHighlighted];
            [item setTitleColor:WZBaseColor forState:UIControlStateSelected];
        }
        //图片
        [item setImage:[UIImage imageNamed:self.Imgs[index]] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:self.SelectedImgs[index]] forState:UIControlStateHighlighted];
        [item setImage:[UIImage imageNamed:self.SelectedImgs[index]] forState:UIControlStateSelected];
        [item addTarget:self action:@selector(itemDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return item;
}

#pragma mark - Chosen
- (void)itemDidClick:(UIButton *)sender {
    //当前选择的index
    self.selectedIndex = _currentItem.tag;
    //如果实现了代理方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
        //返回NO不操作
        if (![self.delegate tabBarController:self shouldSelectViewController:self.viewControllers[sender.tag]]) return;
    }
    //取消选中上一个tiem
    _currentItem.selected = !_currentItem.selected;
    //选中当前tiem
    sender.selected = !sender.selected;
    //设置新的选中tiem
    _currentItem = sender;
    //切换页面
    self.selectedIndex = sender.tag;
}

- (void)specialItemDidClick:(UIButton *)sender {
    id showVC = [[NSClassFromString(@"ShowViewController") alloc]init];
    [self presentViewController:showVC animated:YES completion:nil];
}

#pragma mark - Tabbar Control
- (void)setTabbarHidden:(BOOL)tabbarHidden {
    if (_tabbarHidden != tabbarHidden) {
        _tabbarHidden = tabbarHidden;
        if (tabbarHidden) {
            [UIView animateWithDuration:0.25 delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _customTabbar.x -= ScreenW;
            } completion:^(BOOL finished) {
                _customTabbar.hidden = tabbarHidden;
            }];
        }else {
            _customTabbar.hidden = tabbarHidden;
            [UIView animateWithDuration:0.25 delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _customTabbar.x += ScreenW;
            } completion:^(BOOL finished) {

            }];
        }
    }
}

- (void)selectedBarItemWithTag:(NSInteger)tag{
    //取消选中上一个tiem
    _currentItem.selected = !_currentItem.selected;
    //选中当前tiem
    UIButton *btn = [self.buttonItemArray objectAtIndex:tag];
    btn.selected = !btn.selected;
    //设置新的选中tiem
    _currentItem = btn;
    //切换页面
    self.selectedIndex = btn.tag;
}

@end
