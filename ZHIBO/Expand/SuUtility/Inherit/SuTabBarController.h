//
//  SuTabBarController.h
//  tabbartest
//
//  Created by KevinSu on 15/11/4.
//  Copyright (c) 2015年 SuXiaoMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuTabBarController : UITabBarController

@property (nonatomic, strong) NSArray * VCs;
@property (nonatomic, strong) NSArray * Titles;
@property (nonatomic, strong) NSArray * Imgs;
@property (nonatomic, strong) NSArray * SelectedImgs;
@property (nonatomic, strong) UIView * customTabbar;
@property (nonatomic, assign) BOOL tabbarHidden;
@property (nonatomic, strong) NSMutableArray * msgTitleArray;
@property (nonatomic, strong) NSMutableArray * buttonItemArray;

//VCs必须有两个Obj
- (void)creatCustomTabbar;

//设置当前选择的tab
- (void)selectedBarItemWithTag:(NSInteger)tag;

@end
