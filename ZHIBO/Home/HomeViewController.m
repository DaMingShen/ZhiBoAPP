//
//  HomeViewController.m
//  ZHIBO
//
//  Created by 万众科技 on 16/7/26.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "HomeViewController.h"
#import "SUTopMenuView.h"
#import "NewViewController.h"
#import "HotViewController.h"
#import "FocusViewController.h"

@interface HomeViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) SUTopMenuView * topMenuView;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) NewViewController * starNew;
@property (nonatomic, strong) HotViewController * starHot;
@property (nonatomic, strong) FocusViewController * starFocus;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTopMenuView];
    [self loadScrollView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.topMenuView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.topMenuView.hidden = NO;
}

#pragma mark - Load View
- (void)loadTopMenuView {
    WEAKSELF
    self.topMenuView = [SUTopMenuView topMenuView];
    [self.topMenuView setChosenBlock:^(TopMenu menu) {
        [weakSelf.scrollView setContentOffset:CGPointMake(ScreenW * menu, 0) animated:YES];
    }];
    [self.navigationController.navigationBar addSubview:self.topMenuView];
}

- (void)loadScrollView {
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(ScreenW * 3, ScreenH);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    self.starHot = [[HotViewController alloc]init];
    self.starHot.view.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    [self addChildViewController:self.starHot];
    [self.scrollView addSubview:self.starHot.view];
    
    self.starNew = [[NewViewController alloc]init];
    self.starNew.view.frame = CGRectMake(ScreenW, 0, ScreenW, ScreenH);
    [self addChildViewController:self.starNew];
    [self.scrollView addSubview:self.starNew.view];

    self.starFocus = [[FocusViewController alloc]init];
    self.starFocus.view.frame = CGRectMake(ScreenW * 2, 0, ScreenW, ScreenH);
    [self addChildViewController:self.starFocus];
    [self.scrollView addSubview:self.starFocus.view];
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat progress = scrollView.contentOffset.x / scrollView.contentSize.width;
    self.topMenuView.underLineProgress = progress;
}




@end
