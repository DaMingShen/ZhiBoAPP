//
//  ShowViewController.m
//  ZHIBO
//
//  Created by 万众科技 on 16/7/28.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "ShowViewController.h"

@interface ShowViewController ()<LFLiveSessionDelegate>

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *startShowBtn;

@property (nonatomic, strong) LFLiveSession * session;

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (LFLiveSession*)session {
    if (!_session) {
        _session = [[LFLiveSession alloc]initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration] liveType:LFLiveRTMP];
        _session.running = YES;
        _session.preView = self.view;
        _session.delegate = self;
    }
    return _session;
}


- (IBAction)startShow:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        LFLiveStreamInfo *streamInfo = [LFLiveStreamInfo new];
        streamInfo.url = @"rtmp://172.20.13.31:1935/rtmplive/room";
        [self.session startLive:streamInfo];
    }else {
        [self.session stopLive];
    }
}

- (IBAction)beautifulFaceSwitch:(UIButton *)sender {
    sender.selected = !sender.selected;
    _session.beautyFace = !_session.beautyFace;
}

- (IBAction)cameraSwitch:(UIButton *)sender {
    _session.captureDevicePosition = _session.captureDevicePosition == AVCaptureDevicePositionBack ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
}

- (IBAction)closeShow:(UIButton *)sender {
    if (!_session) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self.session stopLive];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
//    if (self.session.state == LFLivePending || self.session.state == LFLiveStart) {
//
//    }
    
}

#pragma mark - LFLiveSessionDelegate
- (void)liveSession:(LFLiveSession *)session liveStateDidChange:(LFLiveState)state {
    NSString * hints = nil;
    switch (state) {
        case LFLiveReady:
            hints = @"准备中";
            break;
        case LFLivePending:
            hints = @"连接中";
            break;
        case LFLiveStart:
            hints = @"已连接";
            break;
        case LFLiveStop:
            hints = @"已断开";
            break;
        case LFLiveError:
            hints = @"连接出错";
            break;
        default:
            hints = @"未知状态";
            break;
    }
    self.statusLabel.text = [NSString stringWithFormat:@"状态: %@", hints];
}

@end
