//
//  SUPicRolling.m
//  PictureScrollDemo
//
//  Created by 万众科技 on 16/4/11.
//  Copyright © 2016年 万众科技. All rights reserved.
//

#import "SUPicRolling.h"
#import "SUPageControl.h"

#define SU_W self.bounds.size.width
#define SU_H self.bounds.size.height

@interface SUPicRolling ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIImageView  * leftImgView;
@property (nonatomic, strong) UIImageView  * middleImgView;
@property (nonatomic, strong) UIImageView  * rightImgView;
@property (nonatomic, strong) SUPageControl * pageControl;

@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, assign) float scrollInterval;

@property (nonatomic, strong) NSArray * picArray;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy)   NSString * pageIndicator;
@property (nonatomic, copy)   NSString * currentIndicator;

@property (nonatomic, copy)   handleImg handleBlock;
@property (nonatomic, copy)   clickImg clickBlock;

@end

@implementation SUPicRolling

- (instancetype)initWithFrame:(CGRect)frame
                     urlArray:(NSArray *)urlArray
               scrollInterval:(float)scrollInterval
                pageIndicator:(NSString *)pageIndicator
             currentIndicator:(NSString *)currentIndicator
                    handleImg:(handleImg)handleBlock
                     clickImg:(clickImg)clickBlock {
    
    if (self = [super initWithFrame:frame]) {
        self.picArray = urlArray;
        self.scrollInterval = scrollInterval;
        self.pageIndicator = pageIndicator;
        self.currentIndicator = currentIndicator;
        self.handleBlock = handleBlock;
        self.clickBlock = clickBlock;
        [self setupUI];
    }
    return self;
    
}

#pragma mark - 初始化
- (void)setupUI {
    //滚动视图
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    self.scrollView.contentSize = CGSizeMake(SU_W * 3, SU_H);
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentOffset = CGPointMake(SU_W, 0);
    [self addSubview:self.scrollView];
    
    //页面控制
    self.pageControl = [[SUPageControl alloc]initWithFrame:CGRectMake(0, SU_H-20, SU_W, 6) count:self.picArray.count pageIndicator:self.pageIndicator currentIndicator:self.currentIndicator];
    [self addSubview:self.pageControl];
    //图片初始化
    self.index = 0;
    self.leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(SU_W * 0, 0, SU_W, SU_H)];
    [self.scrollView addSubview:self.leftImgView];
    self.middleImgView = [[UIImageView alloc]initWithFrame:CGRectMake(SU_W * 1, 0, SU_W, SU_H)];
    [self.scrollView addSubview:self.middleImgView];
    self.rightImgView = [[UIImageView alloc]initWithFrame:CGRectMake(SU_W * 2, 0, SU_W, SU_H)];
    [self.scrollView addSubview:self.rightImgView];
    
    //点击手势
    self.middleImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImgAction)];
    [self.middleImgView addGestureRecognizer:tap];
    
    
    [self refreshPicShow];
    
    
    //如果只有一张图片:不滚动
    if (self.picArray.count <= 1) {
        self.scrollView.scrollEnabled = NO;
        self.pageControl.hidden = YES;
    }
    
    //定时器
    [self startRolling];
}

#pragma mark - 代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //当前X坐标值
    CGPoint point = scrollView.contentOffset;
    //滑动方向
    if (point.x > SU_W) self.index >= self.picArray.count - 1 ? self.index = 0 : self.index ++;
    if (point.x < SU_W) self.index <= 0 ? self.index = self.picArray.count - 1 : self.index --;
    [self refreshPicShow];
    //显示中间的图片
    [scrollView setContentOffset:CGPointMake(SU_W, 0) animated:NO];
    self.pageControl.currentIndex = self.index;
    [self startRolling];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopRolling];
}


#pragma mark - 刷新显示
- (void)refreshPicShow {
    if (!self.handleBlock) return;
    NSInteger leftIndex = self.index == 0 ? self.picArray.count - 1 : self.index - 1;
    NSInteger rightIndex = self.index == self.picArray.count - 1 ? 0 : self.index + 1;
    self.handleBlock(self.leftImgView, self.picArray[leftIndex]);
    self.handleBlock(self.middleImgView, self.picArray[self.index]);
    self.handleBlock(self.rightImgView, self.picArray[rightIndex]);
}

- (void)scrollPic {
    CGPoint point = self.scrollView.contentOffset;
    point.x += SU_W;
    [self.scrollView setContentOffset:point animated:YES];
}

#pragma mark - 定时器
- (void)startRolling {
    if (self.timer) return;
    if (self.scrollInterval <= 0) return;
    if (self.picArray.count <= 1) return;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollInterval target:self selector:@selector(scrollPic) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopRolling {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - 点击手势
- (void)clickImgAction{
    
    if (!self.clickBlock) return;
    
    self.clickBlock(self.index);
}

@end
