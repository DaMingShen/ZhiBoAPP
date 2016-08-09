//
//  HotViewController.m
//  ZHIBO
//
//  Created by 万众科技 on 16/7/26.
//  Copyright © 2016年 WanZhong. All rights reserved.
//

#import "HotViewController.h"
#import "HotListCell.h"
#import "LiveViewController.h"

static NSString * hotListCellID = @"hotListCell";
const CGFloat hotListCellHeadHeight = 42.0;

@interface HotViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * stars;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, WZNavHeight, ScreenW, ScreenH - WZNavHeight - WZTabbarHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollsToTop = YES;
        [_tableView registerNib:[UINib nibWithNibName:@"HotListCell" bundle:nil] forCellReuseIdentifier:hotListCellID];;
        WEAKSELF
        [_tableView addRefreshHeader:^{
            [weakSelf fetchHotListWithRefresh:YES];
        } footer:^{
            [weakSelf fetchHotListWithRefresh:NO];
        }];
        [_tableView.header beginRefreshing];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.stars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotListCell * cell = [self.tableView dequeueReusableCellWithIdentifier:hotListCellID];
    HotListModel * model = [self.stars objectAtIndex:indexPath.section];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hotListCellHeadHeight + ScreenW;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        LiveViewController * liveVC = [[LiveViewController alloc]init];
        liveVC.stars = self.stars;
        liveVC.currentIndex = indexPath.section;
        [self presentViewController:liveVC animated:YES completion:nil];
    });
}

#pragma mark - Fetch Data
- (void)fetchHotListWithRefresh:(BOOL)refresh {
    [WZOperation GET:[NSString stringWithFormat:@"http://live.9158.com/Fans/GetHotLive?page=%ld", refresh ? 1 : self.currentPage + 1] success:^(id data) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        if (refresh) {
            self.currentPage = 1;
            self.stars = [HotListModel modelArrayFromDictArray:[((NSDictionary *)data) objectForKey:@"list"]].mutableCopy;
            self.tableView.footer.hidden = NO;
        }else {
            self.currentPage ++;
            [self.stars addObjectsFromArray:[HotListModel modelArrayFromDictArray:[((NSDictionary *)data) objectForKey:@"list"]]];
        }
        [self.tableView reloadData];
    } failure:^(NSString *msg, NSError *error) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        WZLog_INFO(msg);
    }];
}


@end
