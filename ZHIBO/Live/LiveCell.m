//
//  LiveCell.m
//  ZHIBO
//
//  Created by 万众科技 on 16/7/27.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "LiveCell.h"
#import "WZHUB.h"
#import "LiveToolView.h"
#import <BarrageRenderer.h>

@interface LiveCell ()

@property (nonatomic, assign) BOOL shouldPlay;
@property (nonatomic, strong) IJKFFMoviePlayerController * player;

@property (nonatomic, strong) UIView * placeHolderView;
@property (nonatomic, strong) UIImageView * placeHolderImg;

@property (nonatomic, strong) LiveToolView * toolView;
@property (nonatomic, strong) CAEmitterLayer * emitterLayer;

@property (nonatomic, strong) BarrageRenderer * barrageRender;
@property (nonatomic, strong) NSArray * sprites;
@property (nonatomic, strong) NSTimer * renderTimer;

@end

@implementation LiveCell

- (void)setModel:(HotListModel *)model {
    _model = model;
    [self.placeHolderImg sd_setImageWithURL:[NSURL URLWithString:model.bigpic] placeholderImage:[UIImage imageNamed:@"placeholder_star"]];
    [self.contentView bringSubviewToFront:self.placeHolderView];
}

#pragma mark - Play Video
- (void)startPlay {
    self.shouldPlay = YES;
    [self performSelector:@selector(play) withObject:nil afterDelay:1.0];
}

- (void)play {
    if (self.shouldPlay && !self.player) {
        WZLog_INFO(@"开始播放");
        [self createPlayer];
        [self showLoadingAni];
    }else {
        WZLog_INFO(@"取消播放");
    }
}

- (void)stop {
    WZLog_INFO(@"取消播放");
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (self.player) {
        [self stopPlay];
    }
}

- (void)stopPlay {
    [self stopPlayer];
    self.shouldPlay = NO;
    self.toolView.hidden = YES;
    self.placeHolderView.hidden = NO;
    self.emitterLayer.hidden = YES;
    self.toolView = nil;
    self.emitterLayer = nil;
}

- (void)createPlayer {
    //配置选项
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1     forKey:@"videotoolbox"];
    [options setPlayerOptionIntValue:29.97 forKey:@"r"]; // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
    [options setPlayerOptionIntValue:256   forKey:@"vol"]; // -vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
    //播放器
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:self.model.flv withOptions:options];
    self.player.view.frame = self.contentView.bounds;
    self.player.scalingMode = IJKMPMovieScalingModeAspectFill;
    self.player.shouldAutoplay = NO;
    self.player.shouldShowHudView = NO;
    [self.contentView insertSubview:self.player.view atIndex:0];
    
    //观察者
    RegisterNotify(IJKMPMoviePlayerPlaybackDidFinishNotification, @selector(playbackDidFinish))  //播放结束
    RegisterNotify(IJKMPMoviePlayerLoadStateDidChangeNotification, @selector(loadStateDidChange)) //加载状态改变
    
    //准备播放
    [self.player prepareToPlay];
}

- (void)stopPlayer {
    [self.player shutdown];
    [self.player.view removeFromSuperview];
    self.player = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)loadStateDidChange {
    if ((self.player.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.player.isPlaying) {
            WZLog_INFO(@"开始播放");
            [self.player play];
            //1秒后移除封面图片、Loading提示，添加弹幕、烟花
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self hideLoadingAni];
                self.toolView.hidden = NO;
                self.placeHolderView.hidden = YES;
                self.emitterLayer.hidden = NO;
            });
        }else {
            WZLog_INFO(@"继续播放");
        }
    }else {
        WZLog_INFO(@"网络不畅");
    }
}

- (void)playbackDidFinish {
    WZLog_INFO(@"结束播放");
    //网络原因导致stalled，显示Loading提示
    
    //已结束直播，显示主播已离开
    
}

#pragma mark - 烟花
- (CAEmitterLayer *)emitterLayer {
    if (!_emitterLayer) {
        _emitterLayer = [CAEmitterLayer layer];
        _emitterLayer.emitterPosition = CGPointMake(ScreenW - 50, ScreenH - 50);
        _emitterLayer.emitterSize = CGSizeMake(50, 0);
//        _emitterLayer.renderMode = kCAEmitterLayerOutline;
//        _emitterLayer.emitterShape = kCAEmitterLayerLine;
//        _emitterLayer.renderMode = kCAEmitterLayerAdditive;
//        _emitterLayer.velocity = 1;
//        _emitterLayer.seed = (arc4random() % 100) + 1;
        NSMutableArray * cellArray = [NSMutableArray array];
        for (NSInteger i = 1; i < 10; i ++) {
            CAEmitterCell * cell = [CAEmitterCell emitterCell];
            cell.birthRate = (10 + arc4random() % 10) / 10;
            cell.lifetime = arc4random() % 3 + 2;
            cell.lifetimeRange = 0.8;
            cell.contents = (id)[UIImage imageNamed:[NSString stringWithFormat:@"emitter_%ld", i]].CGImage;
            cell.velocity = arc4random() % 100 + 50;
            cell.velocityRange = 20;
            cell.emissionLongitude = M_PI_2 * 3;
            cell.emissionRange = M_PI_2 / 6;
            cell.scale = 0.6;
            [cellArray addObject:cell];
        }
        _emitterLayer.emitterCells = cellArray;
        [self.contentView.layer insertSublayer:_emitterLayer above:self.toolView.layer];
    }
    return _emitterLayer;
}

#pragma mark - 弹幕
- (BarrageRenderer *)barrageRender {
    if (!_barrageRender) {
        _barrageRender = [[BarrageRenderer alloc]init];
        _barrageRender.canvasMargin = UIEdgeInsetsMake(200, 10, 10, 10);
        [self.contentView addSubview:_barrageRender.view];
        
        _renderTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(sendBarrage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_renderTimer forMode:NSRunLoopCommonModes];
    }
    return _barrageRender;
}

- (void)sendBarrage {
    NSInteger totalSprites = [_barrageRender spritesNumberWithName:nil];
    if (totalSprites <= 20) {
        BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
        descriptor.spriteName = NSStringFromClass([BarrageWalkTextSprite class]);;
        descriptor.params[@"text"] = self.sprites[arc4random() % self.sprites.count];
        descriptor.params[@"textColor"] = RGBColor(arc4random() % 255, arc4random() % 255, arc4random() % 255);
        descriptor.params[@"speed"] = @(80);
        descriptor.params[@"direction"] = @(BarrageWalkDirectionR2L);
        [_barrageRender receive:descriptor];
    }
}

- (NSArray *)sprites {
    if (!_sprites) {
        _sprites = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"sprites" ofType:@"plist"]];
    }
    return _sprites;
}

#pragma mark - 关联主播


#pragma mark - 主播信息 & 观众列表


#pragma mark - 相关主播


#pragma mark - 底部工具
- (LiveToolView *)toolView {
    if (!_toolView) {
        WEAKSELF
        _toolView = [[LiveToolView alloc]init];
        [_toolView setChooseBlock:^(LiveTool liveTool) {
            switch (liveTool) {
                case LiveToolPublic:
                    if (weakSelf.barrageRender.view.hidden) {
                        [weakSelf.barrageRender start];
                        weakSelf.barrageRender.view.hidden = NO;
                    }else {
                        [weakSelf.barrageRender stop];
                        weakSelf.barrageRender.view.hidden = YES;
                    }
                    NSLog(@"弹幕");
                    break;
                case LiveToolPrivate:
                    NSLog(@"私聊");
                    break;
                case LiveToolGift:
                    NSLog(@"礼物");
                    break;
                case LiveToolRank:
                    NSLog(@"排名");
                    break;
                case LiveToolShare:
                    NSLog(@"分享");
                    break;
                case LiveToolClose:
                    NSLog(@"关闭");
                    if (weakSelf.actionCallback) {
                        weakSelf.actionCallback(ActionTypeClose);
                    }
                    break;
                default:
                    break;
            }
        }];
        [weakSelf.contentView insertSubview:_toolView aboveSubview:weakSelf.placeHolderView];
    }
    return _toolView;
}

#pragma mark - PlaceHolder View
- (UIView *)placeHolderView {
    if (!_placeHolderView) {
        _placeHolderView = [[UIView alloc]initWithFrame:ScreenB];
        [self.contentView addSubview:_placeHolderView];
        //玻璃效果
        UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView * effe = [[UIVisualEffectView alloc]initWithEffect:blur];
        effe.alpha = 1.0;
        effe.frame = _placeHolderView.bounds;
        [_placeHolderView addSubview:effe];
    }
    return _placeHolderView;
}

- (UIImageView *)placeHolderImg {
    if (!_placeHolderImg) {
        _placeHolderImg = [[UIImageView alloc]initWithFrame:self.placeHolderView.bounds];
        _placeHolderImg.contentMode = UIViewContentModeScaleAspectFill;
        [self.placeHolderView insertSubview:_placeHolderImg atIndex:0];
    }
    return _placeHolderImg;
}



@end
