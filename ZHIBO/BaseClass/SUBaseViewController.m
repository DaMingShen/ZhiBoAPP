//
//  ViewController.m
//  ZHIBO
//
//  Created by 万众科技 on 16/7/26.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "SUBaseViewController.h"

@interface SUBaseViewController ()

@end

@implementation SUBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    [self setupNav];
}

#pragma mark - Nav
- (void)setupNav {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    //当Bar不透明时，视图延伸至Bar所在区域
    self.extendedLayoutIncludesOpaqueBars = YES;
    //导航栏背景色
    self.navigationController.navigationBar.barTintColor = WZBaseColor;
    self.navigationController.navigationBar.tintColor = WhiteColor;
    //设置标题颜色为白色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:19.0]}];
    //设置状态栏颜色（去info.plist文件里面设置View controller–based status bar appearance 为NO）
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //隐藏导航栏下面的线
    [SuImageView findHairlineImageViewUnder:self.navigationController.navigationBar].hidden = YES;
    //隐藏返回按钮
    self.navigationItem.hidesBackButton = YES;
    //自定义返回按钮
    if (self.navigationController.viewControllers.count > 1) {
        [self setNavigationLeft:@"Public_btn_back" sel:@selector(popAction:)];
    }
}

#pragma mark - override Back Button
- (void)popAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Nav Button
- (UIButton *)setNavigationLeft:(NSString *)imageName sel:(SEL)sel {
    UIButton * leftBtn = [SuButton createButtonWithFrame:CGRectMake(0, 0, 44, 44) Target:self Selector:sel ForgroundImage:imageName ForgroundImageSelected:imageName];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = item;
    return leftBtn;
}

- (UIButton *)setNavigationRight:(NSString *)imageName sel:(SEL)sel {
    UIButton * rightBtn = [SuButton createButtonWithFrame:CGRectMake(0, 0, 44, 44) Target:self Selector:sel ForgroundImage:imageName ForgroundImageSelected:imageName];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -15)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item;
    return rightBtn;
}

- (UIButton *)setNavigationRightButton:(NSString *)btnName sel:(SEL)sel {
    UIButton * rightBtn = [SuButton createButtonWithFrame:CGRectMake(0, 0, 44, 44) Title:btnName FontSize:15 Color:WhiteColor Target:self Selector:sel];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item;
    return rightBtn;
}

@end
