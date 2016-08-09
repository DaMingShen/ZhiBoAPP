//
//  LiveViewController.m
//  ZHIBO
//
//  Created by 万众科技 on 16/7/26.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "LiveViewController.h"
#import "LiveCell.h"
#import "SUTableView.h"

static NSString * liveCellID = @"liveCell";

@interface LiveViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) LiveCell * willDisplayCell;

@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    if (self.currentIndex > 0) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.willDisplayCell startPlay];
}

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[SUTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.pagingEnabled = YES;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[LiveCell class] forCellReuseIdentifier:liveCellID];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LiveCell * cell = [self.tableView dequeueReusableCellWithIdentifier:liveCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [self.stars objectAtIndex:indexPath.row];
    WEAKSELF
    [cell setActionCallback:^(ActionType actionType) {
        switch (actionType) {
            case ActionTypeClose:
                [weakSelf.willDisplayCell stop];
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
                break;
            default:
                break;
        }
    }];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ScreenH;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    self.willDisplayCell = (LiveCell *)cell;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (cell != self.willDisplayCell) {
        [(LiveCell *)cell stop];
        [self.willDisplayCell startPlay];
    }
}

@end
